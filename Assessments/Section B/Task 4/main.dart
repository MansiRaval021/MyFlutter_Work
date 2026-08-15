import 'package:flutter/material.dart';

import 'screens/place_order_screen.dart';
import 'screens/my_orders_screen.dart';

void main() {
  runApp(const FoodDeliveryApp());
}

class FoodDeliveryApp extends StatelessWidget {
  const FoodDeliveryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Food Delivery App',

      theme: ThemeData(
        colorSchemeSeed: Colors.orange,
        useMaterial3: true,
      ),

      // Named routes
      initialRoute: '/',

      routes: {
        '/': (context) =>
            const PlaceOrderScreen(),

        '/orders': (context) =>
            const MyOrdersScreen(),
      },
    );
  }
}