import * as React from "react";
import { useState, useEffect, Component } from "react";
import { View, Text, Button, TextInput } from "react-native";
import { NavigationContainer } from "@react-navigation/native";
import { createStackNavigator } from "@react-navigation/stack";
import { createBottomTabNavigator } from "@react-navigation/bottom-tabs";
import { createMaterialBottomTabNavigator } from "@react-navigation/material-bottom-tabs";
import { MaterialCommunityIcons } from "react-native-vector-icons";

import Colors from "./constants/colors";
import LoginScreen from "./screens/Login";
import InstructorHomeScreen from "./screens/InstructorHome";
import ClassView from "./screens/ClassView";
import StartSession from "./screens/StartSession";
import Feedback from "./screens/Feedback";
import StudentHomeScreen from "./screens/StudentHome";
import ClassViewStudent from "./screens/ClassViewStudent";
import StartSessionStudent from "./screens/StartSessionStudent";
import AllFeedback from "./screens/AllFeedback";
import SessionFeedback from "./screens/SessionFeedback";
import StudyGroups from "./screens/StudyGroups";

console.disableYellowBox = true;

//import Session from "./screens/StartSession";

// function HomeScreen() {
//   return (
//     <View style={{ flex: 1, alignItems: 'center', justifyContent: 'center' }}>
//       <Text>Home Screen</Text>
//     </View>
//   );
// }

const Stack = createStackNavigator();
//const MaterialBottonTabs = createMaterialBottomTabNavigator();

export default function App() {
  return (
    <NavigationContainer>
      <Stack.Navigator>
        <Stack.Screen
          name="LoginScreen"
          component={LoginScreen}
          options={{
            title: "Login",
            headerStyle: {
              backgroundColor: Colors.green
            },
            headerTintColor: "#fff",
            headerTitleStyle: {
              fontWeight: "bold",
              fontFamily: "Avenir"
            }
          }}
        />
        <Stack.Screen
          name="InstructorHomeScreen"
          component={InstructorHomeScreen}
          options={({ route }) => ({
            title: "Welcome " + route.params.instructorName + "!",
            headerStyle: {
              backgroundColor: Colors.green
            },
            headerTintColor: "#fff",
            headerTitleStyle: {
              fontWeight: "bold",
              fontFamily: "Avenir"
            }
          })}
        />
        <Stack.Screen
          name="ClassView"
          component={ClassView}
          options={({ route }) => ({
            title: route.params.selectedClassName,
            headerStyle: {
              backgroundColor: Colors.green
            },
            headerTintColor: "#fff",
            headerTitleStyle: {
              fontWeight: "bold",
              fontFamily: "Avenir"
            }
          })}
        />
        <Stack.Screen
          name="StartSession"
          component={StartSession}
          // options={({ route }) => ({
          //   title: route.params.selectedClassName,
          //   headerStyle: {
          //     backgroundColor: Colors.green
          //   },
          //   headerTintColor: "#fff",
          //   headerTitleStyle: {
          //     fontWeight: "bold"
          //   }
          // })}
          options={{
            title: "Live Session",
            headerStyle: {
              backgroundColor: Colors.green
            },
            headerTintColor: "#fff",
            headerTitleStyle: {
              fontWeight: "bold",
              fontFamily: "Avenir"
            }
          }}
        />
        <Stack.Screen
          name="Feedback"
          component={Feedback}
          options={{
            title: "Past Sessions",
            headerStyle: {
              backgroundColor: Colors.green
            },
            headerTintColor: "#fff",
            headerTitleStyle: {
              fontWeight: "bold",
              fontFamily: "Avenir"
            }
          }}
        />
        <Stack.Screen
          name="AllFeedback"
          component={AllFeedback}
          options={{
            title: "All Feedback",
            headerStyle: {
              backgroundColor: Colors.green
            },
            headerTintColor: "#fff",
            headerTitleStyle: {
              fontWeight: "bold",
              fontFamily: "Avenir"
            }
          }}
        />
        <Stack.Screen
          name="SessionFeedback"
          component={SessionFeedback}
          options={{
            title: "Session Feedback",
            headerStyle: {
              backgroundColor: Colors.green
            },
            headerTintColor: "#fff",
            headerTitleStyle: {
              fontWeight: "bold",
              fontFamily: "Avenir"
            }
          }}
        />
        {/* <Stack.Screen name="BottomTabs" component={Feedback} /> */}
        <Stack.Screen
          name="StudentHomeScreen"
          component={StudentHomeScreen}
          options={({ route }) => ({
            title: "Welcome " + route.params.studentName + "!",
            headerStyle: {
              backgroundColor: Colors.green
            },
            headerTintColor: "#fff",
            headerTitleStyle: {
              fontWeight: "bold",
              fontFamily: "Avenir"
            }
          })}
        />
        <Stack.Screen
          name="ClassViewStudent"
          component={ClassViewStudent}
          options={({ route }) => ({
            title: route.params.selectedClassName,
            headerStyle: {
              backgroundColor: Colors.green
            },
            headerTintColor: "#fff",
            headerTitleStyle: {
              fontWeight: "bold",
              fontFamily: "Avenir"
            }
          })}
        />
        <Stack.Screen
          name="StartSessionStudent"
          component={StartSessionStudent}
          options={{
            title: "Live Student Session",
            headerStyle: {
              backgroundColor: Colors.green
            },
            headerTintColor: "#fff",
            headerTitleStyle: {
              fontWeight: "bold",
              fontFamily: "Avenir"
            }
          }}
        />
        <Stack.Screen
          name="StudyGroups"
          component={StudyGroups}
          options={{
            title: "Study Groups",
            headerStyle: {
              backgroundColor: Colors.green
            },
            headerTintColor: "#fff",
            headerTitleStyle: {
              fontWeight: "bold",
              fontFamily: "Avenir"
            }
          }}
        />
      </Stack.Navigator>
    </NavigationContainer>
  );
}
