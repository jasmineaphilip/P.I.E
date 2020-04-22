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

const StudyGroupInput = props => {
  const [enteredStudyGroupName, setEnteredStudyGroupName] = useState("");
  const [enteredID, setEnteredID] = useState("");

  const studyGroupInputHanlder = enteredText => {
    setEnteredStudyGroupName(enteredText);
  };

  const studyGroupIDInputHandler = enteredText => {
    setEnteredID(enteredText);
  };

  const addStudyGroupHandler = () => {
    props.onAddStudyGroup(enteredStudyGroupName, enteredID);
    setEnteredStudyGroupName("");
    setEnteredID("");
  };

  function cancelAddHandler() {
    setEnteredID("");
    setEnteredStudyGroupName("");
    props.onCancel();
  }

  return (
    <Modal visible={props.visible} animationType="slide">
      <View style={styles.inputContainer}>
        <TextInput
          placeholder="Study Group Name"
          style={styles.input}
          onChangeText={studyGroupInputHanlder}
          value={enteredStudyGroupName}
        />
        <TextInput
          placeholder="Class ID"
          style={styles.input}
          onChangeText={studyGroupIDInputHandler}
          value={enteredID}
        />
        <TextInput
          placeholder="Study Group ID"
          style={styles.input}
          //   onChangeText={studyGroupIDInputHandler}
          //   value={enteredID}
        />
        <TextInput
          placeholder="Location"
          style={styles.input}
          //   onChangeText={studyGroupIDInputHandler}
          //   value={enteredID}
        />
        <TextInput
          placeholder="Duration"
          style={styles.input}
          //   onChangeText={studyGroupIDInputHandler}
          //   value={enteredID}
        />
        <View style={styles.buttonContainer}>
          <View style={styles.button}>
            <Button title="CANCEL" color="red" onPress={cancelAddHandler} />
          </View>
          <View style={styles.button}>
            <Button title="CREATE" onPress={addStudyGroupHandler} />
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

export default StudyGroupInput;
