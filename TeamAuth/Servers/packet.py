# Module for all things packet related

### Packet IDS ###
# Packet format:  packet_id,id_token,data 
# NOTE: we will send back the same packet with our response (in most cases)

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

###################

DELIMITER = "|"
DATA_DELIMITER = "`"

class Packet:
	def __init__(self, packet_id):
		self.packet_id=packet_id
		
	def formatData(self, *arg):
		return insertDelim(DELIMITER, self.packet_id, insertDelim(DATA_DELIMITER, *arg))
			
def insertDelim(delim, *arg):
	ret = ""
	for s in arg:
		ret += str(s)+delim
	return ret
	
def getPacketDataEntries(data):
	return data.split(DATA_DELIMITER)
	
def getPacketID(raw_data):
	return int(raw_data.split(DELIMITER)[0])
	
def getIDToken(raw_data):
	return raw_data.split(DELIMITER)[1]
	
def getData(raw_data):
	return raw_data.split(DELIMITER)[2]