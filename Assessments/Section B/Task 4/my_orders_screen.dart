import 'package:flutter/material.dart';

import '../database/database_helper.dart';
import '../models/order.dart';
import '../widgets/order_card.dart';

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({super.key});

  @override
  State<MyOrdersScreen> createState() =>
      _MyOrdersScreenState();
}

class _MyOrdersScreenState
    extends State<MyOrdersScreen> {

  List<FoodOrder> orders = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    // Fetch orders when screen opens
    _loadOrders();
  }

  // Fetch orders from SQLite
  Future<void> _loadOrders() async {
    try {
      final savedOrders =
          await DatabaseHelper.instance.getOrders();

      if (!mounted) return;

      setState(() {
        orders = savedOrders;
        isLoading = false;
      });
    } catch (error) {
      if (!mounted) return;

      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Failed to load orders: $error',
          ),
        ),
      );
    }
  }

  // Delete order
  Future<void> _deleteOrder(int index) async {
    final order = orders[index];

    try {
      // Delete from SQLite
      await DatabaseHelper.instance.deleteOrder(
        order.id!,
      );

      if (!mounted) return;

      // Remove from UI immediately after successful DB deletion
      setState(() {
        orders.removeAt(index);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '${order.itemName} deleted',
          ),
        ),
      );
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Failed to delete order: $error',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Orders',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    // Loading state
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    // Empty state
    if (orders.isEmpty) {
      return const Center(
        child: Text(
          'No orders yet',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    }

    // Orders list
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];

        return OrderCard(
          order: order,
          onDelete: () {
            _deleteOrder(index);
          },
        );
      },
    );
  }
}