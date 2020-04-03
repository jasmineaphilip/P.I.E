import * as React from "react";
import { useState } from "react";
import { Text, View, StyleSheet, TextInput, Image, Button } from "react-native";
import logo from "./logo.png";
import Colors from "../constants/colors";
import { FlatList } from "react-native-gesture-handler";
import Footer from "../InstructorComponents/LogoFooter";

export default function Feedback({ navigation, route }) {
  return (
    <View style={styles.container}>
      <View style={styles.sortBy}>
        <Text style={styles.sortByText}>Sort By: </Text>
        <Button style={styles.sortByButtons} title="Most Recent" />
        <Button style={styles.sortByButtons} title="Oldest" />
      </View>

      <View style={styles.sessionDateAndJoined}>
        <Text style={styles.dateAndJoinedText}>Session Date</Text>
        <Text style={styles.dateAndJoinedText}># Joined</Text>
      </View>

      <FlatList
        style={{
          borderWidth: 1,
          borderColor: "black",
          width: "90%",
          paddingTop: 10,
          marginBottom: 20
        }}
        renderItem={itemData => (
          <View style={styles.listItem}>
            <Text>{itemData.item.value}</Text>
          </View>
        )}
      />
      <View
        style={{
          width: "75%",
          flexDirection: "row",
          justifyContent: "space-between",
          alignContent: "center",
          marginBottom: 100
        }}
      >
        <Button
          title="Home"
          fontFamily="Avenir"
          color={Colors.darkPurple}
          onPress={() => navigation.navigate("InstructorHomeScreen")}
        />
        <Button
          title="Class"
          fontFamily="Avenir"
          color={Colors.dark}
          onPress={() => navigation.navigate("ClassView")}
        />
        <Button
          title="View All Feedback"
          fontFamily="Avenir"
          color={Colors.darkPurple}
          onPress={() => navigation.navigate("AllFeedback")}
        />
      </View>

      <Footer />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: "center"
  },
  sortBy: {
    flexDirection: "row",
    marginLeft: 20,
    marginRight: 20,
    marginTop: 30,
    marginBottom: 20
  },
  sortByText: {
    fontSize: 27,
    fontFamily: "Avenir",
    color: Colors.darkPurple
  },
  sortByButtons: {
    fontFamily: "Avenir",
    color: Colors.lightPurple
  },
  sessionDateAndJoined: {
    alignContent: "center",
    justifyContent: "space-between",
    width: "85%",
    flexDirection: "row"
  },
  dateAndJoinedText: {
    fontFamily: "Avenir",
    color: Colors.lightPurple,
    fontSize: 25
  },
  listItem: {
    padding: 10,
    marginVertical: 10,
    backgroundColor: "#ccc",
    borderColor: "black",
    borderWidth: 1
  }
});
