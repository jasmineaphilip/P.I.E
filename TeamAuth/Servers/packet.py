# Module for all things packet related

### Packet IDS ###
# Packet format:  packet_id,id_token,data 
# NOTE: we will send back the same packet with our response (in most cases)

JOIN = 0				# Client is joining the server, we add them to a client list with their id token
LEAVE = 1				# Client is leaving the server, remove them from client list
IMAGE_SIGNUP = 2		# Client wants to send us an image to add to their profile, respond with port to send file
IMAGE_RESPONSE = 3		# Our response to clients image (passed or failed face rec for signin, received image for signup)
SIGNUP = 4				# Tell our client that this is the first time they are joining and they need to follow sign up process, send over some default data
INVALID_TOKEN = 5		# Sent in response to join if the provided firebase auth token is invalid

ADD_CLASS = 6
GET_CLASS_INFO = 7
JOIN_CLASS = 8
CREATE_SESSION = 9
GET_SESSIONS = 10
JOIN_SESSION = 11
GET_SESSION_PARTICIPANTS = 12
NFC_SIGNIN = 13
IMAGE_SIGNIN = 14
CONFIRM_SIGNIN = 15
ADD_FEEDBACK = 16
GET_FEEDBACK = 17
CREATE_GROUP = 18
SHOW_STUDYGROUPS = 19
REPORT_ISSUE = 20
STOP_SESSION = 21
GET_CURRENT_SESSION = 22

###################

DELIMITER = "|"
DATA_DELIMITER = "`"

class Packet:
	def __init__(self, packet_id):
		self.packet_id=packet_id
		
	def formatData(self, *arg):
		return insertDelim(DELIMITER, self.packet_id, insertDelim(DATA_DELIMITER, *arg))
		
	def formatClientData(self, token, *arg):
		return insertDelim(DELIMITER, self.packet_id, token, insertDelim(DATA_DELIMITER, *arg))
			
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