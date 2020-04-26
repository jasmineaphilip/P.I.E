import socket
import signal
import sys
from packet import *

ip = "18.220.57.115"
port = 25595
student = True

global firstname,lastname,token

if (student):
	firstname = "Test"
	lastname = "Student"
	token = "iamstudent"
else:
	firstname = "Test"
	lastname = "Instructor"
	token = "iaminstructor"

sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)

def login_test(new_login):
	packet = Packet(JOIN)	
	sock.sendto(packet.formatClientData(token), (ip, port))
	data = sock.recvfrom(1024)
	print (data)
	if new_login:
		packet = Packet(SIGNUP)
		user_type = 1
		if student:
			user_type = 0
		sock.sendto(packet.formatClientData(token, firstname, lastname, user_type, ""), (ip, port))
		data = sock.recvfrom(1024)
		print (data)
	
def add_class_test():
	packet = Packet(ADD_CLASS)	
	sock.sendto(packet.formatClientData(token, "01:198:214"), (ip, port))
	data = sock.recvfrom(1024)
	print (data)
	
def get_class_info_test():
	packet = Packet(GET_CLASS_INFO)
	sock.sendto(packet.formatClientData(token, "01:198:214"), (ip, port))
	data = sock.recvfrom(1024)
	print (data)
	
def join_class_test():
	packet = Packet(JOIN_CLASS)
	sock.sendto(packet.formatClientData(token, "01:198:214"), (ip, port))
	data = sock.recvfrom(1024)
	print (data)

	
login_test(True)
join_class_test()
	

sock.close()
