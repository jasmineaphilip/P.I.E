import 'package:flutter/material.dart';
import 'package:soft_eng/instructorComponents/addClassSheet.dart';
import 'package:soft_eng/screens/instructorIntoClass.dart';
import 'package:soft_eng/screens/login.dart';
import 'package:flutter/cupertino.dart';

class InstructorHome extends StatefulWidget {
  //final String className;
  //final String classID;
  // final bool visible;

  // InstructorHome({this.classNames, Key key}) : super(key: key);

  @override
  _InstructorHomeState createState() => _InstructorHomeState();
}

class _InstructorHomeState extends State<InstructorHome> {
  final List<String> classNames = [];
  final classNameController = TextEditingController();
  //List<String> _classNames = List<String>();

  // void updateClassList(List<String> classList) {
  //   setState(() => _classNames = classList);
  // }

  // void moveToSecondPage() async {
  //   final information = await Navigator.push(
  //     context,
  //     CupertinoPageRoute(
  //         fullscreenDialog: true, builder: (context) => AddClassWidget()),
  //   );
  //   updateClassList(information);
  // }

  @override
  Widget build(BuildContext context) {
    //print(_classNames);
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome INSTRUCTOR NAME'),
        centerTitle: true,
        backgroundColor: green,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
                child: ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                    top: 25.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Class List',
                        style: TextStyle(
                          color: purple,
                          fontSize: 30.0,
                          fontFamily: 'Avenir',
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 200,
                  width: 100,
                  child: ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      // return Text(classNames[index]);
                      return InkWell(
                        onTap: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => InstructorIntoClass(
                                        classTitle: classNames[index],
                                      )))
                        },
                        child: Column(
                          children: <Widget>[
                            Padding(padding: new EdgeInsets.all(3.0)),
                            Text(classNames[index])
                          ],
                        ),
                      );
                    },
                    itemCount: classNames.length,
                  ),
                ),
                Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Container(
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
                                  controller: classNameController,
                                  decoration: InputDecoration.collapsed(
                                      hintText: 'Class Name'),
                                  onSubmitted: (className) {
                                    classNames.add(className);
                                    classNameController.clear();
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
                                  //controller: classIDTextController,
                                  decoration: InputDecoration.collapsed(
                                      hintText: 'Class ID'),

                                  // onChanged: (classID) {
                                  //   classIDs.add(classID);
                                  // },
                                ),
                              ),
                              SizedBox(
                                width: 100,
                                child: MaterialButton(
                                    onPressed: () {
                                      classNameController.clear();
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
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )),
            // FlatButton(
            //   onPressed: () {
            //     Navigator.pushNamed(context, '/instructorIntoClass');
            //   },
            //   child: Text('Class View temp button'),
            // ),
          ],
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
                builder: (context) => AddClassWidget(),
              );
              _showButton(false);

              sheetController.closed.then((value) {
                _showButton(true);
              });
              AddClassWidget();
            },
            icon: Icon(Icons.add),
            label: Text('Add Class',
                style: TextStyle(
                  fontSize: 20.0,
                  fontFamily: 'Avenir',
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
