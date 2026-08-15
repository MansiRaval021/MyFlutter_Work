import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/food_item.dart';

class DatabaseHelper {
  static final DatabaseHelper instance =
      DatabaseHelper._internal();

  DatabaseHelper._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();

    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();

    final path = join(
      databasePath,
      'food_bookmarks.db',
    );

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }

  Future<void> _createDatabase(
    Database db,
    int version,
  ) async {
    await db.execute('''
      CREATE TABLE bookmarks (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL UNIQUE,
        price REAL NOT NULL,
        description TEXT NOT NULL
      )
    ''');
  }

  // Add bookmark
  Future<int> insertBookmark(FoodItem item) async {
    final db = await database;

    return await db.insert(
      'bookmarks',
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  // Get all bookmarks
  Future<List<FoodItem>> getBookmarks() async {
    final db = await database;

    final result = await db.query(
      'bookmarks',
      orderBy: 'id DESC',
    );

    return result
        .map(
          (map) => FoodItem.fromMap(map),
        )
        .toList();
  }

  // Check whether item is bookmarked
  Future<bool> isBookmarked(String name) async {
    final db = await database;

    final result = await db.query(
      'bookmarks',
      where: 'name = ?',
      whereArgs: [name],
      limit: 1,
    );

    return result.isNotEmpty;
  }

  // Delete bookmark by food name
  Future<int> deleteBookmark(String name) async {
    final db = await database;

    return await db.delete(
      'bookmarks',
      where: 'name = ?',
      whereArgs: [name],
    );
  }
}