package xyz.ryandavis.piecamera;

import java.net.*;
import java.io.*;

public class Client extends Thread{

    public static final int JOIN = 0, IMAGE = 1, IMAGE_RESPONSE = 2, IMAGE_PORT = 3, SESSIONID = 4;


    private volatile DatagramSocket socket = null;
    private DataOutputStream out = null;
    private InetAddress ip = null;
    private int port = -1;
    private String sessionID;
    private volatile boolean running = true;



    public Client(InetAddress ip, int port, String sessionID)
    {
       this.ip=ip;
       this.port=port;
       this.sessionID=sessionID;
    }

    public void run()
    {
        try
        {
            socket = new DatagramSocket();
            socket.connect(ip, port);

            byte joinMessage[] = (JOIN+",").getBytes();
            DatagramPacket joinPacket = new DatagramPacket(joinMessage, joinMessage.length);
            socket.send(joinPacket);

            byte sessionIDRecv[] = new byte[32];
            DatagramPacket sessionIDPacket = new DatagramPacket(sessionIDRecv, sessionIDRecv.length);
            socket.receive(sessionIDPacket);

            /**
             * All authentication should be done using firebase. This means that the client should receive a
             * session id from firebase as well as the server. Our server should not be supplying a sessionID or token.
             */

        }
        catch (Exception e)
        {
            e.printStackTrace();
        }

        // send join packet
        // recv sessionID

        while (running)
        {


            // recv packets
            // send packets in response
            // send packets when main thread tells us to (async)(maybe establish a return address when we join)
        }
    }

    public DatagramSocket getSocket()
    {
        return socket;
    }

    public void close()
    {
        try
        {
            socket.close();
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
    }

}
