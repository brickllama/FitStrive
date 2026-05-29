import 'package:fitstrive/domain/entities/food_item.dart';
import 'package:fitstrive/domain/entities/food_log.dart';

abstract class FoodItemRepository {
  Future<List<FoodItem>> getFoods();
  Future<bool> addFood(FoodItem entry);
  Future<bool> removeFoodId(String id);
}
