import socket
import signal
import sys
from packet import *

########
# did not test:  NFC_SIGNIN, IMAGE_SIGNIN, IMAGE_SIGNUP, ADD_FEEDBACK, GET_FEEDBACK
########


ip = "18.220.57.115"
port = 25595
student = False

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
	print (data[0])
	if new_login:
		packet = Packet(SIGNUP)
		user_type = 1
		if student:
			user_type = 0
		sock.sendto(packet.formatClientData(token, firstname, lastname, user_type, ""), (ip, port))
		data = sock.recvfrom(1024)
		print (data[0])
	
def add_class_test():
	packet = Packet(ADD_CLASS)	
	sock.sendto(packet.formatClientData(token, "01:198:214"), (ip, port))
	data = sock.recvfrom(1024)
	print (data[0])
	
def get_class_info_test():
	packet = Packet(GET_CLASS_INFO)
	sock.sendto(packet.formatClientData(token, "01:198:214"), (ip, port))
	data = sock.recvfrom(1024)
	print (data[0])
	
def join_class_test():
	packet = Packet(JOIN_CLASS)
	sock.sendto(packet.formatClientData(token, "01:198:214"), (ip, port))
	data = sock.recvfrom(1024)
	print (data[0])

def create_session_test():
	packet = Packet(CREATE_SESSION)
	sock.sendto(packet.formatClientData(token, "01:198:214"), (ip, port))
	data = sock.recvfrom(1024)
	print (data[0])
	
def get_sessions_test():
	packet = Packet(GET_SESSIONS)
	sock.sendto(packet.formatClientData(token, "01:198:214"), (ip, port))
	data = sock.recvfrom(1024)
	print (data[0])
	
def get_current_session_test():
	packet = Packet(GET_CURRENT_SESSION)
	sock.sendto(packet.formatClientData(token, "01:198:214"), (ip, port))
	data = sock.recvfrom(1024)
	print (data[0])
	
def join_session_test():
	packet = Packet(JOIN_SESSION)
	sock.sendto(packet.formatClientData(token, "01:198:214", "4"), (ip, port))
	data = sock.recvfrom(1024)
	print (data[0])
	
def get_session_participants_test():
	packet = Packet(GET_SESSION_PARTICIPANTS)
	sock.sendto(packet.formatClientData(token, "4"), (ip, port))
	data = sock.recvfrom(1024)
	print (data[0])
	
def confirm_sign_in_test():
	packet = Packet(CONFIRM_SIGNIN)
	sock.sendto(packet.formatClientData(token, "4"), (ip, port))
	data = sock.recvfrom(1024)
	print (data[0])
	
def create_group_test():
	packet = Packet(CREATE_GROUP)
	sock.sendto(packet.formatClientData(token, "now", "my basement", "100", "ivan", "mygroup"), (ip, port))
	data = sock.recvfrom(1024)
	print (data[0])
	
def show_groups_test():
	packet = Packet(SHOW_STUDYGROUPS)	
	sock.sendto(packet.formatClientData(token), (ip, port))
	data = sock.recvfrom(1024)
	print (data[0])

def report_issue_test():
	packet = Packet(REPORT_ISSUE)	
	sock.sendto(packet.formatClientData(token, "bitch", "fuckyou"), (ip, port))
	data = sock.recvfrom(1024)
	print (data[0])
	
def stop_session_test():
	packet = Packet(STOP_SESSION)	
	sock.sendto(packet.formatClientData(token, "01:198:214"), (ip, port))
	data = sock.recvfrom(1024)
	print (data[0])
	
login_test(False)
#add_class_test()
#join_class_test()
#get_current_session_test()
#join_session_test()
#create_session_test()
#get_session_participants_test()
#confirm_sign_in_test()
#create_group_test()
#show_groups_test()
#report_issue_test()
stop_session_test()
	

sock.close()
