import sqlite3
import datetime 
import time

conn = sqlite3.connect('PIE_DB')
c = conn.curser()

#TODO ERROR CHECKING: CHECKING IF RESULT OF SELECT == EMPTY
#TODO CHANGE PRINT STATEMENTS TO RETURNS

#PROFILE & IMAGE FUNCTIONS
def insertProfile(UID, first, last, user_type, accessibility, classes):
    #TODO we need to insert all the classes at once (otherwise its annoying to change) --> just make list of class_ids and convert to string
    command = 'insert into PROFILES values (' + UID + ',' + last + ',' + first + ',' + classes + ',' + accessibility + ',' + user_type +');'
    c.execute(command)
    
def insertImage(UID, image):
    #TODO run openface to extract feature data 
    return 

def getClasses(UID):
    command = 'select classes from PROFILES where UID = ' + UID + ';'
    c.execute(command)
    row = c.fetchone()
    print(row)

def getName(UID):
    command = 'select first_name from PROFILES where UID = ' + UID + ';'
    c.execute(command)
    row = c.fetchone()
    print(row)
    firstName = row[0] #idk if its an array or not
    command = 'select last_name from PROFILES where UID = ' + UID + ';'
    c.execute(command)
    row = c.fetchone()
    print(row)
    lastName = row[0]
    name = firstName + ' ' + lastName
    return name

def getType(UID):
    command = 'select type from PROFILES where UID = ' + UID + ';'
    c.execute(command)
    row = c.fetchone()
    print(row)

def getAccessibility(UID):
    command = 'select accessibility from PROFILES where UID = ' + UID + ';'
    c.execute(command)
    row = c.fetchone()
    print(row)

def getFeatureData(UID):
    #TODO
    return

#CLASS & SESSION FUNCTIONS
#TODO WILL EVENTUALLY NEED TO IMPLEMENT INSERTING NFC TAGS WHEN AN INSTRUCTOR ADDS A CLASS

def addClass(class_id, UID):
    #add instructor UID and class id into class table
    command = 'insert into CLASSES (class_id, instructor) values (' + class_id + ',' + UID + ');'
    c.execute (command)

def createSession(class_id):
    currTime = datetime.datetime.now()
    command = 'select session_id from SESSION where class_id = ' + class_id + ';'
    #get last session id, increment
    c.execute(command)
    row = c.fetchone()
    last_session = int(row[0])
    session_id = last_session + 1
    command = 'insert into SESSION values (' + session_id + ',' + class_id + ',' + currTime + ');'
    c.execute(command)
    print(session_id)

def joinSession(session_id, UID, openface,nfc):
    #TODO run openface and nfc, let result = && of that; also in server, result should be returned to user
    result = -1 #haven't started yet
    time.sleep(3) #just waiting for testing
    if (openface == 1): #since technically can't do nfc without passing openface, no need to check if nfc = 0/1
        result = 0 #only facial completed
        if (nfc == 1):
            result = 1
    
    command = 'insert into ATTENDANCE values (' + session_id + ',' + UID + ',' + result + ');'
    c.execute(command)

def getIntructors(class_id):
    instructors = []
    command = 'select (instructor, other) from CLASSES where class_ID = ' + class_id + ';'
    c.execute(command)
    row  = c.fetchone()
    instructors.append(row[0]) #appends the instructor
    instructors.append(row[1]) #appends the TAs
    print(instructors)

def getAttendanceResult(session_id, UID):
    command = 'select result from Attendance where session_ID = ' + session_id + ';'    
    c.execute(command)
    row = c.fetchone()
    print (row[0])


#FEEDBACK FUNCTIONS *subset of SESSION
#TODO do we need feedback_type?
def addFeedback(UID, session_id, feedback_type, description):
    command = 'insert into FEEDBACK values (' + session_id + ',' + UID + ',' + feedback_type +',' + description + ');'
    c.execute(command)

def getFeedback(session_id):
    command = 'select (type, description) from FEEDBACK where session_ID = ' + session_id + ';'
    c.execute(command)
    rows = c.fetchall()
    for row in rows:
        print(row)

def createStudyGroup(UID, datetime, duration, location, participants):
    command = 'select group_ID from STUDYGROUP;'
    #get last session id, increment
    c.execute(command)
    row = c.fetchone()
    last_session = int(row[0])
    group_id = last_session + 1
    command = 'insert into STUDYGROUP values (' + group_id + ',' + datetime + ',' + duration + ',' + UID + ',' + location + ',' + participants + ');'
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
    command = 'select issue_ID from ISSUES;'
    #get last session id, increment
    c.execute(command)
    row = c.fetchone()
    last_issue = int(row[0])
    issue_id = last_issue + 1
    currTime = datetime.datetime.now()
    command = 'insert into ISSUES values(' + issue_id + ',' + currTime + ',' + UID + ',' + issue_type + ',' + description + ');'
    c.execute(command)
    print(issue_id)



#TEST ONE OF THE FUNCTIONS HERE

conn.commit()
conn.close()
