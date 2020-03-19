import React, { useState } from "react";
import {
  FlatList,
  StyleSheet,
  Text,
  View,
  Button,
  TextInput,
  ScrollView
} from "react-native";

import GoalItem from "./components/GoalItem";
import GoalInput from "./components/GoalInput";

export default function App() {
  const [courseGoals, setCourseGoals] = useState([]);
  const [isAddMode, setIsAddMode] = useState(false);
  //set____ is the function to change the ____ state
  //for isAddMode, initially passing it "false" state

  const addGoalHandler = goalTitle => {
    setCourseGoals(currentGoals => [
      ...currentGoals,
      { id: Math.random().toString(), value: goalTitle }
    ]);
    setIsAddMode(false);
    //... creates a new array with all elements of old array plus enteredGoal
    // can also write above as:
    // setCourseGoals(currentGoals => [...currentGoals, enteredGoal]);
    //^^this is kinda the better option but both should technically work
  };

  const removeGoalHandler = goalId => {
    setCourseGoals(currentGoals => {
      return currentGoals.filter(goal => goal.id !== goalId);
      //filter runs on every goal of currentGoals array, checks
      //if id of that goal is equal to goalId we're getting as argument
      //if goalId is not the same, then add it to the array of goals
      //that filter will return as result
    });
  };

  const cancelGoalAdditionHandler = () => {
    setIsAddMode(false);
  };

  return (
    <View style={styles.screen}>
      <Button title="Add New Goal" onPress={() => setIsAddMode(true)} />
      {/*^^ setIsAddMode sets the mode to true when button is pressed, so can open modal*/}
      <GoalInput
        visible={isAddMode}
        onAddGoal={addGoalHandler}
        onCancel={cancelGoalAdditionHandler}
      />
      <FlatList
        keyExtractor={(item, index) => item.id}
        data={courseGoals}
        renderItem={
          itemData => (
            <GoalItem
              id={itemData.item.id}
              //instead of above line, could just have in below line
              //onDelete={removeGoalHanlder.bind(this, itemData.item.id)}
              onDelete={removeGoalHandler}
              title={itemData.item.value}
            />
          )
          //rn since the key is also goal, will give an error if you try to
          //always add key to the root element in the list aka the element youre trying to repeat}>
        }
      />
    </View>
  );
}

const styles = StyleSheet.create({
  screen: {
    padding: 50
  }
});
