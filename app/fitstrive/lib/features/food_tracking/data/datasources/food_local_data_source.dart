import 'package:fitstrive/features/food_tracking/data/model/food_entry_model.dart';

abstract class FoodLocalDataSource {
  Future<List<FoodEntryModel>> getFoodEntries(DateTime date);
  Future<void> addFoodEntry(FoodEntryModel entry);
  Future<void> deleteFoodEntry(String id);
}
