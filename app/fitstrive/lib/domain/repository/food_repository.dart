import 'package:fitstrive/domain/entities/food.dart';
import 'package:fitstrive/domain/value_objects/food_name.dart';

abstract class FoodRepository {
  Future<List<Food>> getFoods(int? count, int? offset);
  Future<bool> addFood(Food entry);
  Future<Food> getFoodByName(FoodName name);
  Future<bool> removeFoodByName(FoodName name);
}
