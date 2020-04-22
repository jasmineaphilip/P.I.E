import 'package:flutter/material.dart';
import 'package:soft_eng/screens/login.dart';

class StudentFeedbackForm extends StatefulWidget {
  @override
  _StudentFeedbackFormState createState() => _StudentFeedbackFormState();
}

class _StudentFeedbackFormState extends State<StudentFeedbackForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CLASS NAME'),
        centerTitle: true,
        backgroundColor: green,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                top: 30.0,
                bottom: 50,
              ),
              child: Center(
                child: Text(
                  'Session Feedback',
                  style: TextStyle(
                    color: purple,
                    fontSize: 30.0,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 40),
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 40),
                      child: Text('Subject: ',
                          style: TextStyle(
                            color: purple,
                            fontSize: 20.0,
                          )),
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.only(
                          left: 30.0, top: 10.0, right: 30.0),
                      height: 40.0,
                      decoration: new BoxDecoration(
                          //color: darkPurple,
                          borderRadius:
                              new BorderRadius.all(new Radius.circular(25.7))),
                      child: new Directionality(
                          textDirection: TextDirection.ltr,
                          child: new TextField(
                            controller: null,
                            autofocus: false,
                            style: new TextStyle(
                              fontSize: 15.0,
                              color: blue,
                            ),
                            decoration: new InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Feedback Subject',
                              contentPadding: const EdgeInsets.only(
                                  left: 14.0, bottom: 8.0, top: 8.0),
                              focusedBorder: OutlineInputBorder(
                                borderSide: new BorderSide(color: Colors.white),
                                borderRadius: new BorderRadius.circular(25.7),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: new BorderSide(color: Colors.white),
                                borderRadius: new BorderRadius.circular(25.7),
                              ),
                            ),
                          ))),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 15),
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 40),
                      child: Text('Feedback Comments: ',
                          style: TextStyle(
                            color: purple,
                            fontSize: 20.0,
                          )),
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.only(
                          left: 30.0, top: 10.0, right: 30.0),
                      height: 100.0,
                      decoration: new BoxDecoration(
                          //color: darkPurple,
                          borderRadius:
                              new BorderRadius.all(new Radius.circular(25.7))),
                      child: new Directionality(
                          textDirection: TextDirection.ltr,
                          child: new TextField(
                            keyboardType: TextInputType.multiline,
                            maxLines: 20,
                            controller: null,
                            autofocus: false,
                            style: new TextStyle(fontSize: 15.0, color: blue),
                            decoration: new InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Feedback Comments',
                              contentPadding: const EdgeInsets.only(
                                  left: 14.0, bottom: 8.0, top: 8.0),
                              focusedBorder: OutlineInputBorder(
                                borderSide: new BorderSide(color: Colors.white),
                                borderRadius: new BorderRadius.circular(25.7),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: new BorderSide(color: Colors.white),
                                borderRadius: new BorderRadius.circular(25.7),
                              ),
                            ),
                          ))),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 200),
              child: SizedBox(
                width: 150,
                height: 50,
                child: MaterialButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  color: darkPurple,
                  child: Text(
                    'Submit',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ),
            Text(
                'NOTE: This screen should pop up after the class\'s instructor ends the session'),
          ],
        ),
      ),
    );
  }
}
