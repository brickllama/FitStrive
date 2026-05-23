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
