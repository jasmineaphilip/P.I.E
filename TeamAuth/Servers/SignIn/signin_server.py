import socket
import threading	
import datetime
import time
import argparse
import cv2
import itertools
import numpy as np
import openface

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

try:
	s.bind(("172.17.0.2", 25595))
except socket.error as err:
	print('Bind failed. Error Code : ' .format(err))
	
	
def client_handler(client):
	current_time = datetime.datetime.now().strftime("%H:%M:%S")
	stamp = current_time.replace(":","-")
	data = client.recv(1024)
	print ("Receiving image. Saving to " + stamp+".jpg")
	while (data):
		f = open(stamp+".jpg", 'ab+')
		f.write(data)
		data = client.recv(1024)
	
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
		s.close()
