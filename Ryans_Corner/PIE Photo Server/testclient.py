import socket


path = "image1.jpg"

s = socket.socket()
s.connect(("10.8.0.1", 25595))

f = open(path, "rb")
data = f.read(1024)
while (data):
	s.send(data)
	data = f.read(1024)
	
s.close()
