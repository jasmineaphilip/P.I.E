package xyz.ryandavis.piecamera;

import java.io.DataOutputStream;
import java.io.FileInputStream;
import java.net.Socket;

public class SendImage extends Thread {

    private Socket sock;
    private DataOutputStream out = null;
    private FileInputStream fin = null;
    private final int BUFF_SIZE = 1024;
    private String path = null;

    public SendImage(Socket sock, String path)
    {
        this.sock=sock;
        this.path=path;
    }

    public void run()
    {
        try
        {
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
            out.writeBytes("sending image yo,");
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
