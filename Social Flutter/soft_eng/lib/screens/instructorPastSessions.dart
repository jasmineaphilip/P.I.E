import 'package:flutter/material.dart';
import 'package:soft_eng/screens/login.dart';

import 'instructorSessionFeedbackKeywords.dart';

class InstructorPastSessions extends StatefulWidget {
  @override
  _InstructorPastSessionsState createState() => _InstructorPastSessionsState();
}

class _InstructorPastSessionsState extends State<InstructorPastSessions> {
  List<String> sessionItemsTemp = [
    'January 28',
    'January 30',
    'February 4',
    'February 6',
    'February 11',
    'February 13',
    'February 18',
    'February 20',
    'February 25',
    'February 27',
    'March 3',
    'March 5',
    'March 10',
    'March 12',
    'March 24',
    'March 26',
    'March 31',
    'April 2',
    'April 7',
    'April 9',
    'April 14',
    'April 16',
    'April 21',
    'April 23',
    'April 28',
    'April 30',
    'May 5',
    'May 7',
    'May 12',
  ];
  @override
  Widget build(BuildContext context) {
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
                  Text(''),
                  Text('Session Date'),
                  Text(''),
                ],
              ),
            ),
            SizedBox(
                height: 450,
                width: 200,
                // child: ListView(
                //   shrinkWrap: true,
                //   children: _classNames
                //       .map((element) =>
                //           Text(element, style: TextStyle(color: Colors.black)))
                //       .toList(),
                // ),
                child: ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    // return Text(classNames[index]);
                    return InkWell(
                      onTap: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => InstructorSessionFeedbackKeywords(
                                      // classTitle: sessionItemsTemp[index],
                                    )))
                      },
                      child: Column(
                        children: <Widget>[
                          Padding(padding: new EdgeInsets.all(3.0)),
                          Text(sessionItemsTemp[index],
                          style: TextStyle(
                        fontSize: 20,
                      ),)
                        ],
                      ),
                    );
                  },
                  itemCount: sessionItemsTemp.length,
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
