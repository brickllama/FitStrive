import 'package:fitstrive/data/datasources/food_local_source.dart';
import 'package:fitstrive/data/model/food_model.dart';
import 'package:fitstrive/domain/entities/food.dart';
import 'package:fitstrive/domain/repository/food_repository.dart';
import 'package:fitstrive/domain/value_objects/food_name.dart';

class FoodRepositoryImpl extends FoodRepository {
  final FoodLocalSource localSource;

  FoodRepositoryImpl(this.localSource);

  @override
  Future<bool> removeFoodId(String id) async {
    return await localSource.removeFoodEntry(id);
  }

  @override
  Future<bool> addFood(Food entry) async {
    return await localSource.AddFoodEntry(FoodModel.fromEntity(entry));
  }

  @override
  Future<List<Food>> getFoods(DateTime from, DateTime to) async {
    List<FoodModel> foods = await localSource.getFoodEntries(from, to);
    return foods.map((foodmodel) => foodmodel.toEntity()).toList();
  }
}
