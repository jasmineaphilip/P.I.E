package xyz.ryandavis.piecamera;

import java.io.DataOutputStream;
import java.io.FileInputStream;
import java.net.InetAddress;
import java.net.Socket;

public class SendImage extends Thread {

    private Socket sock;
    private DataOutputStream out = null;
    private FileInputStream fin = null;
    private final int BUFF_SIZE = 1024;
    private String path = null;
    private InetAddress ip = null;
    private int port = -1;

    public SendImage(InetAddress ip, int port, String path)
    {
        this.ip=ip;
        this.port=port;
        this.path=path;
    }

    public void run()
    {
        try
        {
            sock = new Socket(ip, port);
            out = new DataOutputStream(sock.getOutputStream());
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }

        sendPicture(path);

        try
        {
            out.close();
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
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


}
