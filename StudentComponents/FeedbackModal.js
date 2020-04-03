import React, { useState } from "react";
import {
  View,
  TextInput,
  Button,
  StyleSheet,
  Modal,
  Text,
  TouchableOpacity
  //ShadowPropTypesIOS
} from "react-native";

import Colors from "../constants/colors";

const FeedbackModal = props => {
  var date = new Date().getDate();
  var month = new Date().getMonth() + 1;
  const [subject, setSubject] = useState("");
  const [feedback, setFeedback] = useState("");

  function subjectHandler(enteredText) {
    setSubject(enteredText);
  }
  function feedbackHanlder(enteredText) {
    setFeedback(enteredText);
  }
  function submitHandler() {
    if (subject == "" || feedback == "") {
      alert("All fields are required to submit");
    } else {
      props.onSubmit;
    }
  }

  return (
    <Modal visible={props.visible} animationType="slide">
      <View style={styles.sessionNameAndDate}>
        <Text
          style={{
            fontSize: 25,
            alignContent: "center",
            fontFamily: "Avenir"
          }}
        >
          {props.selectedClassName}
          {"\n"}Session Feedback
        </Text>
        <Text style={{ fontSize: 18, fontFamily: "Avenir" }}>
          {month}/{date}
        </Text>
      </View>

      <View style={styles.subjectView}>
        <Text style={styles.header}>Subject: </Text>
        <TextInput
          style={styles.input}
          placeholder="Feedback Subject"
          onChangeText={subjectHandler}
          color={Colors.purple}
        />
      </View>

      <View style={styles.feedbackView}>
        <Text style={styles.header}>Feedback:</Text>
        <TextInput
          style={styles.input}
          placeholder="Feedback Comments"
          multiline={true}
          onChangeText={feedbackHanlder}
          color={Colors.purple}
        />
      </View>

      <TouchableOpacity
        activeOpacity={0.5}
        onPress={() => {
          if (subject == "" || feedback == "") {
            alert("All fields are required to submit");
          } else {
            props.onSubmit();
          }
        }}
        style={{
          width: "100%",
          justifyContent: "center",
          alignItems: "center",
          alignContent: "center",
          position: "absolute",
          bottom: 100
        }}
      >
        <View
          style={{
            backgroundColor: Colors.green,
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
            Submit
          </Text>
        </View>
      </TouchableOpacity>
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
    marginTop: 100,
    justifyContent: "center"
  },
  promptText: {
    fontFamily: "Avenir",
    fontSize: 30,
    textAlign: "center"
  },
  promptTextContainer: {
    alignContent: "center",
    marginBottom: 50
  },
  sessionNameAndDate: {
    alignContent: "center",
    justifyContent: "space-between",
    width: "90%",
    flexDirection: "row",
    marginTop: 70,
    marginLeft: 20
  },
  header: {
    fontSize: 20,
    fontFamily: "Avenir"
  },
  input: {
    fontFamily: "Avenir",
    fontSize: 18
  },
  subjectView: {
    flexDirection: "row",
    marginTop: 90,
    marginBottom: 40,
    marginLeft: 40
  },
  feedbackView: {
    marginTop: 30,
    marginBottom: 40,
    marginLeft: 40
  }
});

export default FeedbackModal;
