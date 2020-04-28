import 'package:flutter/material.dart';
import 'package:soft_eng/screens/login.dart';

class InstructorStartSession extends StatefulWidget {
  final String classTitle;
  InstructorStartSession({String classTitle}) :
        this.classTitle = (classTitle != null) ? classTitle : "Class Name"; //IF NULL it reports as Class View
  @override
  _InstructorStartSessionState createState() => _InstructorStartSessionState();
}

class _InstructorStartSessionState extends State<InstructorStartSession> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Start Session'),
        centerTitle: true,
        backgroundColor: green,
      ),
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                  top: 200.0,
                  bottom: 75,
                ),
                child: Text(
                  'Start Session for \n' + widget.classTitle,
                  style: TextStyle(
                    color: purple,
                    fontSize: 30.0,
                    fontFamily: 'Avenir',
                  ),
                ),
              ),
              FlatButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, '/instructorLiveSession');
                },
                icon: Icon(
                  Icons.play_arrow,
                  color: darkPurple,
                  size: 60.0,
                ),
                label: Text('Start'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
