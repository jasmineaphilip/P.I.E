import 'package:flutter/material.dart';
import 'package:soft_eng/screens/login.dart';

class JoinClassWidget extends StatefulWidget {
  @override
  _JoinClassWidgetState createState() => _JoinClassWidgetState();
}

class _JoinClassWidgetState extends State<JoinClassWidget> {
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
                Container(
                  height: 50,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                Container(
                  height: 50,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    //SheetButton(),
                    SizedBox(
                      width: 100,
                      child: MaterialButton(
                        minWidth: 10.0,
                        color: green,
                        onPressed: () {
                          Navigator.pop(context); //CONNECT TO CAMERA LATER ONNN
                        },
                        child: Text(
                          'Open Camera',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 100,
                      child: MaterialButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          minWidth: 10.0,
                          color: green,
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                              color: Colors.white,
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
