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

  @override
  void initState() {
    super.initState();
    loadOrders();
  }

  Future<void> loadOrders() async {
    await DatabaseHelper.insertSampleData();

    orders = await DatabaseHelper.getOrders();

    setState(() {});
  }

  Future<void> updateQuantity(
    int id,
    int quantity,
  ) async {
    await DatabaseHelper.updateOrder(
      id,
      quantity,
    );

    orders = await DatabaseHelper.getOrders();

    setState(() {});
  }

  Future<void> deleteOrder(int id) async {
    await DatabaseHelper.deleteOrder(id);

    orders.removeWhere(
      (order) => order['id'] == id,
    );

    setState(() {});
  }

  void showQuantityDialog(
    int id,
    int currentQuantity,
  ) {
    final controller = TextEditingController(
      text: currentQuantity.toString(),
    );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Update Quantity'),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
          ),
          actions: [
            TextButton(
              onPressed: () {
                final quantity =
                    int.parse(controller.text);

                updateQuantity(
                  id,
                  quantity,
                );

                Navigator.pop(context);
              },
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Food Orders'),
      ),
      body: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];

          return ListTile(
            title: Text(
              order['item_name'],
            ),
            subtitle: Text(
              'Quantity: ${order['quantity']}',
            ),
            onTap: () {
              showQuantityDialog(
                order['id'],
                order['quantity'],
              );
            },
            trailing: IconButton(
              icon: const Icon(
                Icons.delete,
              ),
              onPressed: () {
                deleteOrder(
                  order['id'],
                );
              },
            ),
          );
        },
      ),
    );
  }
}