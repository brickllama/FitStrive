import 'package:fitstrive/data/datasources/food_item_local_source.dart';
import 'package:fitstrive/data/model/food_item_model.dart';
import 'package:fitstrive/domain/entities/food_item.dart';
import 'package:fitstrive/domain/entities/food_log.dart';
import 'package:fitstrive/domain/repository/food_item_repository.dart';
import 'package:fitstrive/domain/repository/food_log_repository.dart';

class FoodItemRepositoryImpl extends FoodItemRepository {
  final FoodItemLocalSource localSource;

  FoodItemRepositoryImpl(this.localSource);

  @override
  Future<bool> removeFoodId(String id) async {
    return await localSource.removeFoodEntry(id);
  }

  @override
  Future<bool> addFood(FoodItem entry) async {
    return await localSource.addFoodEntry(FoodItemModel.fromEntity(entry));
  }

  @override
  Future<List<FoodItem>> getFoods() async {
    List<FoodItemModel> foods = await localSource.getFoodEntries();
    return foods.map((foodmodel) => foodmodel.toEntity()).toList();
  }
}
