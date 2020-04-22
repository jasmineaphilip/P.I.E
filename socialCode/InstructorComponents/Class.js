import React from "react";
import { View, Text, StyleSheet, TouchableOpacity } from "react-native";

import Colors from "../constants/colors";

const Class = props => {
  return (
    <TouchableOpacity
      activeOpacity={0.5}
      //onPress={props.OpenClass.bind(this, props.id)}
      onPress={() => navigation.navigate("ClassView")}
    >
      <View style={styles.listItem}>
        <Text>{props.title}</Text>
      </View>
    </TouchableOpacity>
  );
};

const styles = StyleSheet.create({
  listItem: {
    padding: 10,
    margin: 10,
    backgroundColor: "#ccc",
    borderColor: Colors.purple,
    borderWidth: 1,
    marginHorizontal: 50
  }
});
export default Class;
