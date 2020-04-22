import React, { useState } from "react";
import {
  View,
  TextInput,
  Button,
  StyleSheet,
  Modal,
  Text
  //ShadowPropTypesIOS
} from "react-native";

import Colors from "../constants/colors";

const openCameraModal = props => {
  return (
    <Modal visible={props.visible} animationType="slide">
      <View style={styles.inputContainer}>
        <View style={styles.promptTextContainer}>
          <Text style={styles.promptText}>
            Take a selfie, so we know you're you :)
          </Text>
        </View>

        <View style={styles.buttonContainer}>
          <View style={styles.button}>
            <Button title="CANCEL" color="red" onPress={props.onCancel} />
          </View>
          <View style={styles.button}>
            <Button title="OPEN CAMERA" />
          </View>
        </View>
      </View>
    </Modal>
  );
};

const styles = StyleSheet.create({
  inputContainer: {
    //flexDirection: "column",
    justifyContent: "center",
    alignItems: "center",
    flex: 1, //makes sure the item takes up the full space of the parent (modal in this case)
    marginBottom: 10
  },
  input: {
    width: 200,
    borderColor: Colors.purple,
    borderWidth: 1,
    padding: 10
  },
  buttonContainer: {
    width: "60%",
    flexDirection: "row",
    justifyContent: "space-between"
  },
  promptText: {
    fontFamily: "Avenir",
    fontSize: 30,
    textAlign: "center"
  },
  promptTextContainer: {
    alignContent: "center",
    marginBottom: 50
  }
});

export default openCameraModal;
