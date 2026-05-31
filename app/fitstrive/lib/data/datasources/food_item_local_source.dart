import 'package:fitstrive/core/database/fitstrive_database.dart';
import 'package:fitstrive/data/model/food_item_model.dart';

abstract class FoodItemLocalSource {
  Future<bool> addFoodEntry(FoodItemModel entry);
  Future<List<FoodItemModel>> getFoodEntries();
  Future<bool> removeFoodEntry(String id);
}

class FoodItemLocalSourceImpl extends FoodItemLocalSource {
  final AppDatabase database;
  FoodItemLocalSourceImpl(this.database);
  @override
  Future<bool> addFoodEntry(FoodItemModel entry) async {
    if (await database.insert("food_item", entry.toJson()) != 0) {
      return true;
    }
    return false;
  }

  @override
  Future<List<FoodItemModel>> getFoodEntries() async {
    var res = await database.query("food_log");
    return res.map((row) => FoodItemModel.fromJson(row)).toList();
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
