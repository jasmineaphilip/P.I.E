import React, { Component } from "react";
import {
  Alert,
  Image,
  Button,
  TextInput,
  View,
  StyleSheet,
  TouchableOpacity,
  Text,
  ImageBackground
} from "react-native";
import { useState, useEffect } from "react";
import { NavigationContainer } from "@react-navigation/native";
import { createStackNavigator } from "@react-navigation/stack";

import InstructorHomeScreen from "./InstructorHome";
import * as Google from "expo-google-app-auth";
import Colors from "../constants/colors";
//import logo from "logo.png";

export default function Login({ navigation }) {
  const [username, setUsername] = useState("");
  const [password, setPassword] = useState("");
  const [displayName, setDisplayName] = useState("");
  const [signedIn, setSignedIn] = useState(false);
  const [name, setName] = useState("");
  const [photoUrl, setPhotoUrl] = useState("");

  signIn = async () => {
    try {
      const result = await Google.logInAsync({
        androidClientId:
          "79637198601-r74nk73e9qn5d99iv7jtbhp38fj8vk8q.apps.googleusercontent.com",
        iosClientId:
          "79637198601-7p4hjaj21le53t4t61cd073ppprmuung.apps.googleusercontent.com",

        scopes: ["profile", "email"]
      });

      if (result.type === "success") {
        setSignedIn(true);
        setName(result.user.name);
        setPhotoUrl(result.user.photoUrl);
      } else {
        console.log("cancelled");
      }
    } catch (e) {
      console.log("error", e);
    }
  };

  function usernameInputHandler(enteredText) {
    setUsername(enteredText);
  }

  function passwordInputHandler(enteredText) {
    setPassword(enteredText);
  }

  function displayNameInputHandler(enteredText) {
    setDisplayName(enteredText);
  }

  const LoginPage = props => {
    return (
      <View>
        {/* <Text style={styles.googleAuthThings}>Sign In With Google</Text> */}
        <TouchableOpacity activeOpacity={0.5} onPress={() => props.signIn()}>
          <View
            style={{
              backgroundColor: Colors.purple,
              padding: 14,
              marginTop: 5,
              marginLeft: "5%",
              alignSelf: "center"
            }}
          >
            <Text style={{ textAlign: "center", color: "#fff", fontSize: 18 }}>
              Sign In
            </Text>
          </View>
        </TouchableOpacity>
      </View>
    );
  };

  const LoggedInPage = props => {
    return (
      <View style={styles.container}>
        <Text style={styles.welcomeUser}>Welcome {props.name}!</Text>
        <Image style={styles.image} source={{ uri: props.photoUrl }} />
      </View>
    );
  };

  return (
    <ImageBackground
      source={require("./background.png")}
      style={styles.container}
    >
      <Text style={styles.welcomeText}>Welcome To</Text>
      <Text style={styles.pieText}>P.I.E</Text>
      <Image
        source={require("./logo.png")}
        style={{ width: 100, height: 100 }}
        style={styles.logo}
      />
      {signedIn ? (
        <>
          <LoggedInPage name={name} photoUrl={photoUrl} />
          <View style={styles.buttonView}>
            <TouchableOpacity
              activeOpacity={0.5}
              onPress={() =>
                navigation.navigate("InstructorHomeScreen", {
                  instructorName: name
                })
              }
            >
              <View
                style={{
                  backgroundColor: "#58BA9F",
                  padding: 14,
                  marginTop: 40,
                  marginLeft: "5%",
                  alignSelf: "center",
                  borderColor: "#49009A"
                }}
              >
                <Text
                  style={{ textAlign: "center", color: "#fff", fontSize: 18 }}
                >
                  Instructor
                </Text>
              </View>
            </TouchableOpacity>

            <TouchableOpacity
              activeOpacity={0.5}
              onPress={() =>
                navigation.navigate("StudentHomeScreen", {
                  studentName: name
                })
              }
            >
              <View
                style={{
                  backgroundColor: "#58BA9F",
                  padding: 14,
                  marginTop: 40,
                  marginLeft: "5%",
                  alignSelf: "center"
                }}
              >
                <Text
                  style={{ textAlign: "center", color: "#fff", fontSize: 18 }}
                >
                  Student
                </Text>
              </View>
            </TouchableOpacity>
          </View>
        </>
      ) : (
        <LoginPage signIn={signIn} />
      )}
    </ImageBackground>
  );
}
//}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: "center",
    justifyContent: "center"
    //backgroundColor: "#ecf0f1",
  },
  logo: {
    width: 175,
    height: 175,
    // marginTop: 10,
    // marginBottom: 10
    position: "absolute",
    top: 150
  },
  welcomeText: {
    textAlign: "center",
    color: "#fff",
    fontSize: 50,
    fontWeight: "200",
    fontFamily: "Avenir",
    // marginBottom: 0,
    // marginTop: -300,
    justifyContent: "center",
    position: "absolute",
    top: 10
  },
  pieText: {
    textAlign: "center",
    color: "#fff",
    fontSize: 60,
    fontWeight: "200",
    justifyContent: "center",
    position: "absolute",
    top: 60,
    fontFamily: "Avenir"
  },
  textInput: {
    marginTop: 30
  },
  input: {
    width: 200,
    height: 44,
    padding: 10,
    borderWidth: 2,
    borderColor: "#49009A",
    marginBottom: 10
  },
  buttonView: {
    justifyContent: "space-between",
    flexDirection: "row",
    alignContent: "center",
    alignItems: "center",
    position: "absolute",
    bottom: 50
  },
  backgroundImage: {
    flex: 1,
    resizeMode: "cover" // or 'stretch'
  },
  googleAuthThings: {
    fontSize: 25,
    fontFamily: "Avenir"
  },
  image: {
    marginTop: 15,
    width: 100,
    height: 100,
    borderColor: "rgba(0,0,0,0.2)",
    borderWidth: 3,
    borderRadius: 150
  },
  welcomeUser: {
    fontSize: 20,
    fontFamily: "Avenir"
  }
});
