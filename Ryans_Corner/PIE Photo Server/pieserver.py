import socket
import threading	
import datetime

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

try:
	s.bind(("10.8.0.1", 25595))
except socket.error as err:
	print('Bind failed. Error Code : ' .format(err))
	
	
def client_handler(client):
	current_time = datetime.datetime.now().strftime("%H:%M:%S")
	stamp = current_time.replace(":","-")
	data = client.recv(1024)
	print ("Receiving image. Saving to " + stamp+".jpg")
	while (data):
		f = open(stamp+".jpg", 'ab+')
		f.write(data)
		data = client.recv(1024)
	
# TODO terminate thread via exception route  (s.accept() is currently making the thread hang until we get a connection)
# OR consider nonblocking sockets (but that seems like more of a headache, e.g. dealing with empty accepts)
def client_accept():
	s.listen(10)
	while (1):
		(client, addr) = s.accept()
		print ("\n"+str(addr)+ " connected.")
		t = threading.Thread(target=client_handler, args=(client,))
		clients.append(t)
		t.start()
		global stopping
		if (stopping):
			s.close()
			print ("Stopping")
			break

clients = []
com = ""
stopping = False
while (not(com=="quit")):
	com = input("Command:  ")
	t = threading.Thread(target=client_accept)
	if (com == "start"):
		t.start()
	if (com == "quit"):
		stopping = True