import sqlite3


conn = sqlite3.connect('PIE_DB')
c = conn.curser()

#PROFILE FUNCTIONS
def getClasses(UID):
    command = 'select classes from PROFILES where UID = ' + UID + ';'
    c.execute(command)
    row = c.fetchone()
    print(row)


def getName(UID):
    command = 'select first from PROFILES where UID = ' + UID + ';'
    c.execute(command)
    row = c.fetchone()
    print(row)
    firstName = row[0] #idk if its an array or not
    command = 'select last from PROFILES where UID = ' + UID + ';'
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

#CLASS & SESSION FUNCTIONS
def addClass(class_id, UID):
    #add instructor UID and class id into class table

def createSession

def joinSession

def getIntructors
def getCurrent

conn.commit()
conn.close()