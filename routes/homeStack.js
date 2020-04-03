import * as React from "react";
import { useState, useEffect } from "react";
import { View, Text, Button, TextInput } from "react-native";
import { NavigationContainer } from "@react-navigation/native";
import { createStackNavigator } from "@react-navigation/stack";
import { createAppContainer } from "react-navigation";

import Login from "../screens/Login";
import InstructorHome from "../screens/InstructorHome";

const screens = {
  Login: {
    screen: Login
  },
  InstructorHome: {
    screen: InstructorHome
  }
};

const HomeStack = createStackNavigator(screens);

export default createAppContainer(HomeStack);
