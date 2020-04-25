import 'package:flutter/material.dart';
import 'package:soft_eng/screens/login.dart';

class InstructorAllFeedback extends StatefulWidget {
  @override
  _InstructorAllFeedbackState createState() => _InstructorAllFeedbackState();
}

class _InstructorAllFeedbackState extends State<InstructorAllFeedback> {
  List<String> sessionItemsTemp = [
    'this class sucks',
    'ivan heart eyes',
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
    return Scaffold(
      appBar: AppBar(
        title: Text('All Feedback'),
        centerTitle: true,
        backgroundColor: green,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            // Container(
            //   height: 100.0,
            //   width: 200.0,
            //   decoration: new BoxDecoration(
            //       image: DecorationImage(
            //           image: new AssetImage('./images/wordcloud.jpg'),
            //           fit: BoxFit.fill),
            //       shape: BoxShape.rectangle),
            // ),
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
                  Text('Feedback'),
                  Text('Session Date'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: SizedBox(
                height: 300.0,
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
            Container(
              height: 200.0,
              width: 300.0,
              decoration: new BoxDecoration(
                  image: DecorationImage(
                      image: new AssetImage('./images/wordcloud.jpg'),
                      fit: BoxFit.fill),
                  shape: BoxShape.rectangle),
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
