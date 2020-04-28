import 'package:flutter/material.dart';
import 'package:soft_eng/screens/login.dart';
import 'package:soft_eng/instructorComponents/joinSessionSheet.dart';

class StudentClassView extends StatefulWidget {
  final String classTitle;
  StudentClassView({String classTitle}) : this.classTitle = (classTitle != null) ? classTitle : "Class View"; //IF NULL it reports as Class View
  @override
  _StudentClassViewState createState() => _StudentClassViewState();
}

class _StudentClassViewState extends State<StudentClassView> {
  String classID = "connect to ID";
  String times = "Insert Meeting Times";
  String location = "insert Locations";
  String prof = "Insert Professor";
  String teacherA = "Insert TAs";
  @override
  Widget build(BuildContext context) {
    if(widget.classTitle == "Temp Class")
      {
        classID = "1254335";
        times = "2:00 to 3:20";
        location = "Center of Coding";
        prof = "Professor Bui";
        teacherA = "Keen";
      }
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.classTitle),
        centerTitle: true,
        backgroundColor: green,
      ),
      body: Container(
        child: Center(
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                  top: 30.0,
                  bottom: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Class Info',
                      style: TextStyle(
                        color: purple,
                        fontSize: 45.0,
                      ),
                    ),
                  ],
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
                    Text(classID,
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
                                hintText: times,
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
                padding: const EdgeInsets.only(top: 20, bottom: 15),
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
                                hintText: location,
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
                                hintText: prof,
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
                                hintText: teacherA,
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
                padding: const EdgeInsets.only(top: 5),
                child: AddClassButton(),
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/studentFeedbackForm');
                },
                child: Text(
                  'Preview Student Feedback Form',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                color: darkPurple,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AddClassButton extends StatefulWidget {
  @override
  _AddClassButtonState createState() => _AddClassButtonState();
}

class _AddClassButtonState extends State<AddClassButton> {
  bool _show = true;
  @override
  Widget build(BuildContext context) {
    return _show
        ? FlatButton.icon(
            onPressed: () {
              var sheetController = showBottomSheet(
                context: context,
                builder: (context) => JoinSessionWidget(),
              );
              _showButton(false);

              sheetController.closed.then((value) {
                _showButton(true);
              });
              JoinSessionWidget();
            },
            icon: Icon(Icons.group_add, color: Colors.white),
            color: darkPurple,
            label: Text('Join Session',
                style: TextStyle(
                  fontSize: 20.0,
                  fontFamily: 'Avenir',
                  color: Colors.white,
                )),
          )
        : Container();
  }

  void _showButton(bool value) {
    setState(() {
      _show = value;
    });
  }
}
