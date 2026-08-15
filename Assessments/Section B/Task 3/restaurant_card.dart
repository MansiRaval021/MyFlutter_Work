import 'package:flutter/material.dart';

import '../models/restaurant.dart';

class RestaurantCard extends StatelessWidget {
  final Restaurant restaurant;
  final VoidCallback onLongPress;

  const RestaurantCard({
    super.key,
    required this.restaurant,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: onLongPress,
      child: Card(
        margin: const EdgeInsets.only(bottom: 12),
        elevation: 2,
        child: ListTile(
          contentPadding: const EdgeInsets.all(16),

          leading: CircleAvatar(
            child: Text(
              restaurant.name[0],
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
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
              style: TextStyle(
                color: Colors.grey.shade600,
              ),
            ),
          ),

          trailing: const Icon(
            Icons.favorite_border,
          ),
        ),
      ),
    );
  }
}