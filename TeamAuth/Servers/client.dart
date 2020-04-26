import 'dart:io';
import 'dart:convert';

//UDP
void main() {
  var data = "Hello, World";
  var codec = new Utf8Codec();
  List<int> dataToSend = codec.encode(data);
  var addressesIListenFrom = InternetAddress.anyIPv4;
  int portIListenOn = 16123; //change here
  RawDatagramSocket.bind(addressesIListenFrom, portIListenOn)
    .then((RawDatagramSocket udpSocket) {
    udpSocket.forEach((RawSocketEvent event) { //then -- indicates that once you bind, socket will then listen for events (data from server)
      if(event == RawSocketEvent.read) {
        Datagram dg = udpSocket.receive();
        dg.data.forEach((x) => print(x));
      }
    });
    udpSocket.send(dataToSend, addressesIListenFrom, portIListenOn);
    print('Did send data on the stream..');
  });
}

//https://stackoverflow.com/questions/21222064/dart-udp-client-server
//UDP functions - https://api.dart.dev/stable/1.10.1/dart-io/RawDatagramSocket-class.html



//TCP 
// import 'dart:io';
// import 'dart:convert';
// import 'dart:async';

// main() async {
//   //change server ip and port
//   Socket socket = await Socket.connect('128.6.13.236', 2020);
//   print('connected');

//   // listen to the received data event stream
//   socket.listen((List<int> event) {
//     print(utf8.decode(event));
//   });

//   // send hello
//   socket.add(utf8.encode('hello'));

//   // wait 5 seconds
//   await Future.delayed(Duration(seconds: 5));

//   // .. and close the socket
//   socket.close();

// }

//to write to server try this too - socket.write('Hello, World!');
//https://stackoverflow.com/questions/29081144/writing-reading-number-of-bytes-to-from-socket-data-in-dart
//https://stackoverflow.com/questions/54479462/how-to-return-socket-data-from-future-in-dart
//another link that i didnt use - http://jamesslocum.com/post/67566023889