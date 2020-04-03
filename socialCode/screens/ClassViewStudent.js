import React, { useState, useReducer } from "react";
import {
  Text,
  View,
  Image,
  Button,
  StyleSheet,
  ImageBackground,
  TextInput,
  TouchableOpacity
} from "react-native";

import Footer from "../InstructorComponents/LogoFooter";
import { Popup } from "popup-ui";
import OpenCameraModal from "../StudentComponents/OpenCameraModal";
import Colors from "../constants/colors";
import FeedbackModal from "../StudentComponents/FeedbackModal";

export default function ClassViewStudent({ route, navigation }) {
  const [times, setTimes] = useState("");
  const [location, setLocation] = useState("");
  const [professor, setProfessor] = useState("");
  const [tas, setTas] = useState("");
  const { selectedClassName } = route.params;
  const { selectedClassID } = route.params;
  const [isJoinMode, setIsJoinMode] = useState(false);
  const [isFeedbackMode, setIsFeedBackMode] = useState(false);

  function timesInputHandler(enteredText) {
    setTimes(enteredText);
  }
  function locationInputHandler(enteredText) {
    setLocation(enteredText);
  }
  function professorInputHandler(enteredText) {
    setProfessor(enteredText);
  }
  function tasInputHandler(enteredText) {
    setTas(enteredText);
  }

  function cancelClassJoin() {
    setIsJoinMode(false);
  }
  function onSubmit() {
    setIsFeedBackMode(false);
  }

  return (
    // <ImageBackground source={require('./img/pic2.jpg')} style={{flex:1 , justifyContent:'center' }}>

    <View style={styles.container}>
      <View style={styles.imageContainer}></View>

      <Text
        style={{
          marginTop: -100,
          marginBottom: 40,
          fontSize: 40,
          color: Colors.purple,
          fontFamily: "Avenir",
          fontWeight: "100"
        }}
      >
        Class Info{" "}
      </Text>
      <View
        style={{ flexDirection: "row", alignItems: "center", marginBottom: 30 }}
      >
        <Text style={styles.infoHeaders}>Class ID: </Text>
        <Text> {selectedClassID} </Text>
      </View>

      <View
        style={{
          flexDirection: "row",
          alignItems: "center"
          //alignContent: "center"
        }}
      >
        <Text style={styles.infoHeaders}>Times:</Text>
        <Text
          style={{
            padding: 10,
            width: "70%",
            // marginTop: 10,
            // flex: 0.9,
            fontSize: 18,
            fontFamily: "Avenir"
          }}
        >
          Tues, Thurs 10:20am-11:40am
        </Text>
      </View>

      <View
        style={{
          flexDirection: "row",
          alignItems: "center"
          //alignContent: "center"
        }}
      >
        <Text style={styles.infoHeaders}>Location:</Text>
        <Text
          style={{
            padding: 10,
            width: "70%",
            // marginTop: 10,
            // flex: 0.9,
            fontSize: 18,
            fontFamily: "Avenir"
          }}
        >
          RWH-102
        </Text>
      </View>

      <View
        style={{
          flexDirection: "row",
          alignItems: "center"
          //alignContent: "center"
        }}
      >
        <Text style={styles.infoHeaders}>Professor:</Text>
        <Text
          style={{
            padding: 10,
            width: "70%",
            // marginTop: 10,
            // flex: 0.9,
            fontSize: 18,
            fontFamily: "Avenir"
          }}
        >
          Ivan Marsic
        </Text>
      </View>

      <View
        style={{
          flexDirection: "row",
          alignItems: "center"
          //alignContent: "center"
        }}
      >
        <Text style={styles.infoHeaders}>TAs:</Text>
        <Text
          style={{
            padding: 10,
            width: "70%",
            // marginTop: 10,
            // flex: 0.9,
            fontSize: 18,
            fontFamily: "Avenir"
          }}
        >
          Kartik
        </Text>
      </View>

      <TouchableOpacity
        activeOpacity={0.5}
        onPress={() => setIsJoinMode(true)}
        style={{
          width: "100%",
          justifyContent: "center",
          alignItems: "center",
          alignContent: "center",
          marginTop: 10
        }}
      >
        <View
          style={{
            backgroundColor: "#58BA9F",
            padding: 14,
            marginTop: 40,
            width: "50%"
          }}
        >
          <Text
            style={{
              textAlign: "center",
              color: "#fff",
              fontSize: 18,
              fontFamily: "Avenir"
            }}
          >
            Join Session
          </Text>
        </View>
      </TouchableOpacity>
      <OpenCameraModal
        visible={isJoinMode}
        //onTakePhoto=nothing yet
        onCancel={cancelClassJoin}
      />

      <TouchableOpacity
        activeOpacity={0.5}
        onPress={() => setIsFeedBackMode(true)}
        style={{
          width: "100%",
          justifyContent: "center",
          alignItems: "center",
          alignContent: "center",
          marginTop: 5
        }}
      >
        <View
          style={{
            backgroundColor: Colors.lightPurple,
            padding: 14,
            marginTop: 40,
            width: "50%"
          }}
        >
          <Text
            style={{
              textAlign: "center",
              color: "#fff",
              fontSize: 18,
              fontFamily: "Avenir"
            }}
          >
            Preview Student Feedback Form
          </Text>
        </View>
      </TouchableOpacity>
      <FeedbackModal
        visible={isFeedbackMode}
        selectedClassName={selectedClassName}
        onSubmit={onSubmit}
      />

      <View style={styles.home}>
        <Button
          title="Home"
          fontFamily="Avenir"
          color={Colors.darkPurple}
          onPress={() => navigation.navigate("StudentHomeScreen")}
        />
      </View>

      <Footer />
    </View>

    // </ImageBackground>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: "center"
    //borderColor: "black",
    //borderWidth: 10
  },
  imageContainer: {
    alignContent: "center",
    justifyContent: "space-between",
    width: "100%",
    height: "15%",
    flexDirection: "row"
    //paddingTop: 10
  },
  logo: {
    alignSelf: "baseline",
    left: 0,
    width: 50,
    height: 50
  },
  home: {
    justifyContent: "center",
    alignContent: "center",
    alignItems: "center",
    position: "absolute",
    bottom: 100
  },
  infoHeaders: {
    fontSize: 20,
    fontFamily: "Avenir",
    color: Colors.purple,
    fontWeight: "bold"
  }
});

//export default ClassView;
