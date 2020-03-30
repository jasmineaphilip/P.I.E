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

    public SendAsyncPacket(int packetID, String id_token, String data)
    {
        this.packetID = packetID;
        this.id_token=id_token;
        this.data = data;
    }

    public void run()
    {
        try
        {
            byte message[] = formatRawData().getBytes();
            DatagramPacket dp = new DatagramPacket(message, message.length);
            Client.socket.send(dp);
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
    }


    private String formatRawData()
    {
        return insertDelim(Client.DELIMITER, String.valueOf(packetID), id_token, data);
    }
    public void formatData(String... args)
    {
        this.data = insertDelim(Client.DATA_DELIMITER, args);
    }

    private String insertDelim(String delim, String ... args)
    {
        String ret = "";
        for (String s : args)
        {
            ret += s+delim;
        }
        return ret;
    }
}
