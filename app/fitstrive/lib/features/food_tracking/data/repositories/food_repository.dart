import 'package:fitstrive/features/food_tracking/domain/entities/food_entry.dart';

abstract class FoodRepository {
  Future<List<FoodEntry>> getFoodEntries(DateTime time);

  Future<void> addFoodEntry(FoodEntry entry);

  Future<void> deleteFoodEntry(String id);

  Future<int> getTotalCaloriesForeDate(DateTime time);
}
