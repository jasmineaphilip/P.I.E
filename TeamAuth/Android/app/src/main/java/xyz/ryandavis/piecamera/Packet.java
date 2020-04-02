package xyz.ryandavis.piecamera;

public class Packet {

    private int packetID;
    private String data;
    private String id_token;

    /**
     * Init method for packet sent from client
     * @param packetID
     * @param id_token
     * @param data
     */
    public Packet(int packetID, String id_token, String data)
    {
        this.packetID=packetID;
        this.id_token=id_token;
        this.data=data;
    }

    /**
     * Init method for packet received from server
     * @param raw_data
     */
    public Packet(String raw_data)
    {
        String sp[] = raw_data.split("\\"+Client.DELIMITER);
        this.packetID = Integer.parseInt(sp[0]);
        this.data = sp[1];
    }

    public String[] getDataEntries()
    {
        return data.split("\\"+Client.DELIMITER);
    }
    public String getData()
    {
        return data;
    }
    public String getRawData()
    {
        return insertDelim(Client.DELIMITER, String.valueOf(packetID), data);
    }
    public int getPacketID()
    {
        return packetID;
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
