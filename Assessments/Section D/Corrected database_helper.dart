import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database? _database;

  // Get database
  static Future<Database> getDatabase() async {
    if (_database != null) {
      return _database!;
    }

    final path = join(
      await getDatabasesPath(),
      'food_orders.db',
    );

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE orders (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            item_name TEXT NOT NULL,
            quantity INTEGER NOT NULL
          )
        ''');
      },
    );

    return _database!;
  }

  // Insert sample data ONLY when table is empty
  static Future<void> insertSampleData() async {
    final db = await getDatabase();

    final result = await db.rawQuery(
      'SELECT COUNT(*) as count FROM orders',
    );

    final count = Sqflite.firstIntValue(result) ?? 0;

    if (count == 0) {
      await db.insert(
        'orders',
        {
          'item_name': 'Pizza',
          'quantity': 2,
        },
      );

      await db.insert(
        'orders',
        {
          'item_name': 'Burger',
          'quantity': 1,
        },
      );

      await db.insert(
        'orders',
        {
          'item_name': 'Pasta',
          'quantity': 3,
        },
      );
    }
  }

  // Get all orders
  static Future<List<Map<String, dynamic>>>
      getOrders() async {
    final db = await getDatabase();

    return await db.query(
      'orders',
      orderBy: 'id ASC',
    );
  }

  // Update quantity
  static Future<int> updateOrder(
    int id,
    int quantity,
  ) async {
    final db = await getDatabase();

    return await db.update(
      'orders',
      {
        'quantity': quantity,
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Delete order
  static Future<int> deleteOrder(int id) async {
    final db = await getDatabase();

    return await db.delete(
      'orders',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}