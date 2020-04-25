import 'package:flutter/material.dart';
import 'package:soft_eng/instructorComponents/joinSessionSheet.dart';
import 'package:soft_eng/screens/login.dart';
import 'package:soft_eng/screens/StudentJoinSession.dart';
import 'package:soft_eng/screens/StudentClassView.dart';

class StudentIntoClass extends StatefulWidget {
  @override
  _StudentIntoClassState createState() => _StudentIntoClassState();
}

class _StudentIntoClassState extends State<StudentIntoClass> {
  int _selectedPage = 0;
  final _pageOptions = [
    StudentClassView(),
    JoinSessionWidget(),
    //Login(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          BottomNavigationBarItem(
            icon: Icon(
              Icons.group_add,
              color: green,
            ),
            title: Text(
              'Join Session',
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
