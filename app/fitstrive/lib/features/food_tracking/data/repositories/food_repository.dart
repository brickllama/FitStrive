import 'package:fitstrive/features/food_tracking/data/model/food_entry_model.dart';
import 'package:fitstrive/features/food_tracking/domain/entities/food_entry.dart';

import 'package:fitstrive/features/food_tracking/data/datasources/food_local_data_source.dart';
import 'package:fitstrive/features/food_tracking/data/repositories/food_repository.dart';
import 'package:fitstrive/features/food_tracking/domain/entities/food_entry.dart';

abstract class FoodRepository {
  Future<List<FoodEntry>> getFoodEntries(DateTime time);

  Future<void> addFoodEntry(FoodEntry entry);

  Future<void> deleteFoodEntry(String id);

  Future<int> getTotalCaloriesForeDate(DateTime time);
}

class FoodRepositoryImpl implements FoodRepository {
  final FoodLocalDataSource localDataSource;

  FoodRepositoryImpl(this.localDataSource);

  @override
  Future<void> addFoodEntry(FoodEntry entry) {
    return localDataSource.addFoodEntry(FoodEntryModel.fromEntity(entry));
  }

  @override
  Future<void> deleteFoodEntry(String id) {
    return localDataSource.deleteFoodEntry(id);
  }

  @override
  Future<List<FoodEntry>> getFoodEntries(DateTime time) async {
    List<FoodEntryModel> foods = await localDataSource.getFoodEntries(time);
    return foods.map((foodModel) => foodModel.toEntity()).toList();
  }

  @override
  Future<int> getTotalCaloriesForeDate(DateTime time) {
    // TODO: implement getTotalCaloriesForeDate
    throw UnimplementedError();
  }
}
