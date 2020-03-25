package xyz.ryandavis.piecamera;

import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetAddress;

public class SendAsyncPacket extends Thread {

    private InetAddress ip;
    private int port;
    private int packetID;
    private String data;
    private String sessionID;

    public SendAsyncPacket(InetAddress ip, int port, int packetID, String sessionID, String data)
    {
        this.ip=ip;
        this.port=port;
        this.packetID = packetID;
        this.data = data;
    }


    /**
     * We need to share the same socket across threads, otherwise the server will not know
     * where to send the responses to
     */

    public void run()
    {
        try
        {
            DatagramSocket socket = new DatagramSocket();
            byte message[] = formatData().getBytes();
            DatagramPacket dp = new DatagramPacket(message, message.length, ip, port);
            socket.connect(ip, port);
            socket.send(dp);
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
    }


    private String formatData()
    {
        return String.format("%d,%s,%s", packetID, sessionID, data);
    }
}
