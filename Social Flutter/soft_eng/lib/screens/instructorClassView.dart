import 'package:flutter/material.dart';
import 'package:soft_eng/screens/login.dart';

class InstructorClassView extends StatefulWidget {
  final String classTitle;
  //InstructorIntoClass({this.classTitle, Key key}) : super(key: key);
  InstructorClassView({String classTitle}) : this.classTitle = classTitle;
  @override
  _InstructorClassViewState createState() => _InstructorClassViewState();
}

class _InstructorClassViewState extends State<InstructorClassView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CLASS NAME'),
        centerTitle: true,
        backgroundColor: green,
      ),
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                  top: 30.0,
                  bottom: 10,
                ),
                child: Text(
                  'Class Info',
                  style: TextStyle(
                    color: purple,
                    fontSize: 45.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Class ID: ',
                        style: TextStyle(
                          color: purple,
                          fontSize: 20.0,
                        )),
                    Text('connect to ID',
                        style: TextStyle(
                          color: darkPurple,
                          fontSize: 20.0,
                        )),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                child: Column(
                  children: <Widget>[
                    Text('Times: ',
                        style: TextStyle(
                          color: purple,
                          fontSize: 20.0,
                        )),
                    Container(
                        margin: const EdgeInsets.only(
                            left: 30.0, top: 10.0, right: 30.0),
                        height: 40.0,
                        decoration: new BoxDecoration(
                            //color: darkPurple,
                            borderRadius: new BorderRadius.all(
                                new Radius.circular(25.7))),
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
                                hintText: 'Insert Meeting Times',
                                contentPadding: const EdgeInsets.only(
                                    left: 14.0, bottom: 8.0, top: 8.0),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      new BorderSide(color: Colors.white),
                                  borderRadius: new BorderRadius.circular(25.7),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      new BorderSide(color: Colors.white),
                                  borderRadius: new BorderRadius.circular(25.7),
                                ),
                              ),
                            ))),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                child: Column(
                  children: <Widget>[
                    Text('Location: ',
                        style: TextStyle(
                          color: purple,
                          fontSize: 20.0,
                        )),
                    Container(
                        margin: const EdgeInsets.only(
                            left: 30.0, top: 10.0, right: 30.0),
                        height: 40.0,
                        decoration: new BoxDecoration(
                            //color: darkPurple,
                            borderRadius: new BorderRadius.all(
                                new Radius.circular(25.7))),
                        child: new Directionality(
                            textDirection: TextDirection.ltr,
                            child: new TextField(
                              controller: null,
                              autofocus: false,
                              style: new TextStyle(fontSize: 15.0, color: blue),
                              decoration: new InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                hintText: 'Insert Location',
                                contentPadding: const EdgeInsets.only(
                                    left: 14.0, bottom: 8.0, top: 8.0),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      new BorderSide(color: Colors.white),
                                  borderRadius: new BorderRadius.circular(25.7),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      new BorderSide(color: Colors.white),
                                  borderRadius: new BorderRadius.circular(25.7),
                                ),
                              ),
                            ))),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                child: Column(
                  children: <Widget>[
                    Text('Professor: ',
                        style: TextStyle(
                          color: purple,
                          fontSize: 20.0,
                        )),
                    Container(
                        margin: const EdgeInsets.only(
                            left: 30.0, top: 10.0, right: 30.0),
                        height: 40.0,
                        decoration: new BoxDecoration(
                            //color: darkPurple,
                            borderRadius: new BorderRadius.all(
                                new Radius.circular(25.7))),
                        child: new Directionality(
                            textDirection: TextDirection.ltr,
                            child: new TextField(
                              controller: null,
                              autofocus: false,
                              style: new TextStyle(fontSize: 15.0, color: blue),
                              decoration: new InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                hintText: 'Insert Professor',
                                contentPadding: const EdgeInsets.only(
                                    left: 14.0, bottom: 8.0, top: 8.0),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      new BorderSide(color: Colors.white),
                                  borderRadius: new BorderRadius.circular(25.7),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      new BorderSide(color: Colors.white),
                                  borderRadius: new BorderRadius.circular(25.7),
                                ),
                              ),
                            ))),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                child: Column(
                  children: <Widget>[
                    Text('TAs: ',
                        style: TextStyle(
                          color: purple,
                          fontSize: 20.0,
                        )),
                    Container(
                        margin: const EdgeInsets.only(
                            left: 30.0, top: 10.0, right: 30.0),
                        height: 40.0,
                        decoration: new BoxDecoration(
                            //color: darkPurple,
                            borderRadius: new BorderRadius.all(
                                new Radius.circular(25.7))),
                        child: new Directionality(
                            textDirection: TextDirection.ltr,
                            child: new TextField(
                              controller: null,
                              autofocus: false,
                              style: new TextStyle(fontSize: 15.0, color: blue),
                              decoration: new InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                hintText: 'Insert TAs',
                                contentPadding: const EdgeInsets.only(
                                    left: 14.0, bottom: 8.0, top: 8.0),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      new BorderSide(color: Colors.white),
                                  borderRadius: new BorderRadius.circular(25.7),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      new BorderSide(color: Colors.white),
                                  borderRadius: new BorderRadius.circular(25.7),
                                ),
                              ),
                            ))),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: MaterialButton(
                  minWidth: 100.0,
                  onPressed: () {},
                  color: darkPurple,
                  child: Text(
                    'Update',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
