import 'package:fitstrive/features/food_tracking/data/model/calorie_entry_model.dart';
import 'package:fitstrive/features/food_tracking/domain/entities/calorie_entry.dart';

import 'package:fitstrive/features/food_tracking/data/datasources/calorie_local_data_source.dart';
import 'package:fitstrive/features/food_tracking/data/repositories/calorie_repository.dart';
import 'package:fitstrive/features/food_tracking/domain/entities/calorie_entry.dart';

abstract class CalorieRepository {
  Future<List<CalorieEntry>> getCalorieEntries(DateTime time);

  Future<void> addCalorieEntry(CalorieEntry entry);

  Future<void> deleteCalorieEntry(String id);

  Future<int> getTotalCaloriesForeDate(DateTime time);
}

class CalorieRepositoryImpl implements CalorieRepository {
  final CalorieLocalDataSource localDataSource;

  CalorieRepositoryImpl(this.localDataSource);

  @override
  Future<void> addCalorieEntry(CalorieEntry entry) {
    return localDataSource.addCalorieEntry(CalorieEntryModel.fromEntity(entry));
  }

  @override
  Future<void> deleteCalorieEntry(String id) {
    return localDataSource.deleteCalorieEntry(id);
  }

  @override
  Future<List<CalorieEntry>> getCalorieEntries(DateTime time) async {
    List<CalorieEntryModel> calories = await localDataSource
        .getCalorieEntries();
    return calories.map((calorieModel) => calorieModel.toEntity()).toList();
  }

  @override
  Future<int> getTotalCaloriesForeDate(DateTime time) {
    // TODO: implement getTotalCaloriesForeDate
    throw UnimplementedError();
  }
}
