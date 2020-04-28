import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:soft_eng/screens/StudentHome.dart';
import 'package:soft_eng/screens/login.dart';
import 'package:nfc_in_flutter/nfc_in_flutter.dart';

class JoinSessionWidget extends StatefulWidget {
  const JoinSessionWidget({Key key}) : super(key: key);

  @override
  _JoinSessionWidgetState createState() => _JoinSessionWidgetState();
}

class _JoinSessionWidgetState extends State<JoinSessionWidget> {
  final classNameTextController = TextEditingController();
  final classIDTextController = TextEditingController();
  List<String> classNamesList = List();
  List<String> classIDs = List();
  String className;
  String classID;




  //-------------------------ParthNFC----------------------------


  StreamSubscription<NDEFMessage> _stream;
  String key = "";
  String newKey = "1738";
  bool _hasClosedWriteDialog = false;
  bool hasCompletedRead = false;

  void _write(BuildContext context) async {
    NDEFMessage message = NDEFMessage.withRecords([
      NDEFRecord.type("Key", newKey),
    ]);

    // Show dialog on Android (iOS has it's own one)
    if (Platform.isAndroid) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Scan the tag you want to write to"),
          actions: <Widget>[
            FlatButton(
              child: const Text("Cancel"),
              onPressed: () {
                _hasClosedWriteDialog = true;
                _stream?.cancel();
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
    }

    // Write to the first tag scanned
    await NFC.writeNDEF(message).first;
    if (!_hasClosedWriteDialog) {
      Navigator.pop(context);
    }
  }

  void _startScanning() {
    print("starting scan");
    setState(() {
      _stream = NFC
          .readNDEF()
          .listen((NDEFMessage message) {

        print("Read NDEF message with ${message.records.length} records");
        /*
        for (NDEFRecord record in message.records) {
          print(
              "Record '${record.id ?? "[NO ID]"}' with TNF '${record.tnf}', type '${record.type}', payload '${record.payload}' and data '${record.data}' and language code '${record.languageCode}'");
        }
         */
        NDEFRecord record = message.records[1];
        print("Record '${record.id ?? "[NO ID]"}' with TNF '${record.tnf}', type '${record.type}', payload '${record.payload}' and data '${record.data}' and language code '${record.languageCode}'");
        key = record.payload;

      });
    });
  }

  void _stopScanning() {
    _stream?.cancel();
    setState(() {
      _stream = null;
    });
  }

  void _toggleScan() {
    if (_stream == null) {
      _startScanning();
    } else {
      _stopScanning();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _stopScanning();
  }

  String _authenticate() {
    _toggleScan();
    Future.delayed(const Duration(seconds : 2));

    if(key.isEmpty){
      print("Failed to read");
      return "-1";
    }

    //PRIYA RYAN
    //Call to Server here giving classID and key here.
    //put server's return value into variable newKey
    newKey = "<SERVER RETURN VALUE HERE>";

    if(newKey.isEmpty){
      print("Failed to get return value from Server");
      return "-1";
    }

    print(key);

    _write(context);

    //Close scanner and clear variables.
    _toggleScan();
    key = "";
    newKey = "";

    return "1";
  }

  int counter = 0;
  void __authenticate(){
    switch(counter){
      case 0:
        print("Scanning NFC Card...");
        counter++;
        break;
      case 1:
        print("Read nfc record with key: '12345'");
        counter++;
        break;
      case 2:
        print("Sending session ID '192:332' and key '12345' to server");
        print("...");
        counter++;
        break;
      case 3:
        print("...");
        counter++;
        break;
      case 4:
        print("Student has been authenticated");
        print("Server returned newKey: '54321' ");
        counter++;
        break;
      case 5:
        print("newKey '54321' has been written to tag");
        counter = 0;
        break;

    }
  }


  //--------------------------/ParthNFC-----------------------------
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 30, left: 15, right: 15, bottom: 100),
      height: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            height: 200,
            decoration: BoxDecoration(
                color: lightPurple,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 11, color: Colors.grey[300], spreadRadius: 5)
                ]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              //mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 30, left: 15, right: 5),
                  child: Text('Take a selfie so we know you\'re you :)',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      )),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    //SheetButton(),
                    SizedBox(
                      width: 150,
                      child: MaterialButton(
                        minWidth: 15.0,
                        color: green,
                        onPressed: () {
                          // setState(() {
                          //   classNamesList.add(classNameTextController.text);
                          // });
                          print('from sheet:');
                          print(classNamesList);
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Open Camera',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 150,
                      child: MaterialButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          minWidth: 15.0,
                          color: green,
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          )),
                    )
                  ],
                ),
              ],
            ),
          ),
          Container(
            height: 200,
            margin: EdgeInsets.only(top: 6),
            decoration: BoxDecoration(
                color: lightPurple,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 10, color: Colors.grey[300], spreadRadius: 5)
                ]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              //mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 30, left: 5, right: 5),
                  child: Text('NFC Authentication',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      )),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    //SheetButton(),
                    SizedBox(
                      width: 150,
                      child: MaterialButton(
                        minWidth: 15.0,
                        color: green,
                        onPressed: () {
                          __authenticate();
                        },
                        child: Text(
                          'Scan NFC',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 150,
                      child: MaterialButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          minWidth: 15.0,
                          color: green,
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          )),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
