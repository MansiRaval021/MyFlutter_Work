import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/order.dart';

class DatabaseHelper {
  static final DatabaseHelper instance =
      DatabaseHelper._internal();

  DatabaseHelper._internal();

  Database? _database;

  // Get database instance
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();

    return _database!;
  }

  // Initialize database
  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();

    final path = join(
      databasePath,
      'food_orders.db',
    );

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }

  // Create orders table
  Future<void> _createDatabase(
    Database db,
    int version,
  ) async {
    await db.execute('''
      CREATE TABLE orders (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        item_name TEXT NOT NULL,
        quantity INTEGER NOT NULL
      )
    ''');
  }

  // Insert order
  Future<int> insertOrder(FoodOrder order) async {
    final db = await database;

    return await db.insert(
      'orders',
      order.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Fetch all orders
  Future<List<FoodOrder>> getOrders() async {
    final db = await database;

    final List<Map<String, dynamic>> maps =
        await db.query(
      'orders',
      orderBy: 'id DESC',
    );

    return maps
        .map(
          (map) => FoodOrder.fromMap(map),
        )
        .toList();
  }

  // Delete order
  Future<int> deleteOrder(int id) async {
    final db = await database;

    return await db.delete(
      'orders',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}