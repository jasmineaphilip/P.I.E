import 'package:flutter/material.dart';

Map<int, Color> customGreen = {
  900: Color.fromRGBO(88, 186, 159, 1),
};
MaterialColor green = MaterialColor(0xFF58BA9F, customGreen);

Map<int, Color> customWhite = {
  900: Color.fromRGBO(248, 245, 245, 1),
};
MaterialColor white = MaterialColor(0xf8f5f5, customWhite);

Map<int, Color> customPurple = {
  900: Color.fromRGBO(73, 0, 154, 1),
};
MaterialColor purple = MaterialColor(0xFF49009A, customPurple);

Map<int, Color> customLightPurple = {
  900: Color.fromRGBO(118, 126, 163, 1),
};
MaterialColor lightPurple = MaterialColor(0xFF767EA3, customLightPurple);

Map<int, Color> customDarkPurple = {
  900: Color.fromRGBO(66, 51, 91, 1),
};
MaterialColor darkPurple = MaterialColor(0xff42335B, customDarkPurple);

Map<int, Color> customBlue = {
  900: Color.fromRGBO(31, 39, 64, 1),
};
MaterialColor blue = MaterialColor(0xFF1f2740, customBlue);

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        centerTitle: true,
        backgroundColor: green,
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          color: const Color(0xff7c94b6),
          image: DecorationImage(
            image: AssetImage('./images/background.png'),
            fit: BoxFit.cover,
            colorFilter: new ColorFilter.mode(
                Colors.grey.withOpacity(0.7), BlendMode.dstATop),
          ),
        ),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                'Welcome To',
                style: TextStyle(
                  fontSize: 50,
                  color: Colors.white,
                  letterSpacing: 2,
                ),
              ),
            ),
            Text(
              'P.I.E.',
              style: TextStyle(
                fontSize: 75,
                color: Colors.white,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 30),
              child: CircleAvatar(
                radius: 80,
                backgroundColor: Color(0xFF49009A),
                child: CircleAvatar(
                  radius: 75,
                  backgroundImage: AssetImage('./images/logo.png'),
                ),
              ),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.pushNamed(context,
                    '/instructorHome'); //CHANGE TO REDIRECT TO GOOGLE AUTH
              },
              child: Text(
                'Sign up',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              color: purple,
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 30),
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
                        color: green,
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
                        color: green,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
