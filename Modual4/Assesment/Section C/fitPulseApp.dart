
import 'package:flutter/material.dart';

import 'Homescreen.dart';
import 'SessionSummery.dart';
import 'WorkOutlogScreen.dart';

class FitPulseApp extends StatelessWidget {
  const FitPulseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "FitPulse",
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/workout': (context) => WorkoutLogScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/summary') {
          final totalCalories = settings.arguments as double;

          return MaterialPageRoute(
            builder: (context) =>
                SessionSummaryScreen(totalCalories: totalCalories),
          );
        }
        return null;
      },
    );
  }
}