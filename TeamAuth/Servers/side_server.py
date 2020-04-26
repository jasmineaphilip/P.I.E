import os 
from os import path
import sys
from db import *
from wordcloud import WordCloud
import matplotlib.pyplot as plt


#these are just temp functions, assuming a connection w client has already been made

def getAllFeedback(session_id):
    f = open(session_id + ".txt", "r")
    lines = f.readlines()
    for line in lines:
        print(line) #TODO send each line back to client
    f.close()


def getKeywords_Wordcloud(session_id):
    #define filenames for simplicity
    filename = session_id + ".txt"
    phrases_filename = session_id + "_phrases.txt"
    wordcloud_image = session_id + ".jpg"

    #first run phrases.py and store results in [session_id]_phrases.txt
    os.system("python3 phrases.py " + filename + " > " + phrases_filename) 
    
    #make cloud
    text = open(path.join(phrases_filename)).read()
    wordcloud = WordCloud().generate(text)  
    wordcloud.to_file(wordcloud_image)


