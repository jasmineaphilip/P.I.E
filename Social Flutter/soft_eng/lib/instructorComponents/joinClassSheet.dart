import 'package:flutter/material.dart';
import 'package:soft_eng/screens/StudentHome.dart';
import 'package:soft_eng/screens/login.dart';

class AddClassWidget extends StatefulWidget {
  const AddClassWidget({Key key}) : super(key: key);

  @override
  _AddClassWidgetState createState() => _AddClassWidgetState();
}

class _AddClassWidgetState extends State<AddClassWidget> {
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
                    // onChanged: (className) {
                    //   classNames.add(className);
                    // },
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
                    decoration: InputDecoration.collapsed(hintText: 'Class ID'),
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
                          // setState(() {
                          //   classNamesList.add(classNameTextController.text);
                          // });
                          print('from sheet:');
                          print(classNamesList);
                          Navigator.pop(
                            context,
                            MaterialPageRoute(
                              builder: (context) => StudentHome(
                                classNames: classNamesList,
                              ),
                            ),
                          );
                        },
                        child: Text(
                          'Join',
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

// class DecoratedTextFieldName extends StatefulWidget {
//   @override
//   _DecoratedTextFieldNameState createState() => _DecoratedTextFieldNameState();
// }

// class _DecoratedTextFieldNameState extends State<DecoratedTextFieldName> {
//   String tempName;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 50,
//       alignment: Alignment.center,
//       padding: const EdgeInsets.all(10),
//       margin: const EdgeInsets.all(10),
//       decoration: BoxDecoration(
//         color: Colors.grey[300],
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: TextField(
//         decoration: InputDecoration.collapsed(hintText: 'Class Name'),
//         // onChanged: (strName) {
//         //   tempName = strName;
//         // },
//       ),
//     );
//   }
// }

// class DecoratedTextFieldID extends StatefulWidget {
//   @override
//   _DecoratedTextFieldIDState createState() => _DecoratedTextFieldIDState();
// }

// class _DecoratedTextFieldIDState extends State<DecoratedTextFieldID> {
//   //String tempID;
//   var _classIDController = new TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 50,
//       alignment: Alignment.center,
//       padding: const EdgeInsets.all(10),
//       margin: const EdgeInsets.all(10),
//       decoration: BoxDecoration(
//         color: Colors.grey[300],
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: TextField(
//         decoration: InputDecoration.collapsed(hintText: 'Class ID'),
//         // onChanged: (strID) {
//         //   tempID = strID;
//         // },
//         controller: _classIDController,
//       ),
//     );
//   }
// }

// class SheetButton extends StatefulWidget {
//   SheetButton({Key key}) : super(key: key);

//   _SheetButtonState createState() => _SheetButtonState();
// }

// class _SheetButtonState extends State<SheetButton> {
//   bool checkingFlight = false;
//   bool success = false;

//   @override
//   Widget build(BuildContext context) {
//     return !checkingFlight
//         ? SizedBox(
//             width: 100,
//             child: MaterialButton(
//               minWidth: 10.0,
//               color: green,
//               onPressed: () async {
//                 setState(() {
//                   checkingFlight = true;
//                 });

//                 await Future.delayed(Duration(seconds: 1));

//                 setState(() {
//                   success = true;
//                 });

//                 await Future.delayed(Duration(milliseconds: 500));

//                 Navigator.pop(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) =>
//                             InstructorHome(className: 'test class name')));
//               },
//               child: Text(
//                 'Add Class',
//                 style: TextStyle(
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           )
//         : !success
//             ? CircularProgressIndicator()
//             : Icon(
//                 Icons.check,
//                 color: Colors.green,
//               );
//   }
// }

// class CancelButton extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: 100,
//       child: MaterialButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           minWidth: 10.0,
//           color: green,
//           child: Text(
//             'Cancel',
//             style: TextStyle(
//               color: Colors.white,
//             ),
//           )),
//     );
//   }
// }
