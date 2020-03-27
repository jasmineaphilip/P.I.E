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
            sock.close();
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

            byte data[] = new byte[BUFF_SIZE];
            int length = 0;
            while ((length = fin.read(data, 0, data.length)) > 0) {
                out.write(data, 0, length);
            }
            out.flush();
            fin.close();
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
    }


}
