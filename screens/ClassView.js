import React, { useState } from "react";
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
import Colors from "../constants/colors";

export default function ClassView({ route, navigation }) {
  const [times, setTimes] = useState("");
  const [location, setLocation] = useState("");
  const [professor, setProfessor] = useState("");
  const [tas, setTas] = useState("");
  const { selectedClassName } = route.params;
  const { selectedClassID } = route.params;
  //   state = {
  //     times: "",
  //     location: "",
  //     professor: "",
  //     tas: ""
  //   };

  function pressUpdateHandler() {
    // const { times, location, professor, tas } = this.state;
    // if ((times == "" || location == "", professor == "" || tas == "")) {
    //   alert("all fields are required");
    // } else {
    //   alert("Class Info Updated");
    // }
    if ((times == "" || location == "", professor == "" || tas == "")) {
      alert("All fields are required");
    } else {
      alert("Class Info Updated");
    }
  }

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

  return (
    // <ImageBackground source={require('./img/pic2.jpg')} style={{flex:1 , justifyContent:'center' }}>

    <View style={styles.container}>
      <View style={styles.imageContainer}>
        {/* <Text style={{ fontSize: 30, margin: 10 }}>Class Name </Text> */}
      </View>

      <Text
        style={{
          marginTop: -100,
          marginBottom: 10,
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

      <View style={{ flexDirection: "row", alignItems: "center" }}>
        <Text style={styles.infoHeaders}>Times: </Text>
        <TextInput
          onChangeText={timesInputHandler}
          placeholder="Insert Times"
          style={{
            backgroundColor: "#efefef",
            padding: 10,
            width: "70%",
            marginTop: 10,
            flex: 0.9,
            fontSize: 18,
            fontFamily: "Avenir"
          }}
          value={times}
        />
      </View>

      <View style={{ flexDirection: "row", alignItems: "center" }}>
        <Text style={styles.infoHeaders}>Location: </Text>
        <TextInput
          onChangeText={locationInputHandler}
          placeholder="Insert Location"
          style={{
            backgroundColor: "#efefef",
            padding: 10,
            width: "70%",
            marginTop: 10,
            flex: 0.9,
            fontSize: 18,
            fontFamily: "Avenir"
          }}
          value={location}
        />
      </View>

      <View style={{ flexDirection: "row", alignItems: "center" }}>
        <Text style={styles.infoHeaders}>Professor: </Text>
        <TextInput
          onChangeText={professorInputHandler}
          placeholder="Insert Professor"
          style={{
            backgroundColor: "#efefef",
            padding: 10,
            width: "70%",
            marginTop: 10,
            flex: 0.9,
            fontSize: 18,
            fontFamily: "Avenir"
          }}
          value={professor}
        />
      </View>

      <View style={{ flexDirection: "row", alignItems: "center" }}>
        <Text style={styles.infoHeaders}>TAs: </Text>
        <TextInput
          onChangeText={tasInputHandler}
          placeholder="Insert TAs"
          style={{
            backgroundColor: "#efefef",
            padding: 10,
            width: "70%",
            marginTop: 10,
            flex: 0.9,
            fontSize: 18,
            fontFamily: "Avenir"
          }}
          value={tas}
        />
      </View>

      <TouchableOpacity activeOpacity={0.5} style={{ width: "100%" }}>
        <View
          style={{
            backgroundColor: "#58BA9F",
            padding: 14,
            marginTop: 40,
            width: "50%",
            marginLeft: "5%",
            alignSelf: "center"
          }}
        >
          <Text
            style={{
              textAlign: "center",
              color: "#fff",
              fontSize: 18,
              fontFamily: "Avenir"
            }}
            onPress={pressUpdateHandler}
          >
            Update
          </Text>
        </View>
      </TouchableOpacity>

      <View
        style={{
          width: "90%",
          flexDirection: "row",
          justifyContent: "space-between",
          alignContent: "center",
          padding: 10,
          bottom: -225
        }}
      >
        <Button
          title="Home"
          fontFamily="Avenir"
          color={Colors.darkPurple}
          onPress={() => navigation.navigate("InstructorHomeScreen")}
        />
        <Button
          title="Start Session"
          fontFamily="Avenir"
          color={Colors.dark}
          onPress={() =>
            navigation.navigate("StartSession", {
              selectedClassName: selectedClassName
            })
          }
        />
        <Button
          title="Past Sessions"
          fontFamily="Avenir"
          color={Colors.darkPurple}
          onPress={() => navigation.navigate("Feedback")}
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
    flexDirection: "row",
    paddingTop: 10
  },
  logo: {
    alignSelf: "baseline",
    left: 0,
    width: 50,
    height: 50
  },
  infoHeaders: {
    fontSize: 20,
    fontFamily: "Avenir",
    color: Colors.purple,
    fontWeight: "bold"
  }
});

//export default ClassView;
