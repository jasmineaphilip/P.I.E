import os 
from os import path
import sys
from db import *
from wordcloud import WordCloud
import matplotlib.pyplot as plt
import hashlib


#these are just temp functions, assuming a connection w client has already been made

#KEYWORD EXTRACTRION

def getAllFeedback(filename):
    f = open(filename, "r")
    lines = f.readlines()
    for line in lines:
        print(line) #TODO send each line back to client
    f.close()


def getKeywords(filename,session_id):
    #define filename for simplicity
    phrases_filename = str(session_id) + "_phrases.txt"

    #first run phrases.py and store result in [session_id]_phrases.txt
    os.system("python3 phrases.py " + filename + " > " + phrases_filename) 
    #result is an array converted to string
    f = open(phrases_filename, "r")
    line = f.readline()
    keywords = line.replace("\n","").split(',')
    return keywords #return array of key phrases

def getWordcloud(filename):
    wordcloud_image = session_id + ".jpg"
    #make cloud
    text = open(path.join(filename)).read()
    wordcloud = WordCloud().generate(text)  
    wordcloud.to_file(wordcloud_image)
    return wordcloud_image

#ATTENDANCE STUFF
def generate_key(): #TODO
    newKey = hashlib.sha256().hexdigest()
    return newKey


def image_signin(image_port, uid, addr): #updated to check current states
    path = client_recv_image(image_port, uid)
    passed = compare(uid, path)
    returnPacket = Packet(IMAGE_RESPONSE)
    #check current status of users attendance
    currAttendance = db.getAttendanceResult(sessionID, uid)
    if(passed):
        print (auth.get_user(uid).display_name + " successfully signed in.")
        command_socket.sendto(returnPacket.formatData("Facial verificatin: Successful!"), addr)
        if (currAttendance == 0):
        #set value to 1 for facial rec
            writeDB(db.updateAttendanceResult, sessionID, uid, 1) 
        elif (currAttendance == 2):
            #facial and nfc both done, update val to 3
            writeDB(db.updateAttendanceResult, sessionID, uid, 3)
    else:
        print (auth.get_user(uid).display_name + " failed to signed in.")
        command_socket.sendto(returnPacket.formatData("Failed"), addr)


########################################################
if (packetID == -1):
    print("oops this is bad")

elif (packetID ==   GET_FEEDBACK): #returns keyword array
    sessionID = data_entries[0]
    rawFile = db.getFeedback(sessionID)
    keywords = getKeywords(rawFile,sessionID) 
    command_socket.sendto(returnPacket.formatData(tuple(keywords)), addr)

elif (packetID == SHOW_STUDYGROUPS): #returns array of group ids
    groups = db.showStudyGroups()
    command_socket.sendto(returnPacket.formatData(tuple(groups)), addr)

elif (packetID == GET_SESSIONS): #returns all session associated to class
    classID = data_entries[0]
    sessions = db.getSessions(classID)
    command_socket.sendto(returnPacket.formatData(tuple(sessions)), addr)

elif (packetID == GET_CLASS_INFO): #returns instructor
    classID = data_entries[0]
    result = db.getIntructors(classID) 
    instructor = result[0]
    command_socket.sendto(returnPacket.formatData(instructor), addr)

elif (packetID == JOIN_CLASS): #will update classes table to add more students
    classID = data_entries[0]
    writeDB(db.joinClass, classID, uid) 
    command_socket.sendto(returnPacket.formatData("Successfully joined class!"), addr)

elif (packetID == GET_SESSION_PARTICIPANTS): #returns list of all participants in session
    sessionID = data_entries[0] 
    students = db.sessionParticipants(sessionID)
    command_socket.sendto(returnPacket.formatData(tuple(students)), addr)   

elif (packetID == JOIN_SESSION): 
    classID = data_entries[0]
    sessionID = data_entries[1]
    #check if session still active
    if (classID in active_sessions):
        writeDB(db.joinSession, sessionID, uid)  #create session instance in db
        command_socket.sendto(returnPacket.formatData("Please continue signing in."), addr)
    else:
        command_socket.sendto(returnPacket.formatData("Session does not exist!"), addr)

elif (packetID == NFC_SIGNIN): #return 0 or 1 for pass fail
    sessionID = data_entries[0]
    key = data_entries[1]
    currKey = db.getKey(sessionID)
    if (key == currKey): #current keys match, generate new key and see i
        newKey = generate_key()
        writeDB(db.updateKey, sessionID, newKey) 
        #check current status of users attendance
        currAttendance = db.getAttendanceResult(sessionID, uid)
        if (currAttendance == 0):
            #set value to 2 for nfc
            writeDB(db.updateAttendanceResult, sessionID, uid, 2) 
        elif (currAttendance == 1):
            #facial and nfc both done, update val to 3
            writeDB(db.updateAttendanceResult, sessionID, uid, 3)  

        command_socket.sendto(returnPacket.formatData("NFC: Successful!"), addr)
    else: 
        command_socket.sendto(returnPacket.formatData("Error: Keys don't match!"), addr)

elif (packetID == CONFIRM_SIGNIN):
    sessionID = data_entries[0]
    currAttendance = db.getAttendanceResult(sessionID, uid)
    if (currAttendance == 0):
        command_socket.sendto(returnPacket.formatData("Please start the attendance process."), addr)
    elif (currAttendance == 1):
        command_socket.sendto(returnPacket.formatData("Please complete the NFC sign-in."), addr)
    elif (currAttendance == 2):
        command_socket.sendto(returnPacket.formatData("Please complete the facial authentication sign-in."), addr)
    else:
        command_socket.sendto(returnPacket.formatData("You have successfully joined the session!"), addr)

elif (packetID == STOP_SESSION):
    classID = data_entries[0]
    del active_sessions[classID]
    command_socket.sendto(returnPacket.formatData("Session ended."), addr)

