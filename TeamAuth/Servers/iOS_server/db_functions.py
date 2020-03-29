import sqlite3


conn = sqlite.connect('PIE_DB')
c = conn.curser()

#PROFILE FUNCTIONS
def getClasses(UID):
    command = 'select classes from PROFILES where UID = ' + UID + ';'
    c.execute(command)
    row = cur.fetchone()
    print(row)


def getName(UID):
    command = 'select first from PROFILES where UID = ' + UID + ';'
    c.execute(command)

