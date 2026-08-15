import 'package:flutter/material.dart';

import '../models/food_item.dart';
import '../widgets/food_item_card.dart';

class BrowseScreen extends StatelessWidget {
  const BrowseScreen({super.key});

  static const List<FoodItem> foodItems = [
    FoodItem(
      name: 'Margherita Pizza',
      price: 249,
      description:
          'Classic pizza with tomato sauce, mozzarella and fresh basil.',
    ),
    FoodItem(
      name: 'Veg Burger',
      price: 149,
      description:
          'Crispy vegetable patty with fresh vegetables and sauces.',
    ),
    FoodItem(
      name: 'Paneer Tikka',
      price: 220,
      description:
          'Soft paneer cubes marinated with Indian spices and grilled.',
    ),
    FoodItem(
      name: 'Masala Dosa',
      price: 120,
      description:
          'Crispy South Indian dosa served with potato masala and chutney.',
    ),
    FoodItem(
      name: 'Veg Biryani',
      price: 199,
      description:
          'Aromatic basmati rice cooked with vegetables and spices.',
    ),
    FoodItem(
      name: 'Chocolate Brownie',
      price: 99,
      description:
          'Soft and delicious chocolate brownie served as a sweet treat.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: foodItems.length,
      itemBuilder: (context, index) {
        final item = foodItems[index];

        return FoodItemCard(
          item: item,
          onTap: () {
            Navigator.pushNamed(
              context,
              '/food-detail',
              arguments: item,
            );
          },
        );
      },
    );
  }
}