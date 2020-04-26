import socket
import signal
import sys

JOIN = 0				# Client is joining the server, we add them to a client list with their id token
LEAVE = 1				# Client is leaving the server, remove them from client list
IMAGE_SIGNIN = 2		# Client wants to send us an image for face rec verification, respond with port to send file
IMAGE_SIGNUP = 3		# Client wants to send us an image to add to their profile, respond with port to send file
IMAGE_RESPONSE = 4		# Our response to clients image (passed or failed face rec for signin, received image for signup)
SIGNUP = 5				# Tell our client that this is the first time they are joining and they need to follow sign up process, send over some default data
INVALID_TOKEN = 6		# Sent in response to join if the provide token is invalid


ADD_CLASS = 7
CREATE_SESSION = 8
JOIN_SESSION = 9
ADD_FEEDBACK = 10
CREATE_GROUP = 11
REPORT_ISSUE = 12

DELIMITER = "|"
DATA_DELIMITER = "`"

ip = "18.220.57.115"
port = 25595

def insertDelim(delim, *arg):
	ret = ""
	for s in arg:
		ret += str(s)+delim
	return ret
	

packetID = JOIN
message = insertDelim(DELIMITER, packetID, "token")

sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
sock.sendto(message, (ip, port))

data, server = sock.recvfrom(1024)
print (data)

sock.close()
