package xyz.ryandavis.piecamera;

import java.net.*;
import java.io.*;

public class Client extends Thread{

    private Socket socket = null;
    private DataOutputStream out = null;
    private InetAddress ip = null;
    private int port = -1;
    private String uid;

    public Client(InetAddress ip, int port, String uid)
    {
       this.ip=ip;
       this.port=port;
       this.uid=uid;
    }

    public Socket getSocket()
    {
        return socket;
    }
    public String getUID()
    {
        return uid;
    }

    public void run()
    {
        try
        {
            socket = new Socket(ip, port);
            out = new DataOutputStream(socket.getOutputStream());
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }

        try
        {
            out.writeBytes("UID");
            out.writeBytes(uid);
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }

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
