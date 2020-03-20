import socket
import sys
import os
import StringIO


port = int(sys.argv[1])

# Create a TCP/IP socket
sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
# Bind the socket to the port
server_address = ('192.168.86.36', port)
print ("starting up on %s port %s", server_address[0], server_address[1])
sock.bind(server_address)
# Listen for incoming connections
sock.listen(5)

# Wait for a connection
print("waiting for a connection")
connection, client_address = sock.accept()
   
print ("connection from", client_address[1])
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
#run decode.py
os.system('python decode.py')

#run openface
os.system('python compare.py some_image.jpg > result.txt')

f1 = open("result.txt")
print("result.txt contents:")
os.system('cat result.txt')

results = [line.strip().split() for line in f1]
print(results[0][0])
#results is array of arrays for each line in file (there is just 1)
result = float(results[0][0])

print("result:")
print(result)
f1.close()
#send openface result TODO
#connection.send("y this shit aint working \0")
connection.send(results[0][0])



connection.close()

