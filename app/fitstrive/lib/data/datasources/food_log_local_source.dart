import 'package:fitstrive/core/database/fitstrive_database.dart';
import 'package:fitstrive/data/model/food_log_model.dart';

abstract class FoodLogLocalSource {
  Future<bool> AddFoodEntry(FoodLogModel entry);
  Future<List<FoodLogModel>> getFoodEntries(DateTime from, DateTime to);
  Future<bool> removeFoodEntry(String id);
}

class FoodLogLocalSourceImpl extends FoodLogLocalSource {
  final AppDatabase database;
  FoodLogLocalSourceImpl(this.database);
  @override
  Future<bool> AddFoodEntry(FoodLogModel entry) async {
    if (await database.insert("food_log", entry.toJson()) != 0) {
      return true;
    }
    return false;
  }

  @override
  Future<List<FoodLogModel>> getFoodEntries(DateTime from, DateTime to) async {
    final rows = await database.query(
      'food_log',
      where: 'date >= ? AND date < ?',
      whereArgs: [from.toIso8601String(), to.toIso8601String()],
    );

    return rows
        .map((row) => FoodLogModel.fromJson(Map<String, dynamic>.from(row)))
        .toList();
  }

  @override
  Future<bool> removeFoodEntry(String entry) async {
    var res = await database.delete(
      "food_log",
      where: "id = ?",
      whereArgs: [entry],
    );
    if (res == 0) {
      return false;
    }
    return true;
  }
}
