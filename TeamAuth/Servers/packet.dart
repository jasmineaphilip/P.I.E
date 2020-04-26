
var JOIN = 0;			
var LEAVE = 1;			
var IMAGE_SIGNUP = 2;
var IMAGE_RESPONSE = 3;
var SIGNUP = 4;		
var INVALID_TOKEN = 5;
var ADD_CLASS = 6;
var GET_CLASS_INFO = 7;
var JOIN_CLASS = 8;
var CREATE_SESSION = 9;
var GET_SESSIONS = 10;
var JOIN_SESSION = 11;
var GET_SESSION_PARTICIPANTS = 12;
var NFC_SIGNIN = 13;
var IMAGE_SIGNIN = 14;
var CONFIRM_SIGNIN = 15;
var ADD_FEEDBACK = 16;
var GET_FEEDBACK = 17;
var CREATE_GROUP = 18;
var SHOW_STUDYGROUPS = 19;
var REPORT_ISSUE = 20;
var STOP_SESSION = 21;
var GET_CURRENT_SESSION = 22;


var DELIMITER = "|";
var DATA_DELIMITER = "`";

class Packet {  
   //constructor
   int packet_id;
   Packet(int packet_id){
       this.packet_id = packet_id;
   }
   //function -- will need to use Lists to pass args ex: arg = []
	String formatClientData(String token, var arg){
	    var args = [];
	    args.add(packet_id);
	    args.add(token);
	    args.add(insertDelim(DATA_DELIMITER,arg));
	    
		return insertDelim(DELIMITER,args);
	}
	
	String insertDelim(String delim, var arg){
    	var ret = "";
    	for (var s in arg){
    		ret = ret + s.toString() + delim;
    	}
    	return ret;
	}
	
    int getPacketID(var raw_data){
        //parameter of parse must be a string, if error, value = null and will print following message
        //TODO if we have Dart 2, can do int.tryParse() instead
    	var value = int.parse(raw_data.split(DELIMITER)[0],onError:(source)=> print("Something wen wrong trying to convert String to Int"));
    
	    return value;
    }

    String getData(var raw_data){
    	return raw_data.split(DELIMITER)[2];
    }

}


void main() { 
    Packet p = new Packet(1532);
    var l = [];
    l.add("first");
    l.add("second");
    var r = p.formatClientData("token",l);
    print(r);
   
}  



