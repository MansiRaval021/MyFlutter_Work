import 'package:flutter/material.dart';

import 'browse_screen.dart';
import 'saved_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() =>
      _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  final GlobalKey<_SavedScreenState> savedScreenKey =
      GlobalKey<_SavedScreenState>();

  late final List<Widget> screens;

  @override
  void initState() {
    super.initState();

    screens = [
      const BrowseScreen(),

      SavedScreen(
        key: savedScreenKey,
      ),
    ];
  }

  void onTabSelected(int index) {
    setState(() {
      selectedIndex = index;
    });

    // Refresh Saved tab whenever user opens it.
    if (index == 1) {
      savedScreenKey.currentState?.refreshBookmarks();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          selectedIndex == 0
              ? 'Browse Food'
              : 'Saved Food',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      body: IndexedStack(
        index: selectedIndex,
        children: screens,
      ),

      bottomNavigationBar:
          BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: onTabSelected,

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant_menu),
            label: 'Browse',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Saved',
          ),
        ],
      ),
    );
  }
}