import 'package:flutter/material.dart';

import '../models/restaurant.dart';
import 'restaurant_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final List<Restaurant> restaurants = const [
    Restaurant(
      name: 'Spice Garden',
      cuisine: 'North Indian',
      rating: 4.5,
    ),
    Restaurant(
      name: 'Pizza Paradise',
      cuisine: 'Italian',
      rating: 4.2,
    ),
    Restaurant(
      name: 'Green Leaf',
      cuisine: 'South Indian',
      rating: 4.7,
    ),
  ];

  void openRestaurantDetail(
    BuildContext context,
    Restaurant restaurant,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const RestaurantDetailScreen(),
        settings: RouteSettings(
          arguments: {
            'name': restaurant.name,
            'rating': restaurant.rating,
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Restaurants',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: restaurants.length,
        itemBuilder: (context, index) {
          final restaurant = restaurants[index];

          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              contentPadding: const EdgeInsets.all(12),

              leading: CircleAvatar(
                radius: 28,
                child: Text(
                  restaurant.name[0],
                  style: const TextStyle(
                    fontSize: 20,
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
                ),
              ),

              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    restaurant.rating.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              onTap: () {
                openRestaurantDetail(
                  context,
                  restaurant,
                );
              },
            ),
          );
        },
      ),
    );
  }
}