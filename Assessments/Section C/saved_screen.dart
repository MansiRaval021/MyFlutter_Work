import 'package:flutter/material.dart';

import '../database/database_helper.dart';
import '../models/food_item.dart';
import '../widgets/saved_food_card.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({super.key});

  @override
  State<SavedScreen> createState() =>
      _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  List<FoodItem> savedItems = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    _loadSavedItems();
  }

  // Fetch bookmarks from SQLite
  Future<void> _loadSavedItems() async {
    setState(() {
      isLoading = true;
    });

    try {
      final items =
          await DatabaseHelper.instance.getBookmarks();

      if (!mounted) return;

      setState(() {
        savedItems = items;
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
            'Failed to load bookmarks: $error',
          ),
        ),
      );
    }
  }

  // Delete bookmark
  Future<void> _deleteBookmark(
    FoodItem item,
  ) async {
    try {
      await DatabaseHelper.instance
          .deleteBookmark(item.name);

      if (!mounted) return;

      // Remove from UI immediately
      setState(() {
        savedItems.removeWhere(
          (savedItem) =>
              savedItem.name == item.name,
        );
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '${item.name} removed from saved items',
          ),
        ),
      );
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Failed to remove bookmark: $error',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Refresh when this tab becomes visible again.
    // initState still performs the initial SQLite fetch.
    return _buildContent();
  }

  Widget _buildContent() {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (savedItems.isEmpty) {
      return const Center(
        child: Text(
          'No bookmarks saved yet',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: savedItems.length,
      itemBuilder: (context, index) {
        final item = savedItems[index];

        return SavedFoodCard(
          item: item,
          onDelete: () {
            _deleteBookmark(item);
          },
        );
      },
    );
  }

  // Public method that can be called by HomeScreen
  Future<void> refreshBookmarks() async {
    await _loadSavedItems();
  }
}