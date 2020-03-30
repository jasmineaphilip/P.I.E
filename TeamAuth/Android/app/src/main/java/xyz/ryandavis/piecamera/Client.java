package xyz.ryandavis.piecamera;

import android.app.Activity;
import android.app.AlertDialog;
import android.util.Log;
import android.widget.Toast;

import java.net.*;
import java.io.*;


public class Client extends Thread{

    public static final int JOIN = 0,
            IMAGE_SIGNIN = 2,
            IMAGE_SIGNUP = 3,
            IMAGE_RESPONSE = 4,
            INVALID_TOKEN = 6,
            ADD_CLASS = 7,
            CREATE_SESSION = 8,
            JOIN_SESSION = 9,
            ADD_FEEDBACK = 10,
            CREATE_GROUP = 11,
            REPORT_ISSUE = 12;

    public static String DELIMITER = "|";
    public static String DATA_DELIMITER = "`";

    public static volatile String image_path;

    private final int PACKET_SIZE = 1024;

    public static volatile DatagramSocket socket = null;
    private InetAddress ip = null;
    private int port = -1;
    private String id_token;
    private Activity activity;
    private volatile boolean running = true;


    public Client(InetAddress ip, int port, String id_token, Activity activity)
    {
       this.ip=ip;
       this.port=port;
       this.id_token=id_token;
       this.activity=activity;
    }

    public void run()
    {
        try
        {
            socket = new DatagramSocket();
            socket.connect(ip, port);

            byte joinMessage[] = (insertDelim(DELIMITER, String.valueOf(JOIN), id_token)).getBytes();
            DatagramPacket joinPacket = new DatagramPacket(joinMessage, joinMessage.length);
            socket.send(joinPacket);

            byte joinResp[] = new byte[32];
            DatagramPacket joinRespPacket = new DatagramPacket(joinResp, joinResp.length);
            socket.receive(joinRespPacket);

            final String joinRespStr = new String(joinResp);
            int joinRespID = getPacketID(joinRespStr);

            switch (joinRespID) {
                case JOIN:
                    activity.runOnUiThread(new Runnable()
                    {
                        public void run()
                        {
                            AlertDialog dialog = new AlertDialog.Builder(MainActivity.ctx).create();
                            dialog.setTitle("Join Response");
                            dialog.setMessage(getData(joinRespStr));
                            dialog.show();
                        }
                    });
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
                final String response = getData(raw_data);

                switch (packetID) {
                    case IMAGE_SIGNUP:
                    case IMAGE_SIGNIN:
                        int image_port = Integer.parseInt(getData(raw_data));
                        Thread sendImage = new SendImage(ip, image_port, image_path);
                        sendImage.start();
                        break;
                    case IMAGE_RESPONSE:
                        activity.runOnUiThread(new Runnable()
                        {
                            public void run()
                            {
                                AlertDialog dialog = new AlertDialog.Builder(MainActivity.ctx).create();
                                dialog.setTitle("Image Response");
                                dialog.setMessage(response);
                                dialog.show();
                            }
                        });
                        // if failed to face rec, retry sending face (or quit)
                        // if success print success image
                        break;
                    case ADD_CLASS:
                        activity.runOnUiThread(new Runnable()
                        {
                            public void run()
                            {
                                AlertDialog dialog = new AlertDialog.Builder(MainActivity.ctx).create();
                                dialog.setTitle("Add Class Response");
                                dialog.setMessage(response);
                                dialog.show();
                            }
                        });
                        break;
                    case CREATE_SESSION:
                        activity.runOnUiThread(new Runnable()
                        {
                            public void run()
                            {
                                AlertDialog dialog = new AlertDialog.Builder(MainActivity.ctx).create();
                                dialog.setTitle("Create Session Response");
                                dialog.setMessage(response);
                                dialog.show();
                            }
                        });
                        break;
                    case JOIN_SESSION:
                        activity.runOnUiThread(new Runnable()
                        {
                            public void run()
                            {
                                AlertDialog dialog = new AlertDialog.Builder(MainActivity.ctx).create();
                                dialog.setTitle("Join Session Response");
                                dialog.setMessage(response);
                                dialog.show();
                            }
                        });
                        break;
                    case ADD_FEEDBACK:
                        activity.runOnUiThread(new Runnable()
                        {
                            public void run()
                            {
                                AlertDialog dialog = new AlertDialog.Builder(MainActivity.ctx).create();
                                dialog.setTitle("Add Feedback Response");
                                dialog.setMessage(response);
                                dialog.show();
                            }
                        });
                        break;
                    case CREATE_GROUP:
                        activity.runOnUiThread(new Runnable()
                        {
                            public void run()
                            {
                                AlertDialog dialog = new AlertDialog.Builder(MainActivity.ctx).create();
                                dialog.setTitle("Create Group Response");
                                dialog.setMessage(response);
                                dialog.show();
                            }
                        });
                        break;
                    case REPORT_ISSUE:
                        activity.runOnUiThread(new Runnable()
                        {
                            public void run()
                            {
                                AlertDialog dialog = new AlertDialog.Builder(MainActivity.ctx).create();
                                dialog.setTitle("Report Issue Response");
                                dialog.setMessage(response);
                                dialog.show();
                            }
                        });
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

    public int getPort()
    {
        return port;
    }
    public InetAddress getIP()
    {
        return ip;
    }
    public String getId_token()
    {
        return id_token;
    }
    public DatagramSocket getSocket()
    {
        return socket;
    }

    private int getPacketID(String raw_data)
    {
        String id = raw_data.split("\\"+DELIMITER)[0];
        return Integer.parseInt(id);
    }
    private String getData(String raw_data)
    {
        return raw_data.split("\\"+DELIMITER)[1];
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
