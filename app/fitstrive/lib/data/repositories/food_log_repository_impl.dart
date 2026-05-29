import 'package:fitstrive/data/datasources/food_log_local_source.dart';
import 'package:fitstrive/data/model/food__item_model.dart';
import 'package:fitstrive/data/model/food_log_model.dart';
import 'package:fitstrive/domain/entities/food_log.dart';
import 'package:fitstrive/domain/repository/food_log_repository.dart';

class FoodLogRepositoryImpl extends FoodLogRepository {
  final FoodLogLocalSource localSource;

  FoodLogRepositoryImpl(this.localSource);

  @override
  Future<bool> removeFoodId(String id) async {
    return await localSource.removeFoodEntry(id);
  }

  @override
  Future<bool> addFood(FoodLog entry) async {
    return await localSource.AddFoodEntry(FoodLogModel.fromEntity(entry));
  }

  @override
  Future<List<FoodLog>> getFoods(DateTime from, DateTime to) async {
    List<FoodLogModel> foods = await localSource.getFoodEntries(from, to);
    return foods.map((foodmodel) => foodmodel.toEntity()).toList();
  }
}
