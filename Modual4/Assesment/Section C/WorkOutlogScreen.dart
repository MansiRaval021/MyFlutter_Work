
import 'package:flutter/material.dart';

import 'Exercsize.dart';

class WorkoutLogScreen extends StatefulWidget {
  const WorkoutLogScreen({super.key});

  @override
  State<WorkoutLogScreen> createState() => _WorkoutLogScreenState();
}

class _WorkoutLogScreenState extends State<WorkoutLogScreen> {
  List<Exercise> session = [];

  double totalCalories = 0;

  void addExercise() {
    setState(() {
      session.add(exerciseList[0]);
      totalCalories += exerciseList[0].caloriesPerSet;
    });
  }

  void removeExercise() {
    if (session.isNotEmpty) {
      setState(() {
        totalCalories -= session.last.caloriesPerSet;
        session.removeLast();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Workout Log"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [

            Text(
              "Exercises Logged: ${session.length}",
              style: const TextStyle(fontSize: 20),
            ),

            Text(
              "Calories: $totalCalories",
              style: const TextStyle(fontSize: 20),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: addExercise,
              child: const Text("Add Exercise"),
            ),
            SizedBox(height: 10,),

            ElevatedButton(
              onPressed: removeExercise,
              child: const Text("Remove Exercise"),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  "/summary",
                  arguments: totalCalories,
                );
              },
              child: const Text("Finish Workout"),
            )
          ],
        ),
      ),
    );
  }
}
