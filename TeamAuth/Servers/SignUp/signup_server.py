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

#fileDir = os.path.dirname(os.path.realpath(__file__))
modelDir = "/home/rgd51/openface/models/"
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
    print("  + OpenFace forward pass took {} seconds.".format(time.time() - start))
    print("Representation:")
    print(rep)
    print("-----\n")
    return rep



s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

try:
	s.bind(("127.0.0.1", 25595))
except socket.error as err:
	print('Bind failed. Error Code : ' .format(err))
	
	
def client_handler(client):
	current_time = datetime.datetime.now().strftime("%H:%M:%S")
	stamp = "temp/"+current_time.replace(":","-")
	data = client.recv(1024)
	print ("Receiving image. Saving to " + stamp+".jpg")
	f = None
	while (data):
		f = open(stamp+".jpg", 'ab+')
		f.write(data)
		data = client.recv(1024)
	f.close()
	
	print ("Extracting feature data.")
	feats = np.asarray(getRep(stamp+".jpg"))
	f = open(stamp+".txt", "w+")
	for fe in feats:
		f.write(str(fe)+"\n");
	f.close()
		
	
def client_accept():
	s.listen(10)
	while (1):
		(client, addr) = s.accept()
		print ("\n"+str(addr)+ " connected.")
		t = threading.Thread(target=client_handler, args=(client,))
		clients.append(t)
		t.start()
		global stopping
		if (stopping):
			s.close()
			print ("Stopping")
			break

clients = []
com = ""
stopping = False
while (not(com=="quit")):
	com = raw_input("Command:  ")
	t = threading.Thread(target=client_accept)
	t.daemon = True
	if (com == "start"):
		t.start()
	if (com == "quit"):
		stopping = True