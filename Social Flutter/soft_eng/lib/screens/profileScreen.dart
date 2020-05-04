import 'package:flutter/material.dart';
import 'package:soft_eng/screens/login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:soft_eng/Packet.dart';

class ProfileScreen extends StatelessWidget {
  final UserDetails detailsUser;

  ProfileScreen({Key key, @required this.detailsUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Packet.currentContext = context;
    final GoogleSignIn _gSignIn = GoogleSignIn();

    return Scaffold(
        appBar: AppBar(
          backgroundColor: green,
          centerTitle: true,
          title: Text(
            "Welcome " + detailsUser.userName + "!",
            style: TextStyle(color: Colors.white, fontSize: 20.0),
          ),
          automaticallyImplyLeading: false,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                FontAwesomeIcons.signOutAlt,
                size: 28.0,
                color: Colors.white,
              ),
              onPressed: () {
                _gSignIn.signOut();
                print('Signed out');
                Navigator.popUntil(context, ModalRoute.withName("/"));
              },
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                backgroundImage: NetworkImage(detailsUser.photoUrl),
                radius: 65.0,
              ),
              SizedBox(height: 10.0),
              Text(
                "Name: " + detailsUser.userName,
                style: TextStyle(
                    //fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 15.0),
              ),
              SizedBox(height: 10.0),
              Text(
                "Email : " + detailsUser.userEmail,
                style: TextStyle(
                    //fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 15.0),
              ),
              SizedBox(height: 50.0),
              // Text(
              //   "Provider : " + detailsUser.providerDetails,
              //   style: TextStyle(
              //       fontWeight: FontWeight.bold,
              //       color: Colors.black,
              //       fontSize: 15.0),
              // ),
              Text(
                'Please upload a clear photo of your face:',
                style: TextStyle(
                  color: darkPurple,
                  fontSize: 20,
                ),
              ),
              IconButton(
                icon: Icon(
                  FontAwesomeIcons.camera,
                  size: 30.0,
                  color: lightPurple,
                ),
                onPressed: () {}, //ADD CAMERA ROLL OPENING HEREEEE
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    RaisedButton(
                      onPressed: () {
                        Navigator.pushNamed(context,
                            '/instructorHome'); //CHANGE TO REDIRECT TO GOOGLE AUTH
                      },
                      child: Text(
                        'Instructor',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      color: purple,
                    ),
                    RaisedButton(
                      onPressed: () {
                        Navigator.pushNamed(context,
                            '/studentHome'); //CHANGE TO REDIRECT TO GOOGLE AUTH
                      },
                      child: Text(
                        'Student',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      color: purple,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
