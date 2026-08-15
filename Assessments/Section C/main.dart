import 'package:flutter/material.dart';

import 'models/food_item.dart';
import 'screens/food_detail_screen.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const FoodBookmarksApp());
}

class FoodBookmarksApp extends StatelessWidget {
  const FoodBookmarksApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Offline Food Bookmarks',

      theme: ThemeData(
        colorSchemeSeed: Colors.orange,
        useMaterial3: true,
      ),

      initialRoute: '/',

      routes: {
        '/': (context) =>
            const HomeScreen(),

        '/food-detail': (context) {
          final item =
              ModalRoute.of(context)!
                  .settings
                  .arguments as FoodItem;

          return FoodDetailScreen(
            item: item,
          );
        },
      },
    );
  }
}