import React from "react";
import {
  Text,
  View,
  Image,
  Button,
  FlatList,
  StyleSheet,
  ImageBackground,
  TextInput,
  TouchableOpacity
} from "react-native";

import logo from "./logo.png";
import Footer from "../InstructorComponents/LogoFooter";

export default function StudentSession({ route, navigation }) {
  //state = {};
  const { selectedClassName } = route.params;
  var date = new Date().getDate();
  var month = new Date().getMonth() + 1;

  return (
    // <ImageBackground source={require('./img/pic2.jpg')} style={{flex:1 , justifyContent:'center' }}>

    <View style={styles.container}>
      <View style={styles.sessionNameAndDate}>
        <Text
          style={{
            fontSize: 25,
            margin: 10,
            alignContent: "center",
            fontFamily: "Avenir"
          }}
        >
          {selectedClassName} Live Session
        </Text>
        <Text style={{ fontSize: 18, margin: 17, fontFamily: "Avenir" }}>
          {month}/{date}
        </Text>
      </View>

      <View
        style={{
          flexDirection: "row",
          alignItems: "center",
          justifyContent: "center",
          marginBottom: 20
        }}
      >
        <Text style={{ fontSize: 20, fontFamily: "Avenir" }}>
          Total Joined:{" "}
        </Text>
        <TextInput
          //onChangeText={netid => this.setState({ netid })}
          placeholder="#"
          style={{
            backgroundColor: "#efefef",
            // padding: 10,
            // width: 30,
            // marginTop: 10,
            // flex: 0.9,
            fontSize: 18
          }}
        />
      </View>

      <FlatList
        style={{
          borderWidth: 1,
          borderColor: "black",
          width: "90%",
          paddingTop: 10,
          marginBottom: 75
        }}
        renderItem={itemData => (
          <View style={styles.listItem}>
            <Text>{itemData.item.value}</Text>
          </View>
        )}
      />

      <View
        style={{
          width: "100%",
          flexDirection: "row",
          justifyContent: "space-between",
          alignContent: "center",
          padding: 10,
          bottom: -130
        }}
      ></View>
      <Footer />
    </View>

    // </ImageBackground>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: "center"
  },
  sessionNameAndDate: {
    alignContent: "center",
    justifyContent: "space-between",
    width: "100%",
    flexDirection: "row",
    paddingTop: 10
  },
  listItem: {
    padding: 10,
    marginVertical: 10,
    backgroundColor: "#ccc",
    borderColor: "black",
    borderWidth: 1
  }
});
