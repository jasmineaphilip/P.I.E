import 'package:flutter/material.dart';
import 'package:soft_eng/screens/instructorHome.dart';
import 'package:soft_eng/screens/login.dart';
import 'package:soft_eng/screens/instructorClassView.dart';
import 'package:soft_eng/screens/instructorStartSession.dart';
import 'package:soft_eng/screens/instructorliveSession.dart';
import 'package:soft_eng/screens/instructorPastSessions.dart';
import 'package:soft_eng/screens/instructorIntoClass.dart';
import 'package:soft_eng/screens/instructorIntoAllFeedback.dart';
import 'package:soft_eng/screens/instructorSessionFeedback.dart';
import 'package:soft_eng/screens/studentHome.dart';
import 'package:soft_eng/screens/studentClassView.dart';
import 'package:soft_eng/screens/studentIntoClass.dart';
import 'package:soft_eng/screens/studentJoinSession.dart';
import 'package:soft_eng/screens/studentFeedbackForm.dart';

void main() => runApp(MaterialApp(
      // initialRoute: '/login',
      routes: {
        //map with key value pairs
        '/': (context) => Login(),
        '/instructorHome': (context) => InstructorHome(),
        '/instructorClassView': (context) => InstructorClassView(),
        '/instructorStartSession': (context) => InstructorStartSession(),
        '/instructorLiveSession': (context) => InstructorLiveSession(),
        '/instructorPastSessions': (context) => InstructorPastSessions(),
        '/instructorIntoClass': (context) => InstructorIntoClass(),
        '/instructorIntoAllFeedback': (context) => InstructorIntoAllFeedback(),
        '/instructorSessionFeedback': (context) => InstructorSessionFeedback(),
        '/studentHome': (context) => StudentHome(),
        '/studentClassView': (context) => StudentClassView(),
        '/studentIntoClass': (context) => StudentIntoClass(),
        '/studentJoinSession': (context) => JoinClassWidget(),
        '/studentFeedbackForm': (context) => StudentFeedbackForm(),
      },
      theme: ThemeData(fontFamily: 'Avenir'),
    ));
