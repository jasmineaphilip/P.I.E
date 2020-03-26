import socket
import threading	
import datetime
import time
import argparse
import cv2
import itertools
import numpy as np
import openface
import os
import sqlite3

modelDir = "/root/openface/models/"
dlibModelDir = os.path.join(modelDir, 'dlib')
openfaceModelDir = os.path.join(modelDir, 'openface')
imgDim = 96
align = openface.AlignDlib(os.path.join(dlibModelDir, "shape_predictor_68_face_landmarks.dat"))
net = openface.TorchNeuralNet(os.path.join(openfaceModelDir, 'nn4.small2.v1.t7'), imgDim)

imgDim = 96

align = openface.AlignDlib(os.path.join(dlibModelDir, "shape_predictor_68_face_landmarks.dat"))
net = openface.TorchNeuralNet(os.path.join(openfaceModelDir, 'nn4.small2.v1.t7'), imgDim)

def getRep(imgPath):
    
    bgrImg = cv2.imread(imgPath)
    if bgrImg is None:
        raise Exception("Unable to load image: {}".format(imgPath))
    rgbImg = cv2.cvtColor(bgrImg, cv2.COLOR_BGR2RGB)

    start = time.time()
    bb = align.getLargestFaceBoundingBox(rgbImg)
    if bb is None:
        raise Exception("Unable to find a face: {}".format(imgPath))
  
    print("  + Face detection took {} seconds.".format(time.time() - start))

    start = time.time()
    alignedFace = align.align(imgDim, rgbImg, bb,
                              landmarkIndices=openface.AlignDlib.OUTER_EYES_AND_NOSE)
    if alignedFace is None:
        raise Exception("Unable to align image: {}".format(imgPath))

    start = time.time()
    rep = net.forward(alignedFace)
    print("  + OpenFace forward pass took {} seconds.".format(time.time() - start))
    print("Representation:")
    print(rep)
    print("-----\n")
    return rep

def readFeatures (file):
    f = open(file)
    data = []
    for line in f:
        data.append(float(line))

    return data
def insert_DB(feature_data):
    conn = sqlite3.connect('PIE_DB')
    c = conn.cursor()
    command = "INSERT INTO images(UID,feature_data) values (pp649, " + feature_data + ");"
    c.execute(command)

image = "priya3.jpg" #TODO set image name as parameter
f = None
features = np.asarray(getRep(image))
f = open("feature_data.txt", "w+")
for curr in features:
    f.write(str(curr)+"\n")


#insert into DB
data = str(features)
insert_DB(data)

f.close()
