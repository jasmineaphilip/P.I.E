import socket
import sys
import os
import StringIO
import time
from base64 import b64decode, b64encode, decodestring


# Create a TCP/IP socket
sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
# Bind the socket to the port
server_address = ('172.17.0.2', 1111)
print ("starting up on %s port %s", server_address[0], server_address[1])
sock.bind(server_address)
# Listen for incoming connections
sock.listen(5)

# Wait for a connection
print("waiting for a connection")
connection, client_address = sock.accept()
   
print ("connection from", client_address[1])

#start timing!
start = time.time()

#receive the size of incoming data
size = connection.recv(8)
print("incoming image size")
print(size)

#open file and clear contents first
f = open("encoded.txt", "w")
f.close()
f = open("encoded.txt", "a")

sent = 0
size_int = int(size.strip('\x00'))
#print("size_int = ", size_int)

while (sent < size_int):
    data = connection.recv(size_int)
    #print(data)
    f.write(data)
    sent += len(data)

    print("sent %d of %d",sent,size_int)
#    if (sent >= size_int): 
#        break

print(connection)

f.close()
#decode
encoded_img = open('encoded.txt','rb').read()
#print(encoded_img)
#decode

encoded_img = open('encoded.txt','rb').read()
#print(encoded_img)

imgdata = b64decode(encoded_img.strip() + "==")
filename = 'some_image.jpg'  # I assume you have a way of picking unique filenames
with open(filename, 'wb') as f:
        f.write(imgdata)

#run openface
os.system('python compare.py some_image.jpg > result.txt')

f1 = open("result.txt")
print("result.txt contents:")
os.system('cat result.txt')

results = [line.strip().split() for line in f1]
print(results[0][0])
#results is array of arrays for each line in file (there is just 1)
result = float(results[0][0])



#for line in f1:
#    result = float(line)



print("result:")
print(result)
f1.close()
#send openface result TODO
#connection.send("y this shit aint working \0")
connection.send(results[0][0])



connection.close()

end = time.time()
print("total server time:")
print(end-start)

#clean everything
os.system("rm encoded.txt some_image.jpg result.txt")

