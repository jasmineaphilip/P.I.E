package xyz.ryandavis.piecamera;

import java.net.*;
import java.io.*;

public class Client extends Thread{

    private Socket socket = null;
    private DataOutputStream out = null;
    private FileInputStream fin = null;
    private final int BUFF_SIZE = 1024;
    private String path = null;
    private InetAddress ip = null;
    private int port = -1;

    public Client(InetAddress ip, int port, String path)
    {
       this.ip=ip;
       this.port=port;
       this.path=path;
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

        sendPicture(path);
    }

    private void sendPicture(String path)
    {
        try
        {
            fin = new FileInputStream(path);
            int count = 0;
            while (fin.available()>0)
            {
                byte data[] = new byte[BUFF_SIZE];
                fin.read(data, count*BUFF_SIZE, BUFF_SIZE);
                out.write(data);
            }
            fin.close();
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
            out.close();
            socket.close();
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
    }

}