import 'package:flutter/material.dart';

import '../models/restaurant.dart';

class FavouriteCard extends StatelessWidget {
  final Restaurant restaurant;

  const FavouriteCard({
    super.key,
    required this.restaurant,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),

        leading: const CircleAvatar(
          child: Icon(
            Icons.favorite,
            color: Colors.red,
          ),
        ),

        title: Text(
          restaurant.name,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),

        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Text(
            restaurant.cuisine,
          ),
        ),
      ),
    );
  }
}