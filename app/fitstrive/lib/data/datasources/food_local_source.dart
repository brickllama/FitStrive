import 'package:fitstrive/core/database/fitstrive_database.dart';
import 'package:fitstrive/data/model/food_model.dart';

abstract class FoodLocalSource {
  Future<bool> AddFoodEntry(FoodModel entry);
  Future<List<FoodModel>> getFoodEntries(DateTime from, DateTime to);
  Future<bool> removeFoodEntry(String id);
}

class FoodLocalSourceImpl extends FoodLocalSource {
  final AppDatabase database;
  FoodLocalSourceImpl(this.database);
  @override
  Future<bool> AddFoodEntry(FoodModel entry) async {
    if (await database.insert("food", entry.toJson()) != 0) {
      return true;
    }
    return false;
  }

  @override
  Future<List<FoodModel>> getFoodEntries(DateTime from, DateTime to) async {
    var res = await database.query(
      "food",
      where: 'date => ? and date <= ?',
      whereArgs: [from.toIso8601String(), to.toIso8601String()],
    );
    return res.map((row) => FoodModel.fromJson(row)).toList();
  }

  @override
  Future<bool> removeFoodEntry(String entry) async {
    var res = await database.delete(
      "food",
      where: "id = ?",
      whereArgs: [entry],
    );
    if (res == 0) {
      return false;
    }
    return true;
  }
}
