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

ImageFile.LOAD_TRUNCATED_IMAGES = True

### Init Our Firebase Admin SDK ###
cred = credentials.Certificate("/root/pie-auth-firebase-adminsdk-4rbmo-2d6c76da9f.json")
firebase_admin.initialize_app(cred)
###################################

PACKET_SIZE = 2048

class Client:
	def __init__(self, addr, id_token, uid):
		self.addr=addr
		self.uid=uid
		self.id_token=id_token

clients = []
		
public_ip = "172.17.0.2"

# Port for receiving commands from clients
command_port = 25595

# These are the ports available for receiving images and their availability (i.e. if they are not currently in use)
image_ports = {25585:True, 25586:True, 25587:True, 25588:True, 25589:True}

command_socket = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)


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
	max_size = 512, 512
	image = Image.open(path)
	exif_dict = piexif.load(image.info["exif"])
	orientation = exif_dict["0th"][piexif.ImageIFD.Orientation]
	if   orientation == 3 :
		image=image.rotate(180, expand=True)
	elif orientation == 6 :
		image=image.rotate(270, expand=True)
	elif orientation == 8 :
		image=image.rotate(90, expand=True)
	image.thumbnail(max_size)
	image.save(path)


def client_recv_image(image_port, uid):
	
	s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
	try:
		s.bind((public_ip, image_port))
	except socket.error as err:
		print('Bind failed. Error Code : ' .format(err))
	
	s.listen(10)
	(client, addr) = s.accept()
	
	image_stamp = "/root/userdata/temp/"+uid
	data = client.recv(1024)
	print ("Receiving image. Saving to " + image_stamp+".jpg")
	while (data):
		f = open(image_stamp+".jpg", 'ab+')
		f.write(data)
		data = client.recv(1024)
	
	scale_image(image_stamp+".jpg")
	
	feat_stamp = "/root/userdata/"+uid
	print ("Extracting feature data.")
	feats = np.asarray(getRep(image_stamp+".jpg"))
	f = open(feat_stamp+".txt", "w+")
	for fe in feats:
		f.write(str(fe)+"\n");
	f.close()
	
	s.close()
	
	image_ports[image_port] = True
	
	os.remove(image_stamp+".jpg")
		
def lookUpUID(sessionID):
	# TODO look up UID in database given the sessionID
	return sessionID
	
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
	uid = decoded_token['uid']
	return uid
	
def client_accept():
	while (1):
		(raw_data, addr) = command_socket.recvfrom(PACKET_SIZE)
		packetID = getPacketID(raw_data)
		id_token = getIDToken(raw_data)
		data = getData(raw_data)
		
		uid = getUIDFromToken(id_token)
				
		returnPacket = Packet(packetID)
		
		if (packetID == JOIN):
			clients.append(Client(addr, id_token, uid))
			print ("Client at {} joined with uid: {}".format(addr, uid))
			command_socket.sendto(returnPacket.formatData("Join Success"), addr)
		elif (packetID == IMAGE_SIGNUP):
			image_port = getOpenImagePort()
			command_socket.sendto(returnPacket.formatData(image_port), addr)
			t = threading.Thread(target=client_recv_image, args=(image_port, uid))
			t.start();
		elif (packetID == ADD_CLASS):
			# check if user is an instructor
			# if getRole(UID) != instructor then send returnPacket back with failure and continue;
			class_id = getPacketDataEntries()[0]
			# addClass(class_id, uid)
			command_socket.sendto(returnPacket.formatData("Added class " + class_id + " to database."), addr)
		elif (packetID == CREATE_SESSION):
			# check if user is an instructor for this specific class
			# check if a session already exists
			# createSession(class_id)
			command_socket.sendto(returnPacket.formatData("Created a new session!"), addr)
		elif (packetID == JOIN_SESSION):
			# check if user is fully authenticated (face rec + nfc)
			# joinSession(session_id, uid)
			command_socket.sendto(returnPacket.formatData("Successfully joined session!"), addr)
		elif (packetID == ADD_FEEDBACK):
			# addFeedback(uid, session_id, desc)
			command_socket.sendto(returnPacket.formatData("Added feedback for this session!"), addr)
		elif (packetID == CREATE_GROUPSESSION):
			# createGroupSession(uid, date/time, duration, location, other_uids)
			command_socket.sendto(returnPacket.formatData("Created a group session on {} at {}.".format(time, location), addr))
		elif (packetID == REPORT_ISSUE):
			entries = getPacketDataEntries()
			type = entries[0]
			description = entries[1]
			# addIssueReport(uid, type, desc)
			command_socket.sendto(returnPacket.formatData("Issue has been reported, thank you!"), addr)
		

com = ""
stopping = False
while (not(com=="quit")):
	com = raw_input("Command:  ")
	t = threading.Thread(target=client_accept)
	t.daemon = True
	if (com == "start"):
		t.start()
	if (com == "quit"):
		command_socket.close()