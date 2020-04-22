import 'package:flutter/material.dart';
import 'package:soft_eng/instructorComponents/addClassSheet.dart';
import 'package:soft_eng/screens/login.dart';

class InstructorHome extends StatefulWidget {
  //final String className;
  //final String classID;
  final List<String> classNames;
  // final bool visible;
  InstructorHome({Key key, @required this.classNames}) : super(key: key);

  @override
  _InstructorHomeState createState() => _InstructorHomeState();
}

class _InstructorHomeState extends State<InstructorHome> {
  // void getData() {
  //   //simulate network request for username
  //   Future.delayed(Duration(seconds: 3), () {
  //     print('jasmine');
  //   });
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   getData();
  // }

  // List<String> classIDs = List();

  @override
  Widget build(BuildContext context) {
    print('from home');
    print(widget.classNames);
    if (widget.classNames == null) {
      print('its null');
      return
          // widget.visible
          //     ?
          Scaffold(
        appBar: AppBar(
          title: Text('Welcome INSTRUCTOR NAME'),
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
                // ListView(
                //   children: classItem
                //       .map(
                //         (element) => Text(element),
                //       )
                //       .toList(),
                // ),

                // Expanded(
                //   child: ListView(
                //     shrinkWrap: true,
                //     children: widget.classNames
                //         .map((element) => Text(element))
                //         .toList(),
                //   ),
                // ),

                Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: AddClassButton(),
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/instructorIntoClass');
                  },
                  child: Text('Class View temp button'),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return
          // widget.visible
          //     ?
          Scaffold(
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
                      fontFamily: 'Avenir',
                    ),
                  ),
                ),
                // ListView(
                //   children: classItem
                //       .map(
                //         (element) => Text(element),
                //       )
                //       .toList(),
                // ),

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
                    Navigator.pushNamed(context, '/instructorIntoClass');
                  },
                  child: Text('Class View temp button'),
                ),
              ],
            ),
          ),
        ),
      );
    }
    // : Scaffold(
    //     appBar: AppBar(
    //       title: Text('Welcome NAME'),
    //       centerTitle: true,
    //       backgroundColor: green,
    //     ),
    //     body: Container(
    //       child: Center(
    //         child: Column(
    //           children: <Widget>[
    //             Padding(
    //               padding: const EdgeInsets.only(
    //                 top: 50.0,
    //               ),
    //               child: Text(
    //                 'Class List',
    //                 style: TextStyle(
    //                   color: purple,
    //                   fontSize: 30.0,
    //                   fontFamily: 'Avenir',
    //                 ),
    //               ),
    //             ),
    //             // ListView(
    //             //   children: classItem
    //             //       .map(
    //             //         (element) => Text(element),
    //             //       )
    //             //       .toList(),
    //             // ),

    //             Padding(
    //               padding: const EdgeInsets.only(top: 40.0),
    //               child: AddClassButton(),
    //             ),
    //             FlatButton(
    //               onPressed: () {
    //                 Navigator.pushNamed(context, '/instructorIntoClass');
    //               },
    //               child: Text('Class View temp button'),
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //   );
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
