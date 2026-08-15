import 'package:flutter/material.dart';

import '../models/food_item.dart';

class SavedFoodCard extends StatelessWidget {
  final FoodItem item;
  final VoidCallback onDelete;

  const SavedFoodCard({
    super.key,
    required this.item,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),

        leading: const CircleAvatar(
          child: Icon(Icons.bookmark),
        ),

        title: Text(
          item.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),

        subtitle: Text(
          '₹${item.price.toStringAsFixed(0)}\n'
          '${item.description}',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),

        isThreeLine: true,

        trailing: IconButton(
          icon: const Icon(
            Icons.delete_outline,
            color: Colors.red,
          ),
          onPressed: onDelete,
        ),
      ),
    );
  }
}