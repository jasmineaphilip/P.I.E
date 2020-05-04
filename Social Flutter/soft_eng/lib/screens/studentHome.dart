import 'package:flutter/material.dart';
import 'package:soft_eng/instructorComponents/joinClassSheet.dart';
import 'package:soft_eng/screens/studentIntoClass.dart';
import 'package:soft_eng/screens/login.dart';
import 'package:soft_eng/Packet.dart';

class Tdata {
  final String className;
  final String classID;

  Tdata(this.className, this.classID);
}

class StudentHome extends StatefulWidget {
  final List<String> classNames;
  StudentHome({Key key, @required this.classNames}) : super(key: key);

  @override
  _StudentHomeState createState() => _StudentHomeState();
}

class _StudentHomeState extends State<StudentHome> {
  @override
  Widget build(BuildContext context) {
    Packet.currentContext = context;
    print('from home');
    print(widget.classNames);
    if (widget.classNames == null) {
      print('its null');
      return Scaffold(
        appBar: AppBar(
          title: Text('Welcome STUDENT NAME'),
          centerTitle: true,
          backgroundColor: green,
        ),
        body: Container(
          child: Center(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                    top: 50.0,
                  ),
                  child: Text(
                    'Class List',
                    style: TextStyle(
                      color: purple,
                      fontSize: 30.0,
                      fontFamily: 'Avenir',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: AddClassButton(),
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => StudentIntoClass(
                                  classTitle: "Temp Class",
                                )));
                  },
                  child: Text('Class View temp button'),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text('Welcome NAME'),
          centerTitle: true,
          backgroundColor: green,
        ),
        body: Container(
          child: Center(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                    top: 50.0,
                  ),
                  child: Text(
                    'Class List',
                    style: TextStyle(
                      color: purple,
                      fontSize: 30.0,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    children: widget.classNames
                        .map((element) => Text(element))
                        .toList(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: AddClassButton(),
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => StudentIntoClass(
                                  classTitle: "Temp Class",
                                )));
                  },
                  child: Text('Class View temp button STUDENT'),
                ),
              ],
            ),
          ),
        ),
      );
    }
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
                builder: (context) => AddClassWidget(),
              );
              _showButton(false);

              sheetController.closed.then((value) {
                _showButton(true);
              });
              AddClassWidget();
            },
            icon: Icon(Icons.add),
            label: Text('Join Class',
                style: TextStyle(
                  fontSize: 20.0,
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
