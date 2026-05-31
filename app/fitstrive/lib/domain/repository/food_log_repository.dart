import 'package:fitstrive/domain/entities/food_log.dart';

abstract class FoodLogRepository {
  Future<List<FoodLog>> getFoods(DateTime from, DateTime to);
  Future<bool> addFood(FoodLog entry);
  Future<bool> removeFoodId(String id);
}
