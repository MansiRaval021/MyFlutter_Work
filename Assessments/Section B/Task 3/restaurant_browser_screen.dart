import 'package:flutter/material.dart';

import '../models/restaurant.dart';
import '../widgets/restaurant_card.dart';
import '../widgets/favourite_card.dart';

class RestaurantBrowserScreen extends StatefulWidget {
  const RestaurantBrowserScreen({super.key});

  @override
  State<RestaurantBrowserScreen> createState() =>
      _RestaurantBrowserScreenState();
}

class _RestaurantBrowserScreenState
    extends State<RestaurantBrowserScreen> {

  // Selected bottom navigation tab
  int selectedIndex = 0;

  // Favourites list
  final List<Restaurant> favourites = [];

  // Hardcoded restaurant data
  final List<Restaurant> restaurants = const [
    Restaurant(
      name: 'Spice Garden',
      cuisine: 'North Indian',
    ),
    Restaurant(
      name: 'Pizza Paradise',
      cuisine: 'Italian',
    ),
    Restaurant(
      name: 'Green Leaf',
      cuisine: 'South Indian',
    ),
    Restaurant(
      name: 'Burger House',
      cuisine: 'Fast Food',
    ),
    Restaurant(
      name: 'Dragon Bowl',
      cuisine: 'Chinese',
    ),
    Restaurant(
      name: 'Royal Thali',
      cuisine: 'Gujarati',
    ),
  ];

  // Change bottom navigation tab
  void changeTab(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  // Add restaurant to favourites
  void addToFavourites(Restaurant restaurant) {
    if (favourites.contains(restaurant)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '${restaurant.name} is already in favourites',
          ),
        ),
      );
      return;
    }

    setState(() {
      favourites.add(restaurant);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${restaurant.name} added to favourites',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          selectedIndex == 0
              ? 'Restaurants'
              : 'Favourites',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      body: selectedIndex == 0
          ? buildRestaurantList()
          : buildFavouritesList(),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: changeTab,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant),
            label: 'Restaurants',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favourites',
          ),
        ],
      ),
    );
  }

  // Restaurant list
  Widget buildRestaurantList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: restaurants.length,
      itemBuilder: (context, index) {
        final restaurant = restaurants[index];

        return RestaurantCard(
          restaurant: restaurant,
          onLongPress: () {
            addToFavourites(restaurant);
          },
        );
      },
    );
  }

  // Favourites list
  Widget buildFavouritesList() {
    if (favourites.isEmpty) {
      return const Center(
        child: Text(
          'No favourites yet',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: favourites.length,
      itemBuilder: (context, index) {
        final restaurant = favourites[index];

        return FavouriteCard(
          restaurant: restaurant,
        );
      },
    );
  }
}