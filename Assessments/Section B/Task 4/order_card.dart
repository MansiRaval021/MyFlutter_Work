import 'package:flutter/material.dart';

import '../models/order.dart';

class OrderCard extends StatelessWidget {
  final FoodOrder order;
  final VoidCallback onDelete;

  const OrderCard({
    super.key,
    required this.order,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),

        leading: const CircleAvatar(
          child: Icon(
            Icons.fastfood,
          ),
        ),

        title: Text(
          order.itemName,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),

        subtitle: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Text(
            'Quantity: ${order.quantity}',
          ),
        ),

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