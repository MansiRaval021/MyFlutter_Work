import 'package:flutter/material.dart';

import '../database/database_helper.dart';
import '../models/order.dart';

class PlaceOrderScreen extends StatefulWidget {
  const PlaceOrderScreen({super.key});

  @override
  State<PlaceOrderScreen> createState() =>
      _PlaceOrderScreenState();
}

class _PlaceOrderScreenState
    extends State<PlaceOrderScreen> {

  // Form key
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController _itemNameController =
      TextEditingController();

  final TextEditingController _quantityController =
      TextEditingController();

  bool _isSaving = false;

  // Save order
  Future<void> _placeOrder() async {
    // Validate form
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final itemName =
        _itemNameController.text.trim();

    final quantity =
        int.parse(_quantityController.text.trim());

    setState(() {
      _isSaving = true;
    });

    try {
      // Create order object
      final order = FoodOrder(
        itemName: itemName,
        quantity: quantity,
      );

      // Insert into SQLite
      await DatabaseHelper.instance
          .insertOrder(order);

      if (!mounted) return;

      // Clear form
      _itemNameController.clear();
      _quantityController.clear();

      // Navigate to My Orders
      Navigator.pushNamed(
        context,
        '/orders',
      );
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Failed to save order: $error',
          ),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _itemNameController.dispose();
    _quantityController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Place Order',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,

        actions: [
          IconButton(
            icon: const Icon(Icons.receipt_long),
            tooltip: 'My Orders',
            onPressed: () {
              Navigator.pushNamed(
                context,
                '/orders',
              );
            },
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,

          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [

              const Text(
                'Order Your Food',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                'Enter the food item and quantity.',
                style: TextStyle(
                  color: Colors.grey.shade600,
                ),
              ),

              const SizedBox(height: 30),

              // Item name
              const Text(
                'Item Name',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 8),

              TextFormField(
                controller: _itemNameController,
                textInputAction:
                    TextInputAction.next,

                decoration: const InputDecoration(
                  hintText: 'Example: Pizza',
                  prefixIcon: Icon(
                    Icons.fastfood,
                  ),
                  border: OutlineInputBorder(),
                ),

                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty) {
                    return 'Please enter item name';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 20),

              // Quantity
              const Text(
                'Quantity',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 8),

              TextFormField(
                controller: _quantityController,
                keyboardType:
                    TextInputType.number,
                textInputAction:
                    TextInputAction.done,

                decoration: const InputDecoration(
                  hintText: 'Example: 2',
                  prefixIcon: Icon(
                    Icons.numbers,
                  ),
                  border: OutlineInputBorder(),
                ),

                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty) {
                    return 'Please enter quantity';
                  }

                  final quantity =
                      int.tryParse(value.trim());

                  if (quantity == null) {
                    return 'Quantity must be a positive integer';
                  }

                  if (quantity <= 0) {
                    return 'Quantity must be greater than 0';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 30),

              // Place order button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton.icon(
                  onPressed:
                      _isSaving ? null : _placeOrder,

                  icon: _isSaving
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child:
                              CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        )
                      : const Icon(
                          Icons.shopping_cart,
                        ),

                  label: Text(
                    _isSaving
                        ? 'Saving...'
                        : 'Place Order',
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // View orders button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      '/orders',
                    );
                  },
                  icon: const Icon(
                    Icons.receipt_long,
                  ),
                  label: const Text(
                    'View My Orders',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}