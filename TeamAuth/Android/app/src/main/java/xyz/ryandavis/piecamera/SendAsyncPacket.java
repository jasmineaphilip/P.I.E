package xyz.ryandavis.piecamera;

import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetAddress;

public class SendAsyncPacket extends Thread {

    private InetAddress ip;
    private int port;
    private int packetID;
    private String data;
    private String id_token;
    private volatile DatagramSocket socket;

    public SendAsyncPacket(DatagramSocket socket, int packetID, String id_token, String data)
    {
        this.socket = socket;
        this.packetID = packetID;
        this.id_token=id_token;
        this.data = data;
    }

    public void run()
    {
        try
        {
            //DatagramSocket socket = new DatagramSocket();
            byte message[] = formatData().getBytes();
            DatagramPacket dp = new DatagramPacket(message, message.length);
            //socket.connect(ip, port);
            socket.send(dp);
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
    }


    private String formatData()
    {
        return String.format("%d,%s,%s", packetID, id_token, data);
    }
}
