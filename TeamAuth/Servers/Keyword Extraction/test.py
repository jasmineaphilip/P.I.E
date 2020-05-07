import os
import sys

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

print(getKeywords(sys.argv[1],123))
