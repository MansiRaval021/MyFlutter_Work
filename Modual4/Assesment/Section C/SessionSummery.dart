import 'package:flutter/material.dart';

class SessionSummaryScreen extends StatelessWidget {
  final double totalCalories;

  const SessionSummaryScreen({
    super.key,
    required this.totalCalories,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Session Summary"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Text(
              "Total Calories Burned",
              style: TextStyle(fontSize: 22),
            ),

            Text(
              "$totalCalories",
              style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 20),

            Text(
              "Great Job! Keep Going 💪",
              style: TextStyle(fontSize: 20),
            ),

            SizedBox(height: 10),

            Text(
              "Workout Saved ✔",
              style: TextStyle(
                  color: Colors.green,
                  fontSize: 20),
            )
          ],
        ),
      ),
    );
  }
}