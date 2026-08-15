import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? database;

  static Future<Database> getDatabase() async {
    if (database != null) {
      return database!;
    }

    final path = join(
      await getDatabasesPath(),
      'food_orders.db',
    );

    database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE orders (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            item_name TEXT,
            quantity INTEGER
          )
        ''');
      },
    );

    return database!;
  }

  static Future<void> insertSampleData() async {
    final db = await getDatabase();

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

  static Future<List<Map<String, dynamic>>>
      getOrders() async {
    final db = await getDatabase();

    return await db.query(
      'orders',
    );
  }

  static Future<void> updateOrder(
    int id,
    int quantity,
  ) async {
    final db = await getDatabase();

    await db.update(
      'orders',
      {
        'quantity': quantity,
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static Future<void> deleteOrder(int id) async {
    final db = await getDatabase();

    await db.delete(
      'orders',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}