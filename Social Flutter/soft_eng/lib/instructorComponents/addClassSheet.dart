import 'package:flutter/material.dart';
import 'package:soft_eng/screens/instructorHome.dart';
import 'package:soft_eng/screens/login.dart';
import 'package:flutter/cupertino.dart';

class AddClassWidget extends StatefulWidget {
  @override
  _AddClassWidgetState createState() => _AddClassWidgetState();
}

class _AddClassWidgetState extends State<AddClassWidget> {
  final classNameTextController = TextEditingController();
  final classIDTextController = TextEditingController();
  List<String> classNamesList = [];
  List<String> classIDs = List();
  String classID;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Class'),
        centerTitle: true,
        backgroundColor: green,
      ),
      body: Container(
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
                        blurRadius: 10,
                        color: Colors.grey[300],
                        spreadRadius: 5)
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
                    child: TextField(
                      controller: classNameTextController,
                      decoration:
                          InputDecoration.collapsed(hintText: 'Class Name'),
                      onSubmitted: (className) {
                        classNamesList.add(className);
                        classNameTextController.clear();
                        setState(() {});
                      },
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
                    child: TextField(
                      controller: classIDTextController,
                      decoration:
                          InputDecoration.collapsed(hintText: 'Class ID'),

                      // onChanged: (classID) {
                      //   classIDs.add(classID);
                      // },
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
                            // classNamesList.add(classNameTextController.text);
                            // setState(() {});
                            print('from sheet:');
                            print(classNamesList);
                            //classNamesList.add(classNameTextController.text);
                            Navigator.pop(context, classNamesList);
                          },
                          child: Text(
                            'Add Class',
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
      ),
    );
  }
}
