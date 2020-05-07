import 'package:flutter/material.dart';
import 'package:soft_eng/screens/login.dart';

import 'instructorSessionFeedback.dart';

class InstructorSessionFeedbackKeywords extends StatefulWidget {
  @override
  _InstructorSessionFeedbackKeywordsState createState() =>
      _InstructorSessionFeedbackKeywordsState();
}

class _InstructorSessionFeedbackKeywordsState extends State<InstructorSessionFeedbackKeywords> {
  List<String> sessionKeysTemp = [
    'course presents',
    'advanced material',
    'lecture slides',
    'extremely helpful',
    'computer architecture',
    'course offered',
    'little bit exhausting',
    'introducing needed terminology',
    'amazing ',
    'easily found elsewhere',
    'also quite rewarding',
    'lecture slides',
    'computer architecture',
    'course material',
    'extremely useful',
    'nice course',
    'level course',
    'really enjoyed',
    'practical part',
    'new students',
    'new information',
    'labs would',
    'great substitute',
    'feel like',
    ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Session Feedback Keywords'),
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
                  Text(''),
                  Text('Keywords:'),
                  Text(''),
                ],
              ),
            ),
            SizedBox(
                height: 600,
                width: 350,
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
                                builder: (context) => InstructorSessionFeedback(
                                      // classTitle: sessionItemsTemp[index],
                                    )))
                      },
                      child: Column(
                        children: <Widget>[
                          Padding(padding: new EdgeInsets.all(3.0)),
                          Text(sessionKeysTemp[index],
                          style: TextStyle(
                        fontSize: 20,),)
                        ],
                      ),
                    );
                  },
                  itemCount: sessionKeysTemp.length,
                ),
              ),
            MaterialButton(
              onPressed: () {
                Navigator.pushNamed(context, '/instructorWordcloud');
              },
              color: darkPurple,
              child: Text('View Wordcloud',
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
