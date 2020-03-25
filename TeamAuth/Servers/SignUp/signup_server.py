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


### Packet IDS ###
# Packet format:  packet_id,session_id,data 

JOIN = 0				# Client is joining the server and the address from which this packet was sent will be their receiving address
IMAGE = 1				# Client wants to send us an image
IMAGE_RESPONSE = 2		# Our response to clients image (passed or failed face rec for signin server &  N/A for signup server)
IMAGE_PORT = 3			# Which port we want the image sent to
SESSIONID = 4			# The session id we send to a client (response to JOIN)

###################


class Client:
	def __init__(self, addr, sessionID):
		self.addr=addr						# This is going to be the address that the client will receive at (the client can send from different addrs, but will always receive at this one)
		self.sessionID=sessionID

clients = []
		
public_ip = "172.17.0.3"

# Port for receiving commands from clients
command_port = 25595

# These are the ports available for receiving images and their availability (i.e. if they are currently in use)
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
	
		
def client_recv_image(addr, image_port, uid):
	
	s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
	try:
		s.bind((public_ip, image_port))
	except socket.error as err:
		print('Bind failed. Error Code : ' .format(err))
	
	image_stamp = "/root/userdata/temp/"+uid
	data = client.recv(1024)
	print ("Receiving image. Saving to " + stamp+".jpg")
	while (data):
		f = open(stamp+".jpg", 'ab+')
		f.write(data)
		data = client.recv(1024)
	
	
	feat_stamp = "/root/userdata/"+uid
	print ("Extracting feature data.")
	feats = np.asarray(getRep(image_stamp+".jpg"))
	f = open(feat_stamp+".txt", "w+")
	for fe in feats:
		f.write(str(fe)+"\n");
	f.close()
	
	s.close()
	image_ports[image_port] = True
	
	remove(image_stamp+".jpg")
	
def getPacketID(data):
	return int(data.split(",")[0])
	
def getSessionID(data):
	return data.split(",")[1]
	
def getData():
	return data.split(",")[2]
	
def lookUpUID(sessionID):
	# TODO look up UID in database given the sessionID
	return sessionID
	
def getOpenImagePort():
	while (1):
		for port in imagePorts:
			if port.get() == True:
				imagePorts[port] = False
				return port
				
def formatPacket(packetID, data):
	return "{},{}".format(str(packetID), data)
	
def getClientFromSessionID(sessionID):
	for c in clients:
		if c.sessionID == sessionID:
			return c
	return None
	
def client_accept():
	s.listen(10)
	while (1):
		(data, addr) = command_sock.recvfrom(1024)
		packetID = getPacketID(data)
		sessionID = getSessionID(data)
		
		if (packetID == JOIN):
			clients.append(Client(addr, sessionID))
			print ("Client at {} joined with sessionID:  {}".format(addr, sessionID))
		elif (packetID == IMAGE):
			image_port = getOpenImagePort()
			client_recv_addr = getClientFromSessionID(sessionID).addr
			command_sock.sendto(formatPacket(IMAGE_PORT,image_port), client_recv_addr);
			t = threading.Thread(target=client_recv_image, args=(client_recv_addr, image_port, lookUpUID(sessionID)))
			t.start();
		
		

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