import 'package:flutter/material.dart';

import '../database/database_helper.dart';
import '../models/food_item.dart';

class FoodDetailScreen extends StatefulWidget {
  final FoodItem item;

  const FoodDetailScreen({
    super.key,
    required this.item,
  });

  @override
  State<FoodDetailScreen> createState() =>
      _FoodDetailScreenState();
}

class _FoodDetailScreenState
    extends State<FoodDetailScreen> {

  bool isBookmarked = false;
  bool isLoading = true;
  bool isSaving = false;

  @override
  void initState() {
    super.initState();

    _checkBookmarkStatus();
  }

  // Check whether food is already saved
  Future<void> _checkBookmarkStatus() async {
    try {
      final saved =
          await DatabaseHelper.instance
              .isBookmarked(widget.item.name);

      if (!mounted) return;

      setState(() {
        isBookmarked = saved;
        isLoading = false;
      });
    } catch (error) {
      if (!mounted) return;

      setState(() {
        isLoading = false;
      });
    }
  }

  // Bookmark / Remove bookmark
  Future<void> _toggleBookmark() async {
    if (isSaving) return;

    setState(() {
      isSaving = true;
    });

    try {
      if (isBookmarked) {
        await DatabaseHelper.instance
            .deleteBookmark(widget.item.name);

        if (!mounted) return;

        setState(() {
          isBookmarked = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Bookmark removed',
            ),
          ),
        );
      } else {
        await DatabaseHelper.instance
            .insertBookmark(widget.item);

        if (!mounted) return;

        setState(() {
          isBookmarked = true;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Food item bookmarked successfully',
            ),
          ),
        );
      }
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Operation failed: $error',
          ),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          isSaving = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Food Details',
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [

            // Food icon
            Container(
              width: double.infinity,
              height: 180,
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                borderRadius:
                    BorderRadius.circular(20),
              ),
              child: const Icon(
                Icons.fastfood,
                size: 90,
                color: Colors.orange,
              ),
            ),

            const SizedBox(height: 25),

            // Name
            Text(
              widget.item.name,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            // Price
            Text(
              '₹${widget.item.price.toStringAsFixed(0)}',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            // Description
            const Text(
              'Description',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              widget.item.description,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade700,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 35),

            // Bookmark button
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton.icon(
                onPressed:
                    isLoading || isSaving
                        ? null
                        : _toggleBookmark,

                icon: isSaving
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child:
                            CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      )
                    : Icon(
                        isBookmarked
                            ? Icons.bookmark_remove
                            : Icons.bookmark_add,
                      ),

                label: Text(
                  isBookmarked
                      ? 'Remove Bookmark'
                      : 'Bookmark',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}