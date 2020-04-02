import sqlite3
import datetime 
import time



def init():
	global conn, c
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
    conn.commit()

def profileExists(UID):
	command = "select EXISTS(SELECT 1 FROM PROFILES WHERE UID='{}');".format(UID)
	c.execute(command)
	data = c.fetchall()
	conn.commit()
	if data:
		return True
	else:
		return False
    
def insertImage(UID, image):
    UID = "\'" + UID + "\'"
    image = "\'" + image + "\'"
    #TODO run openface to extract feature data; image = path to image file
    conn.commit()

    return 

def getClasses(UID):
    UID = "\'" + UID + "\'"
    command = 'select classes from PROFILES where UID = ' + UID + ';'
    c.execute(command)
    row = c.fetchone()
    conn.commit()

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
    conn.commit()

    return name

def getType(UID):
    UID = "\'" + UID + "\'"
    command = 'select type from PROFILES where UID = ' + UID + ';'
    c.execute(command)
    row = c.fetchone()
    conn.commit()

    print(row)

def getAccessibility(UID):
    UID = "\'" + UID + "\'"
    command = 'select accessibility from PROFILES where UID = ' + UID + ';'
    c.execute(command)
    row = c.fetchone()
    conn.commit()

    print(row)

def getFeatureData(UID):
    UID = "\'" + UID + "\'"
    command = 'select feature_data from IMAGES where UID = ' + UID + ';'
    c.execute(command)
    row = c.fetchone()
    conn.commit()

    print(row)

#CLASS & SESSION FUNCTIONS
#TODO WILL EVENTUALLY NEED TO IMPLEMENT INSERTING NFC TAGS WHEN AN INSTRUCTOR ADDS A CLASS
def addClass(class_id, UID): #TODO add tags, student list, other instructors
    UID = "\'" + UID + "\'"
    class_id = "\'" + class_id + "\'"
    command = 'insert into CLASSES (class_id, instructor) values (' + class_id + ',' + UID + ');'
    c.execute (command)
    conn.commit()


#TODO def joinClass for students when the time comes

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
    conn.commit()

    print(session_id)

def joinSession(session_id, UID,result):
    #TODO run openface and nfc, let result = && of that; also in server, result should be returned to user
    UID = "\'" + UID + "\'"
    command = 'insert into ATTENDANCE values (' + str(session_id) + ',' + UID + ',' + str(result) + ');'
    c.execute(command)
    conn.commit()

    print(result)


#TODO check current tag key for attendance; 

def getIntructors(class_id):
    instructors = []
    command = 'select instructor, other from CLASSES where class_ID = ' + class_id + ';'
    c.execute(command)
    row  = c.fetchone()
    instructors.append(row[0]) #appends the instructor
    instructors.append(row[1]) #appends the TAs
    conn.commit()

    print(instructors)

def getAttendanceResult(session_id, UID):
    command = 'select result from Attendance where session_ID = ' + str(session_id) + ';'    
    c.execute(command)
    row = c.fetchone()
    conn.commit()

    print (row[0])


#FEEDBACK FUNCTIONS *subset of SESSION
#TODO do we need feedback_type?
def addFeedback(UID, session_id, feedback_type, description):
    UID = "\'" + UID + "\'"
    feedback_type = "\'" + feedback_type + "\'"
    description = "\'" + description + "\'"    
    command = 'insert into FEEDBACK values (' + str(session_id) + ',' + UID + ',' + feedback_type +',' + description + ');'
    c.execute(command)
    conn.commit()


def getFeedback(session_id):
    #TODO for keyword extraction, the data needs to be inputted into textfile
    command = 'select type, description from FEEDBACK where session_ID = ' + str(session_id) + ';'
    c.execute(command)
    rows = c.fetchall()
    for row in rows:
        print(row)
    conn.commit()


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
    conn.commit()

    print(group_id)

def showStudyGroups():
    command = 'select * from STUDYGROUP;'
    c.execute(command)
    rows = c.fetchall()
    for row in rows:
        print(row)
    conn.commit()





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
    conn.commit()

    print(issue_id)

#TODO UID != netid (maybe add attribute to profiles) and add getNetid method

#TEST ONE OF THE FUNCTIONS HERE
'''
class_id = '01:198:211:04'
instructor = 'pp649'
addClass(class_id, instructor)

insertProfile('pp649','priya','parikh','student',0,'198:211')
getName('pp649')
conn.commit()

showStudyGroups()

session_id = 0
netid = 'pp649'
getAttendanceResult(session_id,netid)

createStudyGroup('pp649', 'today', 1, 'rutgers', 'just me and ryan','the best study group ever')

conn.close()
'''
