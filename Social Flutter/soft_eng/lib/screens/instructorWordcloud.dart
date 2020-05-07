import 'package:flutter/material.dart';
import 'package:soft_eng/screens/login.dart';


class InstructorWordcloud extends StatefulWidget {
  @override
  _InstructorWordcloudState createState() =>
      _InstructorWordcloudState();
}

class _InstructorWordcloudState extends State<InstructorWordcloud> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Word Cloud'),
        centerTitle: true,
        backgroundColor: green,
      ),
      body: Container(
              height: 400.0,
              width: 450.0,
              decoration: new BoxDecoration(
                  image: DecorationImage(
                      image: new AssetImage('./images/wordcloud.jpg'),
                      fit: BoxFit.fill),
                  shape: BoxShape.rectangle),
      ),
    );
  }
}
