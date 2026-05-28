import 'package:fitstrive/domain/entities/food.dart';
import 'package:fitstrive/domain/repository/food_repository.dart';
import 'package:fitstrive/domain/value_objects/food_name.dart';

class FoodRepositoryImpl extends FoodRepository {
  @override
  Future<bool> addFood(Food entry) {
    // TODO: implement addFood
    throw UnimplementedError();
  }

  @override
  Future<Food> getFoodByName(FoodName name) {
    // TODO: implement getFoodByName
    throw UnimplementedError();
  }

  @override
  Future<List<Food>> getFoods(int? count, int? offset) {
    // TODO: implement getFoods
    throw UnimplementedError();
  }

  @override
  Future<bool> removeFoodByName(FoodName name) {
    // TODO: implement removeFoodByName
    throw UnimplementedError();
  }
}
