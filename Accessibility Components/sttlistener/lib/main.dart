import 'package:flutter/material.dart';
//Async
import 'dart:async';
import 'package:mutex/mutex.dart';
//
//STT pub
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
//
import 'dart:io'; //Timer stuff
import 'package:dynamic_theme/dynamic_theme.dart'; //Dynamic Theme pub
//TTS pub
import 'package:flutter_tts/flutter_tts.dart';

void main() => runApp(MyApp()); //Start app running myapp

final GlobalKey<ScaffoldState> _drawerKeyK = new GlobalKey(); //Key
final int numberSTT = 0;
Brightness brightness; //Global variable for theme

class MyApp extends StatelessWidget {
  //Starting Point
  @override
  Widget build(BuildContext context) {
    return new DynamicTheme(
        // Add-on for dynamically changing theme
        defaultBrightness: Brightness
            .light, //Two different types Light and Dark mode dependent on phone
        data: (brightness) => new ThemeData(brightness: brightness),
        themedWidgetBuilder: (context, theme) {
          //Set the app under Dynamic Theme
          return new MaterialApp(
            title: 'Flutter STT Demo',
            theme: theme,
            home: STTListener(), //Launch STT page
          );
        });
  }
}

class STTListener extends StatefulWidget {
  //STT page
  @override
  _STTListenerState createState() => _STTListenerState(); //Create state
}

class _STTListenerState extends State<STTListener> {
  //State

  final FlutterTts flutterTts = FlutterTts(); //Set up STT class

  final SpeechToText _STTRecog = SpeechToText(); //Set up STT Class

  Mutex lockSTT = Mutex();
  String audioText = ""; //Local String for spoken results
  String StoredText = ""; //Local String for stored results
  String oldText = ""; //Old copy of Stored Text
  String oldTextCatch =
      ""; //a copy of Stored Text to compare for double listener problems
  String internalRef = ""; //Debuging and command mode text
  bool _STTisAvailable = false; //checking for availability
  bool _STTChecked = false; //if checked for STT once
  bool commandModeSTT = false; //If in command mode
  bool listenerModeSTT = false; //If in command mode
  bool multListener = false; //If for some reason there's multiple listeners
  double level = 0.0; //sound level i believe unused really.
  String lastError = ""; //Error Holder
  String _currentLocaleId = ""; //used Locale for STT
  List<LocaleName> _localeNames = []; //List of Available STT lang

  void initState() {
    super.initState();
    //initSTTState();
  }

  //Fail-STT
  void _showSTTFail() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("STT not Recongized"),
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
  // END of Fail-STT

  //Display Commands
  void _showSTTCommands() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("STT Commands"),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Commands.'),
                Text('Go Back.'),
                Text('Class View.'),
                Text('Start Session.'),
                Text('Past Session.'),
                Text('Read Screen.'),
                Text('Read Header.'),
                Text('Read Body.'),
                Text('Read Bottom.'),
              ],
            ),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                multListener = true;
                lockSTT.release();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  //END of Display Commands

  // Start up STT
  Future<void> initSTTState() async {
    if(!_STTChecked && !_STTisAvailable)
      {
        bool STTisAvailable = await _STTRecog.initialize(
            onError: errorListener,
            onStatus: statusListener); //returns if there is STT on the smart phone
        if (STTisAvailable) {

          //if it is available
          _localeNames = await _STTRecog
              .locales(); //retrieve all capable locales (all available lang)

          var systemLocale = await _STTRecog.systemLocale(); //Get current locale
          _currentLocaleId = systemLocale.localeId; //set so.
        }

        if (!mounted) return;

        setState(() {
          //Update app with STT is available
          _STTisAvailable = STTisAvailable;
          _STTChecked = true;
        });
      }
  }
  //End of Startup: STT

  //command Mode toggle
  void toggleCommandSTT() {
    if (commandModeSTT) {
      commandModeSTT = false;
      internalRef = "";
    }
    else {
      commandModeSTT = true;
      internalRef = "Command mode is ON";
    }
    setState(() {});
  }
  //END Command Mode toggle

  //Listener Mode toggle
  void toggleListenerSTT() {
    if (listenerModeSTT)
      listenerModeSTT = false;
    else
      listenerModeSTT = true;
    setState(() {});
  }
  //END Listener Mode toggle

  //String to Command function:
  void detectKey(String key) async {
    //Phrase Decoding:
    bool detectedKey = false;
    internalRef = "Command: " + key;
    if (key.toLowerCase() == "turn off command mode"){
      commandModeSTT = false;
      internalRef = "";
      return;
    }
    else if (key.toLowerCase() == "turn on command mode"){
      internalRef = "Command mode is ON";
      return;
    }
    else if (key.toLowerCase() == "open sidebar"){
      _drawerKeyK.currentState.openDrawer();
      detectedKey = true;
    }
    else if (key.toLowerCase() == "change theme") {
      DynamicTheme.of(context).setThemeData(ThemeData(
        brightness: Theme.of(context).brightness == Brightness.dark
            ? Brightness.light
            : Brightness.dark,
      ));
      detectedKey = true;
    } else if (key.toLowerCase() == "dark mode") {
      DynamicTheme.of(context).setBrightness(Brightness.dark);
      detectedKey = true;
    } else if (key.toLowerCase() == "light mode") {
      DynamicTheme.of(context).setBrightness(Brightness.light);
      detectedKey = true;
    } else if (key.toLowerCase() == "clear history") {
      StoredText = "";
      detectedKey = true;
    } else if (key.toLowerCase() == "switch page") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SecondRoute()),
      );
      detectedKey = true;
    } else if (key.toLowerCase() == "help" || key.toLowerCase() == "command" || key.toLowerCase() == "commands" ){
      await lockSTT.acquire();
      StoredText = """
    Commands Available:
      clear history
      open sidebar
      change theme
        -light mode
        -dark mode
      help
      TTS:
        read screen
        read header
        read history
        read all buttons
      turn off command mode
      """;
      if(!multListener){
        setState(() {
          multListener = true;
        });
        _showSTTCommands();
      }
      else
        multListener = false;
      detectedKey = true;
    }
    else if (key.toLowerCase() == "read screen"){
      detectedKey = true;
      speak(allTTS: true);
    }
    else if (key.toLowerCase() == "read header") {
      detectedKey = true;
      speak(headerTTS: true);
    }
    else if (key.toLowerCase() == "read history"){
      detectedKey = true;
      speak(historyTTS: true);
    }
    else if (key.toLowerCase() == "read black box"){
      detectedKey = true;
      speak(lastErrorTTS: true, internalRefTTS: true);
    }
    else if (key.toLowerCase() == "read body buttons"){
      detectedKey = true;
      speak(buttonBodyTTS: true);
    }
    else if (key.toLowerCase() == "read bottom buttons"){
      detectedKey = true;
      speak(buttonBottomTTS: true);
    }
    else if (key.toLowerCase() == "read all buttons"){
      detectedKey = true;
      speak(buttonBodyTTS: true, buttonBottomTTS: true);
    }
    else if (key.toLowerCase() == "read green text"){
      detectedKey = true;
      speak(underBoxTTS: true);
    }

    if(detectedKey) internalRef = "Command detected: " + key;
    else audioText = "Unknown Command: " + key + " Say: \"Commands\" for list of commands";
    if(key  == "") {
      audioText = "";
      StoredText = oldText;
    }
    setState(() {});
  }
  //END String to Command

  @override
// RENDERING of UI START
  Widget build(BuildContext context) {
    return Scaffold(
      key: _drawerKeyK, //reference point
// AppBar
      appBar: AppBar(
        title: Text('TTS and STT Demo'),
      ),
// End AppBar
//Drawer
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            //Drawer AppBar
            AppBar(
              title: Text('Extra Options'),
            ),
            //END Draw AppBar
            // Change Theme button
            RaisedButton(
              // Start STT
              child: Row(
                children: <Widget>[
                  Container(
                    child: Text(' Change Theme'),
                  ),
                ],
              ),
              onPressed: changeBrightness,
            ),
            //END Change Theme button
            // Test TTS button
            RaisedButton(
              // Start STT
              child: Row(
                children: <Widget>[
                  Container(
                    child: Text(' Set TTS Demo'),
                  ),
                ],
              ),
              onPressed: () => setState(() {
                StoredText = """Welcome to specific Text-To-Speech demo setup: 
                This is just setting up so the history is to be read by the TTS API.""";
              }),
            ),
            // END Test TTS button
            // Command Mode button
            RaisedButton(
              // Start STT
              child: Row(
                children: <Widget>[
                  Container(
                    child: Text(commandModeSTT ? "ON" : "OFF"),
                    color: commandModeSTT ? Colors.green : Colors.red,
                  ),
                  Container(
                    child: Text(' Command Mode'),
                  ),
                ],
              ),
              onPressed: toggleCommandSTT,
            ),
            // END Command Mode button
            //Listener Mode button
            RaisedButton(
              // Start STT
              child: Row(
                children: <Widget>[
                  Container(
                    child: Text(listenerModeSTT ? "ON" : "OFF"),
                    color: listenerModeSTT ? Colors.green : Colors.red,
                  ),
                  Container(
                    child: Text(' Listener Mode (Beta)'),
                  ),
                ],
              ),
              onPressed: toggleListenerSTT,
            ),
            //END Listener Mode button
            // STRING
            Text('Current Locale:'),
            // END STRING
            //DropDown
            DropdownButton(
              onChanged: (selectedVal) => _switchLang(selectedVal),
              isExpanded: true,
              value: _currentLocaleId,
              items: _localeNames
                  .map(
                    (localeName) => DropdownMenuItem(
                      value: localeName.localeId,
                      child: Text(localeName.name),
                    ),
                  )
                  .toList(),
            )
            //EMD DropDown
          ],
        ),
      ),
//Drawer End
// BottomAPPBar
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //Cancel Button: cancelListening()
            RaisedButton(
              // Stop STT
              child: Row(
                children: <Widget>[
                  Container(
                    child: Icon(Icons.mic_off),
                  ),
                  Container(
                    child: Text('Cancel', style: TextStyle(fontSize: 10)),
                  ),
                ],
              ),
              onPressed: _STTRecog.isListening ? cancelListening : null,
            ),
            //END Cancel Button
            // Stop Button: stopListening()
            RaisedButton(
              // Stop STT
              child: Row(
                children: <Widget>[
                  Container(
                    child: Icon(Icons.stop),
                  ),
                  Container(
                    child: Text('Stop', style: TextStyle(fontSize: 10)),
                  ),
                ],
              ),
              onPressed: () => setState(() {
                return AlertDialog(
                  title: new Text("STT not Recognized"),
                );
              })
            ),
            // END Stop Button
            //Start TTS: speak(allTTS: true),
            RaisedButton(
              // Stop STT
              child: Row(
                children: <Widget>[
                  Container(
                    child: Text('Read Screen', style: TextStyle(fontSize: 10)),
                  ),
                ],
              ),
              onPressed: () => speak(allTTS: true),
            ),
            //END Start TTS
            // Start Button: startListening()
            IconButton(
              // Start STT
              icon: Icon(_STTisAvailable ? (!_STTRecog.isListening ? Icons.mic : Icons.pause) : Icons.mic_off),
              tooltip: audioText,
              onPressed:
              !_STTRecog.isListening ?
                  (
                  !_STTisAvailable
                      ? _showSTTFail
                      : startListening)
                  : stopListening,
            ),
            // END Start Button
          ],
        ),
      ),
// BottomAPPBar END
//BODY
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          //crossAxisAlignment: ,
          children: <Widget>[
            // STRING
            Text('Recorded History: (can be cleared by clear button)'),
            // END STRING
            //History:
            new Expanded(
              //Test
              //Set Max Width of text to 90% of screen
              child: new SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  vertical: 5.0,
                  horizontal: 10.0,
                ),
                child: Text(
                  StoredText,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            //END HISTORY
            // Voice Input Text Var: audioText
            Container(
              //Test
              //Set Max Width of text to 90% of screen
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(6.0)),
              padding: EdgeInsets.symmetric(
                vertical: 5.0,
                horizontal: 10.0,
              ),
              child: Text(
                audioText,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            // END Voice Input Text
            //ERROR Text Var: lastError
            Container(
              //Test
              //Set Max Width of text to 90% of screen
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(6.0)),
              padding: EdgeInsets.symmetric(
                vertical: 5.0,
                horizontal: 10.0,
              ),
              child: Text(
                lastError,
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
            ),
            //END ERROR Text
            // Command Text Var: internalRef
            Container(
              //Test
              //Set Max Width of text to 90% of screen
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(6.0)),
              padding: EdgeInsets.symmetric(
                vertical: 5.0,
                horizontal: 10.0,
              ),
              child: Text(
                internalRef,
                style:
                    TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
              ),
            ),
            // END Command Text
            //String "Command Mode only works with English"
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Command Mode only works with English.",
                        style: TextStyle(
                            color: Colors.green, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            //END String
            // Circular Buttons:
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FloatingActionButton(
                  child: Text('CLEAR'),
                  foregroundColor:
                      !_STTisAvailable ? Colors.white : Colors.green,
                  backgroundColor:
                      !_STTisAvailable ? Colors.black26 : Colors.red,
                  onPressed: () {
                    StoredText = "";
                    audioText = "";
                    setState(() {});
                  },
                ),
                FloatingActionButton(
                  child: Text('Enable'),
                  foregroundColor:
                      _STTisAvailable ? Colors.white : Colors.green,
                  backgroundColor:
                      _STTisAvailable ? Colors.black26 : Colors.red,
                  onPressed: _STTisAvailable ? null : initSTTState,
                ),
              ],
            ),
            // END CB
          ],
        ),
      ),
//BODY END
    );
  }
// END OF RENDERING of UI

  //TTS FUNCTIONS
  Future<void> speak(
      {String spokenByTTS = '',
      bool allTTS = false,
      bool headerTTS = false,
      bool historyTTS = false,
      bool commandTTS = false,
      bool buttonBodyTTS = false,
      bool buttonBottomTTS = false,
      bool audioTextTTS = false,
      bool lastErrorTTS = false,
      bool internalRefTTS = false,
      bool clearTextTTS = false,
      bool enableTextTTS = false,
      bool cancelTTS = false,
      bool stopTTS = false,
      bool buttonTTS = false,
      bool startTTS = false,
      bool underBoxTTS = false}) async {
    /*
    App {topBar or header} is Speech To Text Listener
    History: {Var: StoredText}
    Last Voice input: {Black Box 1 Var: audioText}
    {Black Box 2 Var: lastError}
    {Black Box 3 Var: internalRef}
    Command Mode only works with English
    SorcllSelect box
    Buttons: Left to right: CLEAR Text and Enable STT
    Buttons: Left to right: Stop , Cancel, TTS,
    */

    // Header section
    if (headerTTS || allTTS) {
      spokenByTTS += 'Title is TTS and STT Demo....';
    }
    //Body section
    if (historyTTS || allTTS) {
      if (StoredText == "")
        spokenByTTS += "History is Empty....";
      else
        spokenByTTS += "Recorded History: " + StoredText + "....";
    }
    if (audioTextTTS || allTTS) {
      if (audioText == "")
        spokenByTTS += "Last voice input is Empty....";
      else
        spokenByTTS += "Last voice input: "+audioText + "....";
    }
    /*
    if (internalRefTTS || allTTS) {
      spokenByTTS += internalRef + "....";
    }
    if (lastErrorTTS || allTTS) {
      spokenByTTS += lastError + "....";
    }
     */
    //Button Body
    if (buttonBottomTTS || allTTS) {
      spokenByTTS += "Body buttons are...";
    }
    if (clearTextTTS || buttonBodyTTS || allTTS) {
      spokenByTTS += _STTisAvailable
          ? "Circular red Clear button ...."
          : "Circular dak Clear button ....";
    }
    if (enableTextTTS || buttonBodyTTS || allTTS) {
      spokenByTTS += _STTisAvailable
          ? "Circular dark Enable button ...."
          : "Circular red Enable button ....";
    }
    // Bottom Bar
    if (buttonBottomTTS || allTTS) {
      //Entered Bottom Buttons
      spokenByTTS += "Bottom buttons are...";
    }

    if (cancelTTS || buttonBottomTTS || allTTS) {
      if (!_STTRecog.isListening) {
        spokenByTTS += ' dark Cancel button....';
      } else if (Theme.of(context).brightness == Brightness.dark) {
        spokenByTTS += ' blue Cancel button....';
      } else {
        spokenByTTS += ' light Cancel button ....';
      }
    }
    if (stopTTS || buttonBottomTTS || allTTS) {
      if (!_STTRecog.isListening) {
        spokenByTTS += ' dark Stop button....';
      } else if (Theme.of(context).brightness == Brightness.dark) {
        spokenByTTS += ' blue Stop button....';
      } else {
        spokenByTTS += ' light Stop button....';
      }
    }
    if (buttonTTS || buttonBottomTTS || allTTS) {
      if (_STTRecog.isListening) {
        spokenByTTS += ' dark Read screen button....';
      } else if (Theme.of(context).brightness == Brightness.dark) {
        spokenByTTS += ' blue Read screen button....';
      } else {
        spokenByTTS += ' light Read screen button....';
      }
    }
    if (startTTS || buttonBottomTTS || allTTS) {
      if (_STTisAvailable) {
        spokenByTTS += ' dark Start button ....';
      } else if (Theme.of(context).brightness == Brightness.dark) {
        spokenByTTS += ' blue Start button ....';
      } else {
        spokenByTTS += ' light Start button ....';
      }
    }

    await flutterTts.setLanguage("en-US");
    await flutterTts.speak(spokenByTTS);
  }
  //END OF TTS FUNCTIONS

  // STT functions:
  void startListening() {
    //Start STT
    oldText = StoredText; //save storedText
    if(audioText != "")
    StoredText = """$StoredText 
      $audioText."""; //put on new line
    if(StoredText.startsWith(".")) StoredText.substring(2);
    audioText = "";
    _STTRecog.listen(
        //Start listening
        onResult: resultListener, //results pushed onto resultListener function
        listenFor: Duration(seconds: 6), //doesn't really work on android
        localeId: _currentLocaleId, //which locale to listen for
        onSoundLevelChange:
            soundLevelListener, //detecting sound levels for analysis
        cancelOnError:
            false, //just cancel when error, false so i can use errorListener for everything
        partialResults: true); //show words as they are found from STT
    setState(() {}); //Refresh
  }

  void stopListening() {
    //To stop STT function call
    _STTRecog.stop();
    setState(() {
      level = 0.0;
    });
  }

  void cancelListening() {
    //To cancel STT function call
    _STTRecog.cancel();
    setState(() {
      level = 0.0;
    });
  }

  void resultListener(SpeechRecognitionResult result) {
    //Conditional: finalResult if it is correct statement, if not it would be used each time it prints partial results.

    //result Listener
    setState(() {
      if (commandModeSTT) //print STT
        audioText = "Command: ${result.recognizedWords}";
      else
        audioText = "${result.recognizedWords}"; // - ${result.finalResult}";
    });
    if (result.finalResult &&
        !commandModeSTT &&
        (result.recognizedWords.toLowerCase() == "turn on command mode")) {
      commandModeSTT = true;
      internalRef = "Command Mode is Active";
      setState(() {});
    } else if (result.finalResult && !commandModeSTT && listenerModeSTT) {
      _STTRecog.cancel(); //to stop old one from timing out
      sleep(Duration(microseconds: 250)); //slight delay to let async cancel
      startListening(); //continue new line
    } else if (result.finalResult && commandModeSTT) {
      _STTRecog.cancel(); //to stop old one from timing out
      setState(() {
        multListener = false;
      });
      sleep(Duration(microseconds: 250)); //slight delay to let async cancel
      detectKey(result.recognizedWords); //scan result for command
    } else if(result.finalResult)
      _STTRecog.cancel(); //to stop old one from timing out
  }

  void soundLevelListener(double level) {
    //internally display sound level
    setState(() {
      this.level = level;
    });
  }

  void errorListener(SpeechRecognitionError error) {
    _STTRecog.cancel();
    //If error
    setState(() {
      lastError = "Error: ${error.errorMsg} - ${error.permanent}";
      StoredText = oldText;
      setState(() {
        level = 0.0;
      });
    });
  }

  void statusListener(String status) {
    //shows status of STT
    setState(() {
      lastError = "Status: $status";
    });
  }

  _switchLang(selectedVal) {
    //to help switch lang
    setState(() {
      _currentLocaleId = selectedVal;
    });
    print(selectedVal);
  }
  // END OF STT FUNCTIONS

  //Dynamic Theme Ex functions:
  void changeBrightness() {
    //change from light to dark or the other way
    DynamicTheme.of(context).setBrightness(
        Theme.of(context).brightness == Brightness.dark
            ? Brightness.light
            : Brightness.dark);
  }

  void changeColor() {
    //in testing
    DynamicTheme.of(context).setThemeData(ThemeData(
      primaryColor: Theme.of(context).primaryColor == Colors.indigo
          ? Colors.red
          : Colors.indigo,
    ));
  }
  //END OF DYNAMIC THEME FUNCS
}

class SecondRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Route"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}