import 'package:flutter/material.dart';
import 'package:soft_eng/screens/login.dart';
import 'package:soft_eng/screens/instructorAllFeedback.dart';
import 'package:soft_eng/screens/instructorClassView.dart';
import 'package:soft_eng/screens/instructorPastSessions.dart';

class InstructorIntoAllFeedback extends StatefulWidget {
  @override
  _InstructorIntoAllFeedbackState createState() =>
      _InstructorIntoAllFeedbackState();
}

class _InstructorIntoAllFeedbackState extends State<InstructorIntoAllFeedback> {
  int _selectedPage = 0;
  final _pageOptions = [
    InstructorAllFeedback(),
    InstructorPastSessions(),
    InstructorClassView(),
    //Login(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('CLASS NAME'),
      //   centerTitle: true,
      // ),
      body: Center(
        child: _pageOptions.elementAt(_selectedPage),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: lightPurple,
        currentIndex: _selectedPage,
        onTap: (int index) {
          setState(() {
            _selectedPage = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.chat,
              color: green,
            ),
            title: Text(
              'All Feedback',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.library_books,
              color: green,
            ),
            title: Text(
              'Past Sessions',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.class_,
              color: green,
            ),
            title: Text(
              'Class View',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
