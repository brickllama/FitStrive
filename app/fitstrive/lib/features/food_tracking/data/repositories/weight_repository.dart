import 'package:fitstrive/features/food_tracking/data/model/weight_entry_model.dart';
import 'package:fitstrive/features/food_tracking/domain/entities/weight_entry.dart';

import 'package:fitstrive/features/food_tracking/data/datasources/weight_local_data_source.dart';

abstract class WeightRepository {
  Future<List<WeightEntry>> getWeightEntries(DateTime time);

  Future<void> addWeightEntry(WeightEntry entry);

  Future<void> deleteWeightEntry(String id);

  Future<int> getTotalWeightForeDate(DateTime time);
}

class WeightRepositoryImpl implements WeightRepository {
  final WeightLocalDataSource localDataSource;

  WeightRepositoryImpl(this.localDataSource);

  @override
  Future<void> addWeightEntry(WeightEntry entry) {
    return localDataSource.addWeightEntry(WeightEntryModel.fromEntity(entry));
  }

  @override
  Future<void> deleteWeightEntry(String id) {
    return localDataSource.deleteWeightEntry(id);
  }

  @override
  Future<List<WeightEntry>> getWeightEntries(DateTime time) async {
    List<WeightEntryModel> Weights = await localDataSource.getWeightEntries();
    return Weights.map((WeightModel) => WeightModel.toEntity()).toList();
  }

  @override
  Future<int> getTotalWeightForeDate(DateTime time) {
    // TODO: implement getTotalCaloriesForeDate
    throw UnimplementedError();
  }
}
