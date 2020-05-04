import 'package:flutter/material.dart';
import 'package:soft_eng/screens/login.dart';
import 'package:soft_eng/Packet.dart';

class InstructorPastSessions extends StatefulWidget {
  final String classTitle;
  InstructorPastSessions({Key key, this.classTitle}) : super(key: key);
  @override
  _InstructorPastSessionsState createState() => _InstructorPastSessionsState();
}

class _InstructorPastSessionsState extends State<InstructorPastSessions> {
  List<String> sessionItemsTemp = [
    'march 10',
    'march 11',
    'april 4',
    'april 4',
    'april 4',
    'april 4',
    'april 4',
    'april 4',
    'april 4',
    'april 4',
    'april 4',
    'april 4',
    'april 4',
    'april 4',
    'april 4',
    'april 4',
  ];
  @override
  Widget build(BuildContext context) {
    Packet.currentContext = context;
    return Scaffold(
      appBar: AppBar(
        title: Text('Past Sessions'),
        centerTitle: true,
        backgroundColor: green,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                top: 30,
                bottom: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Sort By:',
                    style: TextStyle(
                      color: darkPurple,
                      fontSize: 25,
                    ),
                  ),
                  FlatButton(
                    onPressed: null,
                    child: Text(
                      'Newest',
                      style: TextStyle(
                        color: purple,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  FlatButton(
                    onPressed: null,
                    child: Text(
                      'Oldest',
                      style: TextStyle(
                        color: purple,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 70.0,
                right: 70.0,
                bottom: 20.0,
                top: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Session Date'),
                  Text('# Joined'),
                ],
              ),
            ),
            Expanded(
              child: SizedBox(
                height: 200.0,
                child: ListView.separated(
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
            ),
            MaterialButton(
              onPressed: () {
                Navigator.pushNamed(context, '/instructorIntoAllFeedback');
              },
              color: darkPurple,
              child: Text('View All Feedback',
                  style: TextStyle(
                    color: Colors.white,
                  )),
            )
          ],
        ),
      ),
    );
  }
}

// FlatButton(
//                 onPressed: () {
//                   Navigator.pushNamed(context, '/instructorIntoAllFeedback');
//                 },
//                 child: Text('All Feedback'),
//               ),
