import React, { useState } from "react";
import {
  View,
  TextInput,
  Button,
  StyleSheet,
  Modal
  //ShadowPropTypesIOS
} from "react-native";

import Colors from "../constants/colors";

const ClassInputStudent = props => {
  const [enteredClassName, setEnteredClassName] = useState("");
  const [enteredID, setEnteredID] = useState("");

  const classNameInputHanlder = enteredText => {
    setEnteredClassName(enteredText);
  };

  const classIDInputHandler = enteredText => {
    setEnteredID(enteredText);
  };

  const addClassHandler = () => {
    props.onAddClass(enteredClassName, enteredID);
    setEnteredClassName("");
    setEnteredID("");
  };

  function cancelAddHandler() {
    setEnteredID("");
    setEnteredClassName("");
    props.onCancel();
  }

  return (
    <Modal visible={props.visible} animationType="slide">
      <View style={styles.inputContainer}>
        <TextInput
          placeholder="Class Name"
          style={styles.input}
          onChangeText={classNameInputHanlder}
          value={enteredClassName}
        />
        <TextInput
          placeholder="Class ID"
          style={styles.input}
          onChangeText={classIDInputHandler}
          value={enteredID}
        />
        <View style={styles.buttonContainer}>
          <View style={styles.button}>
            <Button title="CANCEL" color="red" onPress={cancelAddHandler} />
          </View>
          <View style={styles.button}>
            <Button title="JOIN" onPress={addClassHandler} />
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
    padding: 10,
    marginBottom: 10
  },
  buttonContainer: {
    width: "40%",
    flexDirection: "row",
    justifyContent: "space-between"
  },
  button: {
    width: "60%"
  }
});

export default ClassInputStudent;
