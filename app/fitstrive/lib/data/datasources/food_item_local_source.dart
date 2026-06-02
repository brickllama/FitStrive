import 'dart:developer';

import 'package:fitstrive/core/database/fitstrive_database.dart';
import 'package:fitstrive/data/model/food_item_model.dart';

abstract class FoodItemLocalSource {
  Future<bool> addFoodEntry(FoodItemModel entry);
  Future<List<FoodItemModel>> getFoodEntries(String search);
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
  Future<List<FoodItemModel>> getFoodEntries(String search) async {
    final rows = await database.query(
      "food_item",
      where: search.trim().isEmpty ? null : "LOWER(foodname) LIKE ?",
      whereArgs: search.trim().isEmpty
          ? null
          : ['%${search.trim().toLowerCase()}%'],
    );

    log("Rows from database: ${rows.length}");

    final foods = <FoodItemModel>[];

    for (final row in rows) {
      try {
        final food = FoodItemModel.fromJson(Map<String, dynamic>.from(row));
        foods.add(food);
      } catch (e, stackTrace) {
        log(
          "Failed to parse food item row: $row",
          error: e,
          stackTrace: stackTrace,
        );
      }
    }

    log("Parsed food items: ${foods.length}");

    return foods;
  }

  @override
  Future<bool> removeFoodEntry(String entry) async {
    var res = await database.delete(
      "food_item",
      where: "id = ?",
      whereArgs: [entry],
    );
    if (res == 0) {
      return false;
    }
    return true;
  }
}
