import 'package:flutter/material.dart';
import 'package:soft_eng/screens/StudentHome.dart';
import 'package:soft_eng/screens/login.dart';

class JoinSessionWidget extends StatefulWidget {
  const JoinSessionWidget({Key key}) : super(key: key);

  @override
  _JoinSessionWidgetState createState() => _JoinSessionWidgetState();
}

class _JoinSessionWidgetState extends State<JoinSessionWidget> {
  final classNameTextController = TextEditingController();
  final classIDTextController = TextEditingController();
  List<String> classNamesList = List();
  List<String> classIDs = List();
  String className;
  String classID;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5, left: 15, right: 15, bottom: 100),
      height: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            height: 200,
            decoration: BoxDecoration(
                color: lightPurple,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 10, color: Colors.grey[300], spreadRadius: 5)
                ]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              //mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 30),
                  child: Text('Take a selfie so we know you\'re you :)',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      )),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    //SheetButton(),
                    SizedBox(
                      width: 150,
                      child: MaterialButton(
                        minWidth: 15.0,
                        color: green,
                        onPressed: () {
                          // setState(() {
                          //   classNamesList.add(classNameTextController.text);
                          // });
                          print('from sheet:');
                          print(classNamesList);
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Open Camera',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 150,
                      child: MaterialButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          minWidth: 15.0,
                          color: green,
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          )),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
