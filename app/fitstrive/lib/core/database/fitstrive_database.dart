import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'food_item_seed_data.dart';

class AppDatabase {
  Database? database;

  Future<Database> getDatabase() async {
    database ??= await create();
    return database!;
  }

  static Future<Database> create() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'fitstrive.db');

    return openDatabase(
      path,
      version: 3,

      onCreate: (db, version) async {
        await _createTables(db);
        await _seedFoodItems(db);
      },

      onUpgrade: (db, oldVersion, newVersion) async {
        // Development reset.
        // This recreates the database schema when the version changes.
        await db.execute('DROP TABLE IF EXISTS food_log');
        await db.execute('DROP TABLE IF EXISTS food_item');
        await db.execute('DROP TABLE IF EXISTS health');
        await db.execute('DROP TABLE IF EXISTS user');

        await _createTables(db);
        await _seedFoodItems(db);
      },

      onOpen: (db) async {
        // Only seed here. Do not create tables in onOpen.
        // onOpen runs every time the database opens.
        await _seedFoodItems(db);
      },
    );
  }

  static Future<void> _createTables(Database db) async {
    await db.execute('''
CREATE TABLE IF NOT EXISTS user (
  id TEXT PRIMARY KEY,
  email TEXT NOT NULL,
  firstName TEXT NOT NULL,
  lastName TEXT
)
''');

    await db.execute('''
CREATE TABLE IF NOT EXISTS food_log (
  id TEXT PRIMARY KEY,
  foodname TEXT NOT NULL,
  calories REAL NOT NULL,
  weight REAL NOT NULL,
  unitSymbol TEXT NOT NULL,
  carbohydrates REAL NOT NULL,
  protein REAL NOT NULL,
  fats REAL NOT NULL,
  date TEXT NOT NULL
)
''');

    await db.execute('''
CREATE TABLE IF NOT EXISTS food_item (
  id INTEGER PRIMARY KEY,
  foodname TEXT NOT NULL,
  calories REAL NOT NULL,
  weight REAL NOT NULL,
  unitSymbol TEXT NOT NULL,
  carbohydrates REAL NOT NULL,
  protein REAL NOT NULL,
  fats REAL NOT NULL
)
''');

    await db.execute('''
CREATE TABLE IF NOT EXISTS health (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  height REAL NOT NULL,
  weight REAL NOT NULL,
  date TEXT NOT NULL
)
''');
  }

  static Future<void> _seedFoodItems(Database db) async {
    final batch = db.batch();

    for (final item in kFoodItemSeedData) {
      batch.insert(
        'food_item',
        item,
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
    }

    await batch.commit(noResult: true);
  }

  Future<List<Map<String, dynamic>>> query(
    String table, {
    String? where,
    List<Object?>? whereArgs,
  }) async {
    final db = await getDatabase();

    try {
      return await db.query(table, where: where, whereArgs: whereArgs);
    } catch (e) {
      print('Database query error: $e');
      return [];
    }
  }

  Future<int> insert(String table, Map<String, Object?> values) async {
    final db = await getDatabase();

    return db.insert(
      table,
      values,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> delete(
    String table, {
    String? where,
    List<Object?>? whereArgs,
  }) async {
    final db = await getDatabase();

    return db.delete(table, where: where, whereArgs: whereArgs);
  }
}
