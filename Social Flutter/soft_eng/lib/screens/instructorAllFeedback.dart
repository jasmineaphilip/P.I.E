import 'package:flutter/material.dart';
import 'package:soft_eng/screens/login.dart';

class InstructorAllFeedback extends StatefulWidget {
  @override
  _InstructorAllFeedbackState createState() => _InstructorAllFeedbackState();
}

class _InstructorAllFeedbackState extends State<InstructorAllFeedback> {
  List<String> sessionItemsTemp = [
    'Excellent course! It was really nice to have a high-level course, and I feel like this course makes a great substitute for the Computer Architecture course offered in my university.',
    'The way of Professor is teaching is fabulous !! Content of the course is amazing. He has planned the course in such a way that new students can also understand the concepts',
    'The course presents advanced material, not easily found elsewhere. Labs would have definitely facilitated the learning in this case and I hope they will be added in the future.',
    'The course material (lecture slides) for "Computer Architecture" is almost identical to that of the other top universities, so you can be confident in its quality. Professor is clearly experienced in both teaching and the subject. I really enjoyed the lectures. I am really grateful for the opportunity to take this course.',
    'the course is extremely useful in giving an overview of the existing technologies and introducing needed terminology and basic blocks.',
    'Quite intense but also quite rewarding. Dr. Wentzlaffs class are captivating and well prepared. The exames are a little bit exhausting, but effectively measure what was learned.',
    'Nice course, learnt a lot of new information. If practical part is also included in this course, this this course will even be more good.',
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
        child: ListView(
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
