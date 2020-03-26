package xyz.ryandavis.piecamera;

import java.net.*;
import java.io.*;

public class Client extends Thread{

    public static final int JOIN = 0, IMAGE = 1, IMAGE_RESPONSE = 2, IMAGE_PORT = 3, INVALID_TOKEN = 4, JOIN_SUCCESS = 5;

    private final int PACKET_SIZE = 1024;

    private volatile DatagramSocket socket = null;
    private InetAddress ip = null;
    private int port = -1;
    private String id_token;
    private volatile boolean running = true;



    public Client(InetAddress ip, int port, String id_token)
    {
       this.ip=ip;
       this.port=port;
       this.id_token=id_token;
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

            byte joinResp[] = new byte[32];
            DatagramPacket joinRespPacket = new DatagramPacket(joinResp, joinResp.length);
            socket.receive(joinRespPacket);

            String joinRespStr = new String(joinResp);
            int joinRespID = getPacketID(joinRespStr);

            switch (joinRespID) {
                case JOIN_SUCCESS:
                    // do nothing and move on to reading in packets
                    break;
                case INVALID_TOKEN:
                    // maybe have the user sign in again?
                    break;
                default:
                    break;
            }


            while (running)
            {
                byte recv[] = new byte[PACKET_SIZE];
                DatagramPacket recvP = new DatagramPacket(recv, recv.length);
                socket.receive(recvP);
                String raw_data = new String(recv);
                int packetID = getPacketID(raw_data);

                switch (packetID) {
                    case IMAGE_PORT:
                        // parse the tcp port from the raw_data
                        break;
                    case IMAGE_RESPONSE:
                        // if failed to face rec, retry sending face (or quit)
                        // if success print success image
                        break;
                    default:
                        // not a valid packet ID (toast/log it)
                        break;
                }

                // recv packets
                // send packets in response

            }
        }
        catch (Exception e) {
            e.printStackTrace();
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

    public int getPacketID(String data)
    {
        return Integer.parseInt(data.split(",")[0]);
    }

}
