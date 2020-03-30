# Module for all things packet related

### Packet IDS ###
# Packet format:  packet_id,id_token,data 
# NOTE: we will send back the same packet with our response (in most cases)

JOIN = 0				# Client is joining the server, we add them to a client list with their id token
IMAGE_SIGNIN = 2		# Client wants to send us an image for face rec verification, respond with port to send file
IMAGE_SIGNUP = 3		# Client wants to send us an image to add to their profile, respond with port to send file
IMAGE_RESPONSE = 4		# Our response to clients image (passed or failed face rec for signin server)
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
		
	def formatData(*arg):
		#right now, ALL packets will follow this basic structure of one data entry
		return insertDelim(DELIMITER, packet_id, arg[0])
			
def insertDelim(delim, *arg):
	ret = ""
	for s in arg:
		ret += s+delim
	return ret
	
def getPacketDataEntries(data):
	return data.split(DATA_DELIMITER)
	
def getPacketID(raw_data):
	return int(raw_data.split(DELIMITER)[0])
	
def getIDToken(raw_data):
	return raw_data.split(DELIMITER)[1]
	
def getData(raw_data):
	return raw_data.split(DELIMITER)[2]