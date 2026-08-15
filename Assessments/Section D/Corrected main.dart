import 'package:flutter/material.dart';

import 'database_helper.dart';

void main() {
  runApp(const FoodOrderApp());
}

class FoodOrderApp extends StatelessWidget {
  const FoodOrderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Food Orders',
      theme: ThemeData(
        colorSchemeSeed: Colors.orange,
        useMaterial3: true,
      ),
      home: const FoodOrderScreen(),
    );
  }
}

class FoodOrderScreen extends StatefulWidget {
  const FoodOrderScreen({super.key});

  @override
  State<FoodOrderScreen> createState() =>
      _FoodOrderScreenState();
}

class _FoodOrderScreenState
    extends State<FoodOrderScreen> {

  List<Map<String, dynamic>> orders = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    loadOrders();
  }

  // Load orders
  Future<void> loadOrders() async {
    try {
      // Insert samples only if table is empty
      await DatabaseHelper.insertSampleData();

      final data =
          await DatabaseHelper.getOrders();

      if (!mounted) return;

      setState(() {
        orders = data;
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

  // Update quantity
  Future<void> updateQuantity(
    int id,
    int quantity,
  ) async {
    try {
      await DatabaseHelper.updateOrder(
        id,
        quantity,
      );

      final updatedOrders =
          await DatabaseHelper.getOrders();

      if (!mounted) return;

      setState(() {
        orders = updatedOrders;
      });
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Failed to update order: $error',
          ),
        ),
      );
    }
  }

  // Delete order
  Future<void> deleteOrder(int id) async {
    try {
      await DatabaseHelper.deleteOrder(id);

      if (!mounted) return;

      // Immediately remove from UI
      setState(() {
        orders.removeWhere(
          (order) => order['id'] == id,
        );
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Order deleted successfully',
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

  // Show update dialog
  void showQuantityDialog(
    int id,
    int currentQuantity,
  ) {
    final controller = TextEditingController(
      text: currentQuantity.toString(),
    );

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text(
            'Update Quantity',
          ),

          content: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Quantity',
              border: OutlineInputBorder(),
            ),
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text(
                'Cancel',
              ),
            ),

            ElevatedButton(
              onPressed: () {
                final quantity =
                    int.tryParse(
                  controller.text.trim(),
                );

                if (quantity == null ||
                    quantity <= 0) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Enter a positive quantity',
                      ),
                    ),
                  );

                  return;
                }

                updateQuantity(
                  id,
                  quantity,
                );

                Navigator.pop(dialogContext);
              },
              child: const Text(
                'Update',
              ),
            ),
          ],
        );
      },
    ).then((_) {
      controller.dispose();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Food Orders',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : orders.isEmpty
              ? const Center(
                  child: Text(
                    'No orders found',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: orders.length,

                  itemBuilder: (
                    context,
                    index,
                  ) {
                    final order =
                        orders[index];

                    return Card(
                      margin:
                          const EdgeInsets.only(
                        bottom: 12,
                      ),

                      child: ListTile(
                        onTap: () {
                          showQuantityDialog(
                            order['id'],
                            order['quantity'],
                          );
                        },

                        leading: CircleAvatar(
                          child: Text(
                            '${order['id']}',
                          ),
                        ),

                        title: Text(
                          order['item_name'],
                          style:
                              const TextStyle(
                            fontWeight:
                                FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),

                        subtitle: Text(
                          'Quantity: ${order['quantity']}',
                        ),

                        trailing: IconButton(
                          icon: const Icon(
                            Icons.delete_outline,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            deleteOrder(
                              order['id'],
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}