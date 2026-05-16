import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  Database? database;

  Future<Database> getDatabase() async {
    database ??= (await create()) as Database?;

    return database!;
  }

  static Future<Database> create() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'fitstrive.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
      CREATE TABLE foods (id TEXT PRIMARY KEY, name TEXT NOT NULL, calories REAL NOT NULL, date TEXT NOT NULL)
      ''');
      },
    );
  }

  Future<void> insertFoodEntry(Map<String, dynamic> entry) async {}

  Future<List<Map<String, dynamic>>> getFoodEntries(DateTime date) async {
    return [];
  }

  Future<void> deleteFoodEntry(String id) async {}
}
