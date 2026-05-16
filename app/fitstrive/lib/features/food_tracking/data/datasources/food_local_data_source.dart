import 'package:fitstrive/features/food_tracking/data/model/food_entry_model.dart';

abstract class FoodLocalDataSource {
  Future<List<FoodEntryModel>> getFoodEntries(DateTime date);
  Future<void> addFoodEntry(FoodEntryModel entry);
  Future<void> deleteFoodEntry(String id);
}

class FoodLocalDataSourceImpl implements FoodLocalDataSource {
  FoodLocalDataSourceImpl(this.database);

  @override
  Future<List<FoodEntryModel>?> getFoodEntries(DateTime date) async {
    // SQLite/Hive/local storage code here
    return null;
  }

  @override
  Future<void> addFoodEntry(FoodEntryModel entry) async {
    // SQLite/Hive/local storage code here
  }
}
