import sqlite3
import datetime 
import time

conn = sqlite3.connect('PIE_DB')
c = conn.cursor()

#TODO ERROR CHECKING: CHECKING IF RESULT OF SELECT == EMPTY
#TODO CHANGE PRINT STATEMENTS TO RETURNS

#PROFILE & IMAGE FUNCTIONS
def insertProfile(UID, first, last, user_type, accessibility, classes): #accessibility = 0 (none); 1 (TTS); 2(STT)
    #TODO we need to insert all the classes at once (otherwise its annoying to change) --> just make list of class_ids and convert to string
    UID = "\'" + UID + "\'"
    first = "\'" + first + "\'"
    last = "\'" + last + "\'"
    user_type = "\'" + user_type + "\'"
    classes = "\'" + classes + "\'"
    command = 'insert into PROFILES values (' + UID + ',' + last + ',' + first + ',' + classes + ',' + str(accessibility) + ',' + user_type +');'
    c.execute(command)
    
def insertImage(UID, image):
    UID = "\'" + UID + "\'"
    image = "\'" + image + "\'"
    #TODO run openface to extract feature data; image = path to image file
    return 

def getClasses(UID):
    UID = "\'" + UID + "\'"
    command = 'select classes from PROFILES where UID = ' + UID + ';'
    c.execute(command)
    row = c.fetchone()
    print(row)

def getName(UID):
    UID = "\'" + UID + "\'"
    command = 'select first_name, last_name from PROFILES where UID = ' + UID + ';'
    c.execute(command)
    row = c.fetchone()
    print(row)
    firstName = row[0]
    lastName = row[1] #idk if its an array or not   
    name = firstName + ' ' + lastName
    return name

def getType(UID):
    UID = "\'" + UID + "\'"
    command = 'select type from PROFILES where UID = ' + UID + ';'
    c.execute(command)
    row = c.fetchone()
    print(row)

def getAccessibility(UID):
    UID = "\'" + UID + "\'"
    command = 'select accessibility from PROFILES where UID = ' + UID + ';'
    c.execute(command)
    row = c.fetchone()
    print(row)

def getFeatureData(UID):
    UID = "\'" + UID + "\'"
    #TODO
    return

#CLASS & SESSION FUNCTIONS
#TODO WILL EVENTUALLY NEED TO IMPLEMENT INSERTING NFC TAGS WHEN AN INSTRUCTOR ADDS A CLASS

def addClass(class_id, UID):
    UID = "\'" + UID + "\'"
    class_id = "\'" + class_id + "\'"
    command = 'insert into CLASSES (class_id, instructor) values (' + class_id + ',' + UID + ');'
    c.execute (command)

def createSession(class_id):
    currTime = datetime.datetime.now()
    currTime = "\'" + currTime + "\'"
    class_id = "\'" + class_id + "\'"
    command = 'select session_id from SESSION where class_id = ' + class_id + ';'
    #get last session id, increment
    c.execute(command)
    row = c.fetchone()
    last_session = int(row[0])
    session_id = last_session + 1
    command = 'insert into SESSION values (' + str(session_id) + ',' + class_id + ',' + currTime + ');'
    c.execute(command)
    print(session_id)

def joinSession(session_id, UID, openface,nfc):
    #TODO run openface and nfc, let result = && of that; also in server, result should be returned to user
    UID = "\'" + UID + "\'"
    result = -1 #haven't started yet
    time.sleep(3) #just waiting for testing
    if (openface == 1): #since technically can't do nfc without passing openface, no need to check if nfc = 0/1
        result = 0 #only facial completed
        if (nfc == 1):
            result = 1
    
    command = 'insert into ATTENDANCE values (' + str(session_id) + ',' + UID + ',' + str(result) + ');'
    c.execute(command)

def getIntructors(class_id):
    instructors = []
    command = 'select instructor, other from CLASSES where class_ID = ' + class_id + ';'
    c.execute(command)
    row  = c.fetchone()
    instructors.append(row[0]) #appends the instructor
    instructors.append(row[1]) #appends the TAs
    print(instructors)

def getAttendanceResult(session_id, UID):
    command = 'select result from Attendance where session_ID = ' + str(session_id) + ';'    
    c.execute(command)
    row = c.fetchone()
    print (row[0])


#FEEDBACK FUNCTIONS *subset of SESSION
#TODO do we need feedback_type?
def addFeedback(UID, session_id, feedback_type, description):
    UID = "\'" + UID + "\'"
    feedback_type = "\'" + feedback_type + "\'"
    description = "\'" + description + "\'"    
    command = 'insert into FEEDBACK values (' + str(session_id) + ',' + UID + ',' + feedback_type +',' + description + ');'
    c.execute(command)

def getFeedback(session_id):
    #TODO for keyword extraction, the data needs to be inputted into textfile
    command = 'select type, description from FEEDBACK where session_ID = ' + str(session_id) + ';'
    c.execute(command)
    rows = c.fetchall()
    for row in rows:
        print(row)

def createStudyGroup(UID, datetime, duration, location, participants,name):
    UID = "\'" + UID + "\'"
    datetime = "\'" + datetime + "\'"   
    location = "\'" + location + "\'"
    participants = "\'" + participants + "\'"     
    name = "\'" + name + "\'"     
    command = 'select group_ID from STUDYGROUP;'
    #get last session id, increment
    c.execute(command)
    row = c.fetchone()
    last_session = int(row[0])
    group_id = last_session + 1
    command = 'insert into STUDYGROUP values (' + str(group_id) + ',' + datetime + ',' + str(duration) + ',' + UID + ',' + location + ',' + participants + ',' + name + ');'
    c.execute(command)
    print(group_id)

def showStudyGroups():
    command = 'select * from STUDYGROUP;'
    c.execute(command)
    rows = c.fetchall()
    for row in rows:
        print(row)

#BUGS
def addIssue(UID, issue_type, description):
    currTime = datetime.datetime.now()
    UID = "\'" + UID + "\'"
    currTime = "\'" + currTime + "\'"   
    issue_type = "\'" + issue_type + "\'"
    description = "\'" + description + "\'"     
    command = 'select issue_ID from ISSUES;'
    #get last session id, increment
    c.execute(command)
    row = c.fetchone()
    last_issue = int(row[0])
    issue_id = last_issue + 1
    command = 'insert into ISSUES values(' + str(issue_id) + ',' + currTime + ',' + UID + ',' + issue_type + ',' + description + ');'
    c.execute(command)
    print(issue_id)



#TEST ONE OF THE FUNCTIONS HERE
class_id = '198:211'
instructor = 'pp649'
addClass(class_id, instructor)

insertProfile('pp649','priya','parikh','student',0,'198:211')
getName('pp649')
conn.commit()

showStudyGroups()

session_id = 0
netid = 'pp649'
getAttendanceResult(session_id,netid)

conn.close()
