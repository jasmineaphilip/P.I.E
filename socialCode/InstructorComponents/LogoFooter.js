import React from "react";
import { View, Text, StyleSheet, Image } from "react-native";

import Colors from "../constants/colors";
import logo from "../screens/logo.png";
import mic from "../screens/mic.png";

const LogoFooter = props => {
  return (
    <View style={styles.footer}>
      <Image source={logo} style={styles.logo} />
      <Image source={mic} style={styles.mic} />
    </View>
  );
};

const styles = StyleSheet.create({
  footer: {
    width: "100%",
    height: 90,
    //paddingTop: 36,
    //backgroundColor: Colors.green,
    alignItems: "center",
    justifyContent: "center",
    position: "absolute",
    bottom: 0
  },
  logo: {
    width: 75,
    height: 75,
    position: "absolute",
    right: 10,
    bottom: 10
  },
  mic: {
    width: 75,
    height: 75,
    position: "absolute",
    left: 10,
    bottom: 10
  }
});

export default LogoFooter;
