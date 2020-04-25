import 'package:flutter/material.dart';
import 'package:soft_eng/screens/login.dart';
import 'package:soft_eng/screens/InstructorStartSession.dart';
import 'package:soft_eng/screens/InstructorPastSessions.dart';
import 'package:soft_eng/screens/InstructorClassView.dart';

class InstructorIntoClass extends StatefulWidget {
  @override
  _InstructorIntoClassState createState() => _InstructorIntoClassState();
}

class _InstructorIntoClassState extends State<InstructorIntoClass> {
  int _selectedPage = 0;
  final _pageOptions = [
    InstructorClassView(),
    InstructorStartSession(),
    InstructorPastSessions(),
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
          // BottomNavigationBarItem(
          //   icon: Icon(
          //     Icons.home,
          //     color: Colors.green,
          //   ),
          //   title: Text(
          //     'Home',
          //     style: TextStyle(
          //       color: Colors.purple,
          //     ),
          //   ),
          // ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.live_tv,
              color: green,
            ),
            title: Text(
              'Start Session',
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
          // BottomNavigationBarItem(
          //   icon: Icon(
          //     Icons.open_in_new,
          //     color: Colors.green,
          //   ),
          //   title: Text(
          //     'Logout',
          //     style: TextStyle(
          //       color: Colors.purple,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
