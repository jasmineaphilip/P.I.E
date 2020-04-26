import socket
import threading	
import datetime
import time
import argparse
import cv2
import itertools
import numpy as np
import openface
import os
import firebase_admin
from firebase_admin import credentials
from firebase_admin import auth
import PIL
from PIL import Image
from PIL import ImageFile
import piexif
from packet import *
import db
import Queue
import hashlib
from os import path
from wordcloud import WordCloud
import matplotlib.pyplot as plt



ImageFile.LOAD_TRUNCATED_IMAGES = True


### Hazardous things we are intentionally not addressing ###
#
# 1. not checking if our writeDB operations are actually going through
# 		a. We are just sending them off to the writeDB thread
#		b. can potentially cause serious errors if a write operation fails or stalls for too long
# 2. 


### Init Our Firebase Admin SDK ###
cred = credentials.Certificate("/root/pie-auth-firebase-adminsdk-4rbmo-2d6c76da9f.json")
firebase_admin.initialize_app(cred)
###################################

# Currently active sessions {class_id: session_id}
active_sessions = {}

class Client:
	def __init__(self, addr, id_token, uid):
		self.addr=addr
		self.uid=uid
		self.id_token=id_token


PACKET_SIZE = 2048
DB_QUEUE_DELIMITER = "|"
clients = []	
public_ip = "172.17.0.2"

# Port for receiving commands from clients
command_port = 25595

# These are the ports available for receiving images and their availability (i.e. if they are not currently in use)
image_ports = {25585:True, 25586:True, 25587:True, 25588:True, 25589:True}

command_socket = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
running = True
db_write_queue = Queue.Queue()
db_command_avail = threading.Event()

modelDir = "/root/openface/models/"
dlibModelDir = os.path.join(modelDir, 'dlib')
openfaceModelDir = os.path.join(modelDir, 'openface')
imgDim = 96
align = openface.AlignDlib(os.path.join(dlibModelDir, "shape_predictor_68_face_landmarks.dat"))
net = openface.TorchNeuralNet(os.path.join(openfaceModelDir, 'nn4.small2.v1.t7'), imgDim)
def getRep(imgPath):
    
    bgrImg = cv2.imread(imgPath)
    if bgrImg is None:
        raise Exception("Unable to load image: {}".format(imgPath))
    rgbImg = cv2.cvtColor(bgrImg, cv2.COLOR_BGR2RGB)

    start = time.time()
    bb = align.getLargestFaceBoundingBox(rgbImg)
    if bb is None:
        raise Exception("Unable to find a face: {}".format(imgPath))
  
    print("  + Face detection took {} seconds.".format(time.time() - start))

    start = time.time()
    alignedFace = align.align(imgDim, rgbImg, bb,
                              landmarkIndices=openface.AlignDlib.OUTER_EYES_AND_NOSE)
    if alignedFace is None:
        raise Exception("Unable to align image: {}".format(imgPath))

    start = time.time()
    rep = net.forward(alignedFace)
    #print("  + OpenFace forward pass took {} seconds.".format(time.time() - start))
    #print("Representation:")
    #print(rep)
    #print("-----\n")
    return rep


try:
	command_socket.bind((public_ip, command_port))
except socket.error as err:
	print('Bind failed. Error Code : ' .format(err))
	
	
# NOTE!!!!! We 100% should be doing this client side, just doing this here for sake of demo
def scale_image(path):
	max_size = 1024, 1024
	image = Image.open(path)
	exif_dict = piexif.load(image.info["exif"])
	orientation = exif_dict["0th"][piexif.ImageIFD.Orientation]
	if orientation == 3 :
		image=image.rotate(180, expand=True)
	elif orientation == 6 :
		image=image.rotate(270, expand=True)
	elif orientation == 8 :
		image=image.rotate(90, expand=True)
	image.thumbnail(max_size)
	image.save(path)

def writeDB(*args):
	db_write_queue.put(args)
	db_command_avail.set()

def extract_features(path, uid):
	profile_path = "/root/userdata/"+uid+"/"
	if (not os.path.exists(profile_path)):
		os.mkdir(profile_path)
		
	full_path = profile_path+str(len(os.listdir(profile_path)))+".txt"
	
	print ("Extracting feature data.")
	feats = np.asarray(getRep(path))
	f = open(full_path, "w+")
	for fe in feats:
		f.write(str(fe)+"\n");
	f.close()
	os.remove(path)

def compare(uid, path):
	profile_path = "/root/userdata/"+uid+"/"
	for j in range(len(os.listdir(profile_path))):
		full_path = profile_path+str(j)+".txt"
		a1 = np.zeros(128)
		f = open(full_path, "r")
		i = 0
		for x in f:
			a1[i]=float(x)
			i+=1
		f.close()
		a2 = getRep(path)
		sq_dist = np.dot((a1-a2),(a1-a2))
		
		if (sq_dist <= 1):
			os.remove(path)
			return 1
		else:
			continue
	os.remove(path)
	return 0
	
def client_recv_image(image_port, uid):
	
	s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
	try:
		s.bind((public_ip, image_port))
	except socket.error as err:
		print('Bind failed. Error Code : ' .format(err))
	
	s.listen(10)
	(client, addr) = s.accept()
	
	path = "/root/userdata/temp/"+uid+".jpg"
	data = client.recv(1024)
	print ("Receiving image. Saving to " + path)
	while (data):
		f = open(path, 'ab+')
		f.write(data)
		data = client.recv(1024)
	
	scale_image(path)
	s.close()
	image_ports[image_port] = True
	
	return path
	
	#first = auth.get_user(uid).display_name.split(" ")[0]
	#last = auth.get_user(uid).display_name.split(" ")[1]
	#db.insertProfile(uid, first, last, "instructor", "yes", "")
	
def image_signup(image_port, uid, addr):
	path = client_recv_image(image_port, uid)
	extract_features(path, uid)
	
	returnPacket = Packet(IMAGE_RESPONSE)
	print (auth.get_user(uid).display_name + " added an image to their profile.")
	command_socket.sendto(returnPacket.formatData("Image Received"), addr)

def image_signin(image_port, uid, addr): #updated to check current states
    path = client_recv_image(image_port, uid)
    passed = compare(uid, path)
    returnPacket = Packet(IMAGE_RESPONSE)
    #check current status of users attendance
    currAttendance = db.getAttendanceResult(sessionID, uid)
    if(passed):
        print (auth.get_user(uid).display_name + " successfully signed in.")
        command_socket.sendto(returnPacket.formatData("Facial verificatin: Successful!"), addr)
        if (currAttendance == 0):
        #set value to 1 for facial rec
            writeDB(db.updateAttendanceResult, sessionID, uid, 1) 
        elif (currAttendance == 2):
            #facial and nfc both done, update val to 3
            writeDB(db.updateAttendanceResult, sessionID, uid, 3)
    else:
        print (auth.get_user(uid).display_name + " failed to signed in.")
        command_socket.sendto(returnPacket.formatData("Failed"), addr)

#KEYWORD EXTRACTRION

def getAllFeedback(filename):
    f = open(filename, "r")
    lines = f.readlines()
    feedbackArray = []
    for line in lines:
        feedbackArray.append(line) 
    f.close()

def getKeywords(filename,session_id):
    #define filename for simplicity
    phrases_filename = str(session_id) + "_phrases.txt"

    #first run phrases.py and store result in [session_id]_phrases.txt
    os.system("python3 phrases.py " + filename + " > " + phrases_filename) 
    #result is an array converted to string
    f = open(phrases_filename, "r")
    line = f.readline()
    keywords = line.replace("\n","").split(',')
    return keywords #return array of key phrases

def getWordcloud(filename,session_id):
    wordcloud_image = session_id + ".jpg"
    #make cloud
    text = open(path.join(filename)).read()
    wordcloud = WordCloud().generate(text)  
    wordcloud.to_file(wordcloud_image)
    return wordcloud_image

#ATTENDANCE STUFF
def generate_key(): 
    newKey = hashlib.sha256().hexdigest()
    return newKey

def getOpenImagePort():
	while (1):
		for port in image_ports:
			if image_ports[port] == True:
				image_ports[port] = False
				return port
	
def getClientFromIDToken(id_token):
	for c in clients:
		if c.id_token == id_token:
			return c
	return None
	
def getUIDFromToken(id_token):
	decoded_token = auth.verify_id_token(id_token)
	#determine if decoding failed and send INVALID_TOKEN back (make sure to set uid to something so that we know to *continue* the while loop)
	#might have to catch an exception
	uid = decoded_token['uid']
	return uid

def getFirstLastNameFromUID(uid):
	return auth.get_user(uid).display_name.split(" ")
	
def db_write_operations():
	#db.init()
	while (running):
		db_command_avail.wait()
		while (not db_write_queue.empty()):
			command = db_write_queue.get()
			func = command[0]
			args = command[1:]
			func(*args)
		db_command_avail.clear()

def client_accept():
	while (running):
		(raw_data, addr) = command_socket.recvfrom(PACKET_SIZE)
		packetID = getPacketID(raw_data)
		id_token = getIDToken(raw_data)
		data = getData(raw_data)
		uid = getUIDFromToken(id_token)
			
		if (DATA_DELIMITER in data):
			data_entries = getPacketDataEntries(data)
		
		returnPacket = Packet(packetID)
		
		if (packetID == JOIN):
			print ("Client at {} connected with uid: {}".format(addr, uid))
			if (db.profileExists(uid)):
				clients.append(Client(addr, id_token, uid))
				command_socket.sendto(returnPacket.formatData("Join Success"), addr)
			else:
				signupPacket = Packet(SIGNUP)
				names = getFirstLastNameFromUID(uid)
				command_socket.sendto(signupPacket.formatData("You have not registered with our service yet, please follow the sign up process.", names[0], names[1]), addr)
		elif (packetID == SIGNUP):
			# data entries: first_name, last_name, role, accessability_access
			writeDB(db.insertProfile, uid, data_entries[0], data_entries[1], data_entries[2], data_entries[3], "")
			joinSuccessPacket = Packet(JOIN)
			command_socket.sendto(joinSuccessPacket.formatData("Join Success"), addr)
		
		#elif (packetID == LEAVE):
		#TODO - close connection			

		elif (packetID == IMAGE_SIGNUP):
			image_port = getOpenImagePort()
			command_socket.sendto(returnPacket.formatData(image_port), addr)
			t = threading.Thread(target=image_signup, args=(image_port, uid, addr))
			t.start()
			
		elif (packetID == ADD_CLASS):
			if db.getType(uid) == db.INSTRUCTOR:
				class_id = data_entries[0]
				writeDB(db.addClass(class_id, uid))
				print (auth.get_user(uid).display_name + " added class " + class_id + " to database.")
				command_socket.sendto(returnPacket.formatData("Added class " + class_id + " to database."), addr)
			else:
				command_socket.sendto(returnPacket.formatData("You are not an instructor!"), addr)

		elif (packetID == GET_CLASS_INFO): #returns instructor
			classID = data_entries[0]
			result = db.getIntructors(classID) 
			instructor = result[0]
			command_socket.sendto(returnPacket.formatData(instructor), addr)

		elif (packetID == JOIN_CLASS): #will update classes table to add more students
			classID = data_entries[0]
			writeDB(db.joinClass, classID, uid) 
			command_socket.sendto(returnPacket.formatData("Successfully joined class!"), addr)

		elif (packetID == CREATE_SESSION):
			class_id = data_entries[0]
			instructors = db.getInstructors(class_id)
			if (uid in instructors):
				if (class_id in active_sessions):
					command_socket.sendto(returnPacket.formatData("A session for this class is already running!"), addr)
				else:
					writeDB(db.createSession, class_id)
					command_socket.sendto(returnPacket.formatData("Created a new session for " + class_id + "!"), addr)
			else:
				command_socket.sendto(returnPacket.formatData("You are not an instructor for this class!"), addr)
		
		elif (packetID == GET_SESSIONS): #returns all session associated to class
			classID = data_entries[0]
			sessions = db.getSessions(classID)
			command_socket.sendto(returnPacket.formatData(tuple(sessions)), addr)

		elif (packetID == JOIN_SESSION):
			classID = data_entries[0]
			sessionID = data_entries[1]
			#check if session still active
			if (classID in active_sessions):
				writeDB(db.joinSession, sessionID, uid)  #create session instance in db
				command_socket.sendto(returnPacket.formatData("Please continue signing in."), addr)
			else:
				command_socket.sendto(returnPacket.formatData("Session does not exist!"), addr)
		
		elif (packetID == GET_SESSION_PARTICIPANTS): #returns list of all participants in session
			sessionID = data_entries[0] 
			students = db.sessionParticipants(sessionID)
			command_socket.sendto(returnPacket.formatData(tuple(students)), addr) 
		
		elif (packetID == NFC_SIGNIN): #return 0 or 1 for pass fail
			sessionID = data_entries[0]
			key = data_entries[1]
			currKey = db.getKey(sessionID)
			if (key == currKey): #current keys match, generate new key and see i
				newKey = generate_key()
				writeDB(db.updateKey, sessionID, newKey) 
				#check current status of users attendance
				currAttendance = db.getAttendanceResult(sessionID, uid)
				if (currAttendance == 0):
					#set value to 2 for nfc
					writeDB(db.updateAttendanceResult, sessionID, uid, 2) 
				elif (currAttendance == 1):
					#facial and nfc both done, update val to 3
					writeDB(db.updateAttendanceResult, sessionID, uid, 3)  

				command_socket.sendto(returnPacket.formatData("NFC: Successful!"), addr)
			else: 
				command_socket.sendto(returnPacket.formatData("Error: Keys don't match!"), addr)

		elif (packetID == IMAGE_SIGNIN):
			image_port = getOpenImagePort()
			command_socket.sendto(returnPacket.formatData(image_port), addr)
			t = threading.Thread(target=image_signin, args=(image_port, uid, addr))
			t.start()
			
		elif (packetID == CONFIRM_SIGNIN): 
			sessionID = data_entries[0]
			currAttendance = db.getAttendanceResult(sessionID, uid)
			if (currAttendance == 0):
				command_socket.sendto(returnPacket.formatData("Please start the attendance process."), addr)
			elif (currAttendance == 1):
				command_socket.sendto(returnPacket.formatData("Please complete the NFC sign-in."), addr)
			elif (currAttendance == 2):
				command_socket.sendto(returnPacket.formatData("Please complete the facial authentication sign-in."), addr)
			else:
				command_socket.sendto(returnPacket.formatData("You have successfully joined the session!"), addr)
				
		elif (packetID == ADD_FEEDBACK):
			# addFeedback(uid, session_id, desc)
			#session_id = 2394 # getCurrentSession(uid)
			
			#TODO DID BY PRIYA:
			session_id = data_entries[0]
			description = data_entries[1]
			writeDB(db.addFeedback, uid, session_id, "example feedback_type", description)
			
			print (auth.get_user(uid).display_name + " sent feedback for session " + str(session_id) +".")
			command_socket.sendto(returnPacket.formatData("Added feedback for this session!"), addr)
		
		elif (packetID == GET_FEEDBACK): #returns keyword array #TODO need to work with jman and radhe 
			sessionID = data_entries[0]
			rawFile = db.getFeedback(sessionID)
			keywords = getKeywords(rawFile,sessionID) 
			command_socket.sendto(returnPacket.formatData(tuple(keywords)), addr)

		elif (packetID == CREATE_GROUP):
			#createGroupSession(uid, date/time, duration, location, other_netids)
			time = data_entries[0]
			location = data_entries[1]
			duration = data_entries[2]
			other_netids = data_entries[3]
			
			#TODO DID BY PRIYA
			writeDB(db.createStudyGroup, uid, time, duration, location, other_netids)
			
			print (auth.get_user(uid).display_name + " created a group session on {} at {}.".format(time, location))
			command_socket.sendto(returnPacket.formatData("Created a group session on {} at {}.".format(time, location)), addr)
		
		elif (packetID == SHOW_STUDYGROUPS): #returns array of group ids
  			groups = db.showStudyGroups()
			command_socket.sendto(returnPacket.formatData(tuple(groups)), addr)
		
		elif (packetID == REPORT_ISSUE):
			issue_type = data_entries[0]
			desc = data_entries[1]
			writeDB(db.addIssue, uid, issue_type, desc)
			print ("Received issue report from " + auth.get_user(uid).display_name + ".")
			command_socket.sendto(returnPacket.formatData("The issue has been reported, thank you!"), addr)	
				
		elif (packetID == STOP_SESSION):
			classID = data_entries[0]
			del active_sessions[classID]
			command_socket.sendto(returnPacket.formatData("Session ended."), addr)

		

	db.conn.close()
		

com = ""
stopping = False
print("\n")
while (not(com=="quit")):
	com = raw_input("")
	print("\n")
	
	client_accept_thread = threading.Thread(target=client_accept)
	client_accept_thread.daemon = True
	db_write_operations_thread = threading.Thread(target=db_write_operations)
	db_write_operations_thread.daemon = True
	
	if (com == "start"):
		db.init()
		client_accept_thread.start()
		db_write_operations_thread.start()
		
	if (com == "quit"):
		command_socket.close()
		running = False
		