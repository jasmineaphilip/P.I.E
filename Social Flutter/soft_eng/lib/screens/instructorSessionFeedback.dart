import 'package:flutter/material.dart';
import 'package:soft_eng/screens/login.dart';
import 'package:soft_eng/Packet.dart';

class InstructorSessionFeedback extends StatefulWidget {
  @override
  _InstructorSessionFeedbackState createState() =>
      _InstructorSessionFeedbackState();
}

class _InstructorSessionFeedbackState extends State<InstructorSessionFeedback> {
  List<String> sessionItemsTemp = [
    'this class sucks',
    'blah blah feedback',
    'blah blah feedback',
    'blah blah feedback',
    'blah blah feedback',
    'blah blah feedback',
    'blah blah feedback',
    'blah blah feedback',
    'blah blah feedback',
    'blah blah feedback',
    'blah blah feedback',
    'blah blah feedback',
    'blah blah feedback',
    'blah blah feedback',
  ];
  @override
  Widget build(BuildContext context) {
    Packet.currentContext = context;
    return Scaffold(
      appBar: AppBar(
        title: Text('Session Feedback'),
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
                  Text('Subject'),
                  Text('Feedback'),
                ],
              ),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: 50,
                maxHeight: 100,
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
            MaterialButton(
              onPressed: () {
                Navigator.pushNamed(context, '/instructorIntoAllFeedback');
              },
              color: darkPurple,
              child: Text('Preview Session Feedback',
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
