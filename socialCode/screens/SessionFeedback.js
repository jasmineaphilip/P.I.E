import * as React from "react";
import { useState } from "react";
import {
  Text,
  View,
  StyleSheet,
  TextInput,
  Image,
  Button,
  TouchableOpacity
} from "react-native";
import logo from "./logo.png";
import Colors from "../constants/colors";
import { FlatList } from "react-native-gesture-handler";
import Footer from "../InstructorComponents/LogoFooter";
import WordCloud from "./wordcloud.jpeg";

export default function SessionFeedback({ navigation, route }) {
  return (
    <View style={styles.container}>
      {/* <View style={styles.sortBy}>
        <Text style={styles.sortByText}>Sort By: </Text>
        <Button style={styles.sortByButtons} title="Most Recent" />
        <Button style={styles.sortByButtons} title="Oldest" />
      </View> */}

      <View style={styles.feedbackAndDate}>
        <Text style={styles.feedbackAndDateText}>Feedback</Text>
        <Text style={styles.feedbackAndDateText}> Session Date</Text>
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
      <Image source={WordCloud} width="50" length="50"></Image>

      <View
        style={{
          width: "90%",
          flexDirection: "row",
          justifyContent: "space-between",
          alignContent: "center",
          marginBottom: 90
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
          title="Past Sessions"
          fontFamily="Avenir"
          color={Colors.darkPurple}
          onPress={() => navigation.navigate("Feedback")}
        />
        <Button
          title="All Feedback"
          fontFamily="Avenir"
          color={Colors.dark}
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
  feedbackAndDate: {
    alignContent: "center",
    justifyContent: "space-between",
    width: "85%",
    flexDirection: "row",
    marginTop: 30
  },
  feedbackAndDateText: {
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
