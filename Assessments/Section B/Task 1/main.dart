import 'package:flutter/material.dart';

import 'screens/home_screen.dart';

void main() {
  runApp(const RestaurantApp());
}

class RestaurantApp extends StatelessWidget {
  const RestaurantApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Restaurant App',

      theme: ThemeData(
        colorSchemeSeed: Colors.orange,
        useMaterial3: true,
      ),

      home: const HomeScreen(),
    );
  }
}