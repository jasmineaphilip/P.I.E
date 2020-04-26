import sqlite3
import datetime 
import time


# WHEN A ROW IS RETURNED FROM A TABLE, IT WILL BE IN THIS FOLLOWING FORMAT:
# (u'priya', u'parikh')
# (0, None, 1, u'pp649', u'myHouse', None, u'testGroup') 
# everything is returned as tuple

STUDENT = 0
INSTRUCTOR = 1

def init():
	global conn, c
	conn = sqlite3.connect('PIE_DB',check_same_thread=False)
	c = conn.cursor()



#TODO ERROR CHECKING: CHECKING IF RESULT OF SELECT == EMPTY
#TODO CHANGE PRINT STATEMENTS TO RETURNS

#PROFILE & IMAGE FUNCTIONS
def insertProfile(UID, first, last, user_type, classes): 
    #TODO we need to insert all the classes at once (otherwise its annoying to change) --> just make list of class_ids and convert to string
    UID = "\'" + UID + "\'"
    first = "\'" + first + "\'"
    last = "\'" + last + "\'"
    user_type = "\'" + str(user_type) + "\'"
    classes = "\'" + classes + "\'"
    c.execute('PRAGMA journal_mode=wal')
    command = 'insert into PROFILES values (' + UID + ',' + last + ',' + first + ',' + classes + ',' + '-1' + ','  + user_type +');'
    c.execute(command)
    conn.commit()

def profileExists(UID):
	command = "select EXISTS(SELECT 1 FROM PROFILES WHERE UID='{}');".format(UID)
	c.execute(command)
	data = c.fetchall()
	conn.commit()
	if data[0][0]==1:
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
    return row #row = array of classes separated 

def getName(UID):
    UID = "\'" + UID + "\'"
    command = 'select first_name, last_name from PROFILES where UID = ' + UID + ';'
    c.execute(command)
    row = c.fetchone()
    print(row)
    firstName = row[0]
    lastName = row[1]   
    name = firstName + ' ' + lastName
    conn.commit()
    return name

def getType(UID):
    UID = "\'" + UID + "\'"
    command = 'select type from PROFILES where UID = ' + UID + ';'
    c.execute(command)
    row = c.fetchone()
    conn.commit()
    return int(row[0]) #return type = 0 or 1

def getFeatureData(UID):
    UID = "\'" + UID + "\'"
    command = 'select feature_data from IMAGES where UID = ' + UID + ';'
    c.execute(command)
    row = c.fetchone()
    conn.commit()
    return row[0] #return feature data as string of array 

#CLASS & SESSION FUNCTIONS
#NOTE class_id is a STRING

def addClass(class_id, UID): #TODO student list, other instructors
    UID = "\'" + UID + "\'"
    class_id = "\'" + class_id + "\'"    
    c.execute('PRAGMA journal_mode=wal')
    command = 'insert into CLASSES (class_id, instructor, students) values (' + class_id + ',' + UID  + ',\'NONE\');'
    c.execute (command)
    conn.commit()
    return


def joinClass(class_id, newUID):
    class_id = "\'" + class_id + "\'"
    command = 'select students from CLASSES where class_id =' + class_id + ';'
    c.execute(command)
    row = c.fetchone()
    students = row[0]
    #check if any student has enrolled
    if students == 'NONE':
        newUID = "\'" + newUID + "\'"
        students = newUID
        
    else: #add UID to list of students
        students = "\'" + students + ',' + newUID + "\'"
    c.execute('PRAGMA journal_mode=wal')
    #update list of students
    command = 'update CLASSES SET students = ' + students + ' where class_id = ' + class_id + ';'
    c.execute(command)
    conn.commit()
    return

def getIntructors(class_id):
    class_id = "\'" + class_id + "\'"
    instructors = []
    command = 'select instructor, other from CLASSES where class_ID = ' + class_id + ';'
    c.execute(command)
    row  = c.fetchone()
    instructors.append(row[0]) #appends the instructor
    instructors.append(row[1]) #appends the TAs
    conn.commit()
    return instructors #array of instructors

def getNewSessionID(class_id):
	currTime = datetime.datetime.now()
	currTime = "\'" + currTime + "\'"
	class_id = "\'" + class_id + "\'"
	command = 'select session_id from SESSION where class_id = ' + class_id + ';'
	#get last session id, increment
	c.execute(command)
	row = c.fetchone()
	last_session = int(row[0])
	session_id = last_session + 1
	return session_id
	
def createSession(class_id, session_id):
    c.execute('PRAGMA journal_mode=wal')
    command = 'insert into SESSION values (' + str(session_id) + ',' + class_id + ',' + currTime + ');'
    c.execute(command)
    conn.commit()
    return

def joinSession(session_id, UID):
    UID = "\'" + UID + "\'"
    c.execute('PRAGMA journal_mode=wal')
    command = 'insert into ATTENDANCE values (' + str(session_id) + ',' + UID + ', 0);'
    c.execute(command)
    conn.commit()
    return 

def getKey(session_id):
    command = 'select key from NFC where session_id = ' + str(session_id) + ';'
    c.execute(command)
    row  = c.fetchone()
    conn.commit()
    return row[0] #int of current key value

def updateKey(session_id, newKey):
    newKey = "\'" + newKey + "\'"
    c.execute('PRAGMA journal_mode=wal')
    command = 'update NFC SET key = ' + newKey + 'where session_id = ' + str(session_id) + ';'
    c.execute(command)
    conn.commit()
    return

def getAttendanceResult(session_id, UID):
    UID = "\'" + UID + "\'"
    command = 'select result from Attendance where session_ID = ' + str(session_id) + ' AND student_id = ' + UID + ';'    
    c.execute(command)
    row = c.fetchone()
    conn.commit()
    return int(row[0]) #return attendance result for given session and uid

def updateAttendanceResult(session_id,UID,newResult):
    UID = "\'" + UID + "\'"
    c.execute('PRAGMA journal_mode=wal')
    command = 'update ATTENDANCE SET result = ' + str(newResult) + ' where session_id = ' + str(session_id) + ' AND student_id = ' + UID + ';'
    c.execute(command)
    conn.commit()
    return 


def getSessions(class_id):
    class_id = "\'" + class_id + "\'"
    command = 'select session_ID from Session where class_ID = ' + class_id + ';'
    c.execute(command)
    rows = c.fetchall()
    sessions = [] 
    for row in rows:
        sessions.append(row[0])
    return sessions    #return array of sessions

def sessionParticipants(session_id):
    command = 'select student_id from Attendance where session_ID = ' + str(session_id)  + ' AND result = 3;'    
    c.execute(command)
    rows = c.fetchall()
    participants = []
    for row in rows:
        participants.append(row[0])
    return participants #return array of participants

#FEEDBACK FUNCTIONS *subset of SESSION
#TODO do we need feedback_type?
def addFeedback(UID, session_id, feedback_type, description):
    UID = "\'" + UID + "\'"
    feedback_type = "\'" + feedback_type + "\'"
    description = "\'" + description + "\'"    
    c.execute('PRAGMA journal_mode=wal')
    command = 'insert into FEEDBACK values (' + str(session_id) + ',' + UID + ',' + feedback_type +',' + description + ');'
    c.execute(command)
    conn.commit()
    return

def getFeedback(session_id):
    #data needs to be inputted into textfile, will be named by session_id
    filename = session_id + ".txt"
    f = open(filename,"w")
    command = 'select type, description from FEEDBACK where session_ID = ' + str(session_id) + ';'
    c.execute(command)
    rows = c.fetchall()
    for row in rows:
        f.write(row[0])
    f.close()
    conn.commit()
    return filename #returns resulting text file

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
    c.execute('PRAGMA journal_mode=wal')
    command = 'insert into STUDYGROUP values (' + str(group_id) + ',' + datetime + ',' + str(duration) + ',' + UID + ',' + location + ',' + participants + ',' + name + ');'
    c.execute(command)
    conn.commit()
    return group_id

def showStudyGroups():
    command = 'select group_ID from STUDYGROUP;'
    c.execute(command)
    rows = c.fetchall()
    groups = []
    for row in rows:
        groups.append(row[0])
    conn.commit()
    return groups #return array of group ids

def showGroupInfo(group_ID):
    command = 'select * from STUDYGROUP where group_ID = ' + str(group_ID)
    c.execute(command)
    row = c.fetchone()
    conn.commit()
    #TODO maybe return as dictionary?
    return row #returns all data regarding specific group session as tuple 


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
    return issue_id
