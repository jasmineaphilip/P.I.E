import React, { useState } from "react";
import {
  StyleSheet,
  View,
  FlatList,
  Button,
  Text,
  Image,
  ScrollView,
  TouchableOpacity
} from "react-native";

//import Header from "../InstructorComponents/Header";
import Class from "../InstructorComponents/Class";
import StudyGroupInput from "../StudentComponents/StudyGroupInput";
import Colors from "../constants/colors";
import Footer from "../InstructorComponents/LogoFooter";

export default function StudyGroups({ navigation }) {
  const [studyGroupItems, setStudyGroupItems] = useState([]);
  const [isAddMode, setIsAddMode] = useState(false);

  function addStudyGroupHandler(studyGroupName, studyGroupID) {
    setStudyGroupItems(currentStudyGroups => [
      ...currentStudyGroups,
      {
        id: Math.random().toString(),
        value: studyGroupName,
        idValue: studyGroupID
      }
    ]);
    setIsAddMode(false);
  }

  const cancelStudyGroupAdditionHandler = () => {
    setIsAddMode(false);
  };

  return (
    <View style={styles.screen}>
      {/* <Header
        title="Welcome (Instructor's Name)!"
        onPress={() => setIsAddMode(true)}
      /> */}
      <ScrollView>
        <View style={styles.classListView}>
          <Text style={styles.classListTitle}> My Study Groups </Text>
        </View>
        <StudyGroupInput
          visible={isAddMode}
          onAddStudyGroup={addStudyGroupHandler}
          onCancel={cancelStudyGroupAdditionHandler}
        />
        <FlatList
          keyExtractor={(item, index) => item.id}
          data={studyGroupItems}
          renderItem={itemData => (
            <TouchableOpacity
              activeOpacity={0.5}
              //onPress={props.OpenClass.bind(this, props.id)}
              onPress={() =>
                navigation.navigate("StudyGroupSession", {
                  selectedClassName: itemData.item.value,
                  selectedClassID: itemData.item.idValue
                })
              }
            >
              <View style={styles.listItem}>
                <Text>{itemData.item.value}</Text>
              </View>
            </TouchableOpacity>
          )}
        />

        <TouchableOpacity
          activeOpacity={0.5}
          onPress={() => setIsAddMode(true)}
          style={{
            width: "100%",
            justifyContent: "center",
            alignItems: "center",
            alignContent: "center"
            //marginTop: 100
          }}
        >
          <View
            style={{
              backgroundColor: "#58BA9F",
              padding: 14,
              marginTop: 40,
              width: "50%"
            }}
          >
            <Text
              style={{
                textAlign: "center",
                color: "#fff",
                fontSize: 20,
                fontFamily: "Avenir"
              }}
            >
              Create Study Group
            </Text>
          </View>
        </TouchableOpacity>
      </ScrollView>
      <Footer />
    </View>
  );
}

const styles = StyleSheet.create({
  screen: {
    flex: 1
  },
  classListView: {
    padding: 50,
    alignItems: "center"
  },
  classListTitle: {
    fontSize: 30,
    color: Colors.purple,
    fontFamily: "Avenir",
    fontWeight: "100"
  },
  listItem: {
    padding: 10,
    margin: 10,
    backgroundColor: "#ccc",
    borderColor: Colors.purple,
    borderWidth: 1,
    marginHorizontal: 50
  }
});
