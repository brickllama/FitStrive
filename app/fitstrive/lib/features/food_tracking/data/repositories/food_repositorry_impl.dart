import 'package:fitstrive/features/food_tracking/data/datasources/food_local_data_source.dart';
import 'package:fitstrive/features/food_tracking/data/repositories/food_repository.dart';
import 'package:fitstrive/features/food_tracking/domain/entities/food_entry.dart';

class FoodRepositoryImpl implements FoodRepository {
  final FoodLocalDataSource localDataSource;

  FoodRepositoryImpl(this.localDataSource);

  @override
  Future<void> addFoodEntry(FoodEntry entry) {
    // TODO: implement addFoodEntry
    throw UnimplementedError();
  }

  @override
  Future<void> deleteFoodEntry(String id) {
    // TODO: implement deleteFoodEntry
    throw UnimplementedError();
  }

  @override
  Future<List<FoodEntry>> getFoodEntries(DateTime time) {
    // TODO: implement getFoodEntries
    throw UnimplementedError();
  }

  @override
  Future<int> getTotalCaloriesForeDate(DateTime time) {
    // TODO: implement getTotalCaloriesForeDate
    throw UnimplementedError();
  }
}
