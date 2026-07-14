
import 'package:flutter/material.dart';

import 'Exercsize.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("FitPulse"),
      ),
      body: ListView.builder(
        itemCount: exerciseList.length,
        itemBuilder: (context, index) {
          return ExerciseCard(exercise: exerciseList[index]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.arrow_forward),
        onPressed: () {
          Navigator.pushNamed(context, "/workout");
        },
      ),
    );
  }
}
