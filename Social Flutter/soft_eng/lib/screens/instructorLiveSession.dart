import 'package:flutter/material.dart';
import 'package:soft_eng/screens/instructorClassView.dart';
import 'package:soft_eng/screens/login.dart';
import 'package:soft_eng/Packet.dart';

class InstructorLiveSession extends StatefulWidget {
  @override
  _InstructorLiveSessionState createState() => _InstructorLiveSessionState();
}

class _InstructorLiveSessionState extends State<InstructorLiveSession> {
  List<String> sessionItemsTemp = [
    'jasmine',
    'jman',
    'ashy',
    'lincy',
    'balh',
    'balh',
    'balh',
    'balh',
    'balh',
    'balh',
    'balh',
    'balh',
    'balh',
    'balh',
  ];
  @override
  Widget build(BuildContext context) {
    Packet.currentContext = context;
    return Scaffold(
      appBar: AppBar(
        title: Text('Live Session'),
        centerTitle: true,
        backgroundColor: green,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                top: 30.0,
                bottom: 10,
              ),
              child: Text(
                'CLASS NAME Live Session',
                style: TextStyle(
                  color: purple,
                  fontSize: 30.0,
                  fontFamily: 'Avenir',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Total Joined:  '),
                    SizedBox(
                      width: 30,
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: '#',
                        ),
                      ),
                    ),
                  ]),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 70.0, right: 70.0, bottom: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Name'),
                  Text('netID'),
                ],
              ),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: 50,
                maxHeight: 500,
              ),
              child: ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      sessionItemsTemp[index],
                    ),
                  ),
                ),
                separatorBuilder: (context, index) => Divider(
                  color: Colors.black,
                ),
                itemCount: sessionItemsTemp.length,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 20,
              ),
              child: FlatButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.stop,
                  color: purple,
                  size: 20,
                ),
                label: Text(
                  'Stop Session',
                  style: TextStyle(
                    color: purple,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
