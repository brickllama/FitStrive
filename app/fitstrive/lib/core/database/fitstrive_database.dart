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
CREATE TABLE user (
  id TEXT PRIMARY KEY,
  email TEXT NOT NULL,
  firstName TEXT NOT NULL,
  lastName TEXT
)
''');
        await db.execute('''
CREATE TABLE food_log (
  id TEXT PRIMARY KEY AUTOINCREMENT,
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
CREATE TABLE food_item (
  id TEXT PRIMARY KEY AUTOINCREMENT,
  foodname TEXT NOT NULL,
  calories REAL NOT NULL,
  weight REAL NOT NULL,
  unitSymbol TEXT NOT NULL,
  carbohydrates REAL NOT NULL,
  protein REAL NOT NULL,
  fats REAL NOT NULL,
)
''');
        await db.execute('''
CREATE TABLE health (
  id TEXT PRIMARY KEY AUTOINCREMENT,
  height REAL NOT NULL,
  weight REAL NOT NULL,
  date TEXT NOT NULL
)
''');
      },
    );
  }

  Future<List<Map<String, dynamic>>> query(
    String table, {
    String? where,
    List<Object?>? whereArgs,
  }) async {
    try {
      var result = await database!.query(
        table,
        where: where,
        whereArgs: whereArgs,
      );
      return result;
    } catch (E) {
      return List.empty();
    }
  }

  Future<int> insert(String table, Map<String, Object?> values) async {
    return database!.insert(
      table,
      values,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> delete(String table, {String? where, List<Object?>? whereArgs}) {
    return database!.delete(table, where: where, whereArgs: whereArgs);
  }
}
