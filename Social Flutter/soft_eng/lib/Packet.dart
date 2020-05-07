import 'dart:io';
import 'dart:convert';
import 'package:easy_udp/easy_udp.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as ImageLib;
import 'package:soft_eng/screens/profileScreen.dart';
import 'package:soft_eng/screens/login.dart';

class Packet {

  static const int JOIN = 0;
  static const int LEAVE = 1;
  static const int IMAGE_SIGNUP = 2;
  static const int IMAGE_RESPONSE = 3;
  static const int SIGNUP = 4;
  static const int INVALID_TOKEN = 5;
  static const int ADD_CLASS = 6;
  static const int GET_CLASS_INFO = 7;
  static const int JOIN_CLASS = 8;
  static const int CREATE_SESSION = 9;
  static const int GET_SESSIONS = 10;
  static const int JOIN_SESSION = 11;
  static const int GET_SESSION_PARTICIPANTS = 12;
  static const int NFC_SIGNIN = 13;
  static const int IMAGE_SIGNIN = 14;
  static const int CONFIRM_SIGNIN = 15;
  static const int ADD_FEEDBACK = 16;
  static const int GET_FEEDBACK = 17;
  static const int CREATE_GROUP = 18;
  static const int SHOW_STUDYGROUPS = 19;
  static const int REPORT_ISSUE = 20;
  static const int STOP_SESSION = 21;
  static const int GET_CURRENT_SESSION = 22;

  static const String DELIMITER = "|";
  static const String DATA_DELIMITER = "`";

  static const int PORT = 25595;
  static final InternetAddress IP = new InternetAddress("18.220.57.115");
  static var socket;
  static bool running = false;
  static BuildContext currentContext;
  static String token = "iamstudent";
  static UserDetails userDetails;

  int packet_id;
  String raw_data, data;

  Packet(int packet_id, String token, var arg)
  {
    this.packet_id = packet_id;
    this.data = _insertDelim(DATA_DELIMITER, arg);
    this.raw_data = _insertDelim(DELIMITER, [this.packet_id, token, this.data]);
  }
  Packet.fromServer(String raw_data)
  {
    this.raw_data=raw_data;
    this.packet_id = int.parse(raw_data.split(DELIMITER)[0]);
    this.data = raw_data.split(DELIMITER)[1];
  }

  String getRawData()
  {
    return raw_data;
  }
  int getPacketID()
  {
    return this.packet_id;
  }
  String getData()
  {
    return this.data;
  }
  List <String> getDataEntries()
  {
    return this.data.split(DATA_DELIMITER);
  }

 String _insertDelim(String delim, var arg)
 {
    String ret = "";
    for (var s in arg)
    {
      ret = ret + s.toString() + delim;
    }
    return ret;
  }
}

void sendPacket(Packet p) async
{
  var codec = new Utf8Codec();
  await Packet.socket.send(codec.encode(p.getRawData()), Packet.IP, Packet.PORT);
}

void sendFile(String path, int port) async
{
  File file = new File(path);
  Socket s = await Socket.connect(Packet.IP, port);
  await s.addStream(file.openRead());
  s.close();
}

Future<Packet> receivePacket(int id) async
{
  var codec = new Utf8Codec();
  final resp = await Packet.socket.receive();
  Packet p = new Packet.fromServer(codec.decode(resp.data));
  if (p.getPacketID() == id)
  {
    return p;
  }
  return null;
}

void networkLoop() async
{
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  final camera = cameras[1];

  Packet.running = true;
  Packet.socket = await EasyUDPSocket.bind(InternetAddress.anyIPv4, 50000);
  var codec = new Utf8Codec();
  while (Packet.running)
  {
    final resp = await Packet.socket.receive();
    Packet p = new Packet.fromServer(codec.decode(resp.data));

    switch (p.getPacketID())
    {
      case Packet.JOIN:
        //_showDialog(p.getDataEntries()[0]);
        // print login success message
        break;
      case Packet.SIGNUP:
        List<String> entries = p.getDataEntries();
        Navigator.push(Packet.currentContext, new MaterialPageRoute(builder: (context) => SignUpScreen(message: entries[0], firstName: entries[1], lastName: entries[2])));
        break;
      case Packet.IMAGE_SIGNUP:
        int port = int.parse(p.getDataEntries()[0]);
        Navigator.push(Packet.currentContext, new MaterialPageRoute(builder: (context) => TakePictureScreen(camera: camera, port: port, mode: Packet.IMAGE_SIGNUP)));
        break;
      case Packet.IMAGE_SIGNIN:
        int port = int.parse(p.getDataEntries()[0]);
        Navigator.push(Packet.currentContext, new MaterialPageRoute(builder: (context) => TakePictureScreen(camera: camera, port: port, mode: Packet.IMAGE_SIGNIN)));
        break;
      case Packet.NFC_SIGNIN:
        String newKey = p.getDataEntries()[0];
        // get the new key
        // write new key to tag
        break;

      default:
        // also print general message to user
        print (p.getData());
    }
  }
  Packet.socket.close();
}



void _showDialog(String message) {
  // flutter defined function
  showDialog(
    context: Packet.currentContext,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        title: new Text("Alert Dialog title"),
        content: new Text(message),
        actions: <Widget>[
          // usually buttons at the bottom of the dialog
          new FlatButton(
            child: new Text("Close"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}


class SignUpScreen extends StatefulWidget
{
  final String firstName, lastName, message;

  const SignUpScreen({Key key, this.message, this.firstName, this.lastName}) : super(key: key);

  SignUpScreenState createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen>
{
  String role = "Student";

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();

  @override
  void initState()
  {
    super.initState();

  }

  @override
  void dispose()
  {
    firstNameController.dispose();
    lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(title: Text("First Time Sign-up"),
      ),
      body: _buildForm(),
    );
  }

  Widget _buildForm() {
    return Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Text(widget.message), SizedBox(height: 50),
          _buildFirstNameField(), SizedBox(height: 20),
          _buildLastNameField(), SizedBox(height: 50),
          new Text("What type of user are you?"), SizedBox(height: 20),
          _buildRoleDropDown(), SizedBox(height: 50),
          _buildSubmitButton(),
        ],
     )
    );
  }


  Widget _buildFirstNameField() {
    return TextField(
      decoration: InputDecoration(labelText: "First Name", hintText: widget.firstName),
      controller: firstNameController,
    );
  }

  Widget _buildLastNameField() {
    return TextField(
      decoration: InputDecoration(labelText: "Last Name", hintText: widget.lastName),
      controller: lastNameController,
    );
  }

  Widget _buildRoleDropDown()
  {
    return DropdownButton<String>(
      value: role,
      icon: Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(
          color: Colors.deepPurple
      ),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String newValue) {
        setState(() {
          role = newValue;
        });
      },
      items: <String>["Student", "Instructor"]
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      })
          .toList(),
    );
  }

  Widget _buildSubmitButton() {
    return RaisedButton(
      onPressed: () {
        String roleInt = (role == "Student") ? "0": "1";
        Packet signup = new Packet(Packet.SIGNUP, Packet.token, [firstNameController.text, lastNameController.text, roleInt, "1"]);
        sendPacket(signup);

        Packet imageSignup = new Packet(Packet.IMAGE_SIGNUP, Packet.token, [""]);
        sendPacket(imageSignup);
      },
      child: Text('Submit'),
    );
  }
}

class TakePictureScreen extends StatefulWidget {
  final CameraDescription camera;
  final int port, mode;

  const TakePictureScreen({
    Key key,
    @required this.camera, this.port, this.mode,
  }) : super(key: key);

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  CameraController _controller;
  Future<void> _initializeControllerFuture;

  @override
  void initState() {

    super.initState();
    // To display the current output from the Camera,
    // create a CameraController.
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.camera,
      // Define the resolution to use.
      ResolutionPreset.max,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Take a picture')),
      // Wait until the controller is initialized before displaying the
      // camera preview. Use a FutureBuilder to display a loading spinner
      // until the controller has finished initializing.
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview.
            return CameraPreview(_controller);
          } else {
            // Otherwise, display a loading indicator.
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera_alt),
        // Provide an onPressed callback.
        onPressed: () async {
          // Take the Picture in a try / catch block. If anything goes wrong,
          // catch the error.
          try {
            // Ensure that the camera is initialized.
            await _initializeControllerFuture;

            // Construct the path where the image should be saved using the
            // pattern package.
            final path = join(
              // Store the picture in the temp directory.
              // Find the temp directory using the `path_provider` plugin.
              (await getTemporaryDirectory()).path,
              '${DateTime.now()}.png',
            );

            // Attempt to take a picture and log where it's been saved.
            await _controller.takePicture(path);

            ImageLib.Image image= ImageLib.decodeImage(File(path).readAsBytesSync());
            ImageLib.flipVertical(image);
            File(path).writeAsBytes(ImageLib.encodeJpg(image));

            // If the picture was taken, display it on a new screen.
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DisplayPictureScreen(imagePath: path, port: widget.port, mode: widget.mode),
              ),
            );
          } catch (e) {
            // If an error occurs, log the error to the console.
            print(e);
          }
        },
      ),
    );
  }
}

// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatelessWidget {
  //final String imagePath;
  final String imagePath;
  final int port, mode;
  const DisplayPictureScreen({Key key, this.imagePath, this.port, this.mode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Review')),
    floatingActionButton: FloatingActionButton.extended(
      onPressed: ()
      {
        // send image
        sendFile(imagePath, port);
        if (mode == Packet.IMAGE_SIGNUP)
        {
          Navigator.push(context, new MaterialPageRoute(builder: (context) => ProfileScreen(detailsUser: Packet.userDetails)));
          //Navigator.popUntil(context, ModalRoute.withName("/profileScreen"));
        }
        else if (mode == Packet.IMAGE_SIGNIN)
        {
            // TODO nav to proper screen
        }

      },
      label: Text("OK"),
      backgroundColor: Colors.pink,
    ),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Image.file(File(imagePath)),
    );
  }
}



