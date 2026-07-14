import 'package:flutter/material.dart';

class ExerciseCard extends StatelessWidget {
  final Exercise exercise;

  const ExerciseCard({super.key, required this.exercise});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: ListTile(
        leading: const Icon(Icons.fitness_center),
        title: Text(exercise.name),
        subtitle: Text(
            "${exercise.caloriesPerSet} cal/set | Cardio: ${exercise.isCardio}"),
      ),
    );
  }
}


class Exercise {
  String name;
  double caloriesPerSet;
  bool isCardio;

  Exercise(this.name, this.caloriesPerSet, this.isCardio);
}

// Sample Exercise Objects
List<Exercise> exerciseList = [
  Exercise("Push Ups", 10, false),
  Exercise("Running", 20, true),
  Exercise("Squats", 15, false),
];
