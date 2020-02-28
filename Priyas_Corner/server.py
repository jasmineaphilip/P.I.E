import socket
import sys
import os

port = int(sys.argv[1])

# Create a TCP/IP socket
sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
# Bind the socket to the port
server_address = ('assembly.cs.rutgers.edu', port)
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

while (sent < int(size)):
    data = connection.recv(int(size))
    #print(data)
    f.write(data)
    sent += len(data)
    
    print("sent %d of %d",sent,size)
    
    if (sent >= size): 
        break


f.close()
connection.close()

#run decode.py
os.system('python decode.py')