import 'package:fitstrive/core/database/fitstrive_database.dart';
import 'package:fitstrive/features/food_tracking/data/model/food_entry_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

abstract class FoodLocalDataSource {
  Future<List<FoodEntryModel>> getFoodEntries(DateTime date);
  Future<void> addFoodEntry(FoodEntryModel entry);
  Future<void> deleteFoodEntry(String id);
}

class FoodLocalDataSourceImpl implements FoodLocalDataSource {
  final AppDatabase database;
  FoodLocalDataSourceImpl(this.database);

  @override
  Future<List<FoodEntryModel>> getFoodEntries(DateTime date) async {
    var rows = await database.query("food");
    return rows.map((row) => FoodEntryModel.fromJson(row)).toList();
  }

  @override
  Future<void> addFoodEntry(FoodEntryModel entry) async {
    await database.insert("food", entry.toJson());
  }

  @override
  Future<void> deleteFoodEntry(String id) async {
    await database.delete('food', where: 'id = ?', whereArgs: [id]);
  }
}
