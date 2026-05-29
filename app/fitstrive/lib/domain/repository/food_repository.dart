import 'package:fitstrive/domain/entities/food.dart';
import 'package:fitstrive/domain/value_objects/food_name.dart';

abstract class FoodRepository {
  Future<List<Food>> getFoods(DateTime from, DateTime to);
  Future<bool> addFood(Food entry);
  Future<bool> removeFoodId(String id);
}
