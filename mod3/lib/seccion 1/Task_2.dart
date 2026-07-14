import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: newApp(),));
}
class newApp extends StatefulWidget {
  const newApp({super.key});
  @override
  State<newApp> createState() => _newAppState();
}
class _newAppState extends State<newApp> {
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            
            Icon(Icons.favorite, size: 100,),
            
          ],
        ),
      ),
    );
  }
}
