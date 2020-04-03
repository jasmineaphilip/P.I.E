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
import ClassInputStudent from "../StudentComponents/ClassInputStudent";
import Colors from "../constants/colors";
import Footer from "../InstructorComponents/LogoFooter";

export default function InstructorHome({ navigation }) {
  const [classListItems, setClassListItems] = useState([]);
  const [isAddMode, setIsAddMode] = useState(false);

  function addClassHandler(className, classID) {
    setClassListItems(currentClasses => [
      ...currentClasses,
      { id: Math.random().toString(), value: className, idValue: classID }
    ]);
    setIsAddMode(false);
  }

  const cancelClassAdditionHandler = () => {
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
          <Text style={styles.classListTitle}> My Classes </Text>
        </View>
        <ClassInputStudent
          visible={isAddMode}
          onAddClass={addClassHandler}
          onCancel={cancelClassAdditionHandler}
        />
        <FlatList
          keyExtractor={(item, index) => item.id}
          data={classListItems}
          renderItem={
            itemData => (
              <TouchableOpacity
                activeOpacity={0.5}
                //onPress={props.OpenClass.bind(this, props.id)}
                onPress={() =>
                  navigation.navigate("ClassViewStudent", {
                    selectedClassName: itemData.item.value,
                    selectedClassID: itemData.item.idValue
                  })
                }
              >
                <View style={styles.listItem}>
                  <Text>{itemData.item.value}</Text>
                </View>
              </TouchableOpacity>
            )
            // <TouchableWithoutFeedback>
            //   {/*<Class id={itemData.item.id} title={itemData.item.value} />*/}

            // </TouchableWithoutFeedback>
          }
          // onPress={() => navigation.navigate("ClassView")}
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
              Join Class
            </Text>
          </View>
        </TouchableOpacity>
        <TouchableOpacity
          activeOpacity={0.5}
          onPress={() => navigation.navigate("StudyGroups")}
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
              backgroundColor: Colors.lightPurple,
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
              Study Groups
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
