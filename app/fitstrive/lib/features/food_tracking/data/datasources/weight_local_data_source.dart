import 'package:fitstrive/core/database/fitstrive_database.dart';
import 'package:fitstrive/features/food_tracking/data/model/weight_entry_model.dart';

abstract class WeightLocalDataSource {
  Future<List<WeightEntryModel>> getWeightEntries();
  Future<void> addWeightEntry(WeightEntryModel entry);
  Future<void> deleteWeightEntry(String id);
}

class WeightLocalDataSourceImpl implements WeightLocalDataSource {
  final AppDatabase database;
  WeightLocalDataSourceImpl(this.database);

  @override
  Future<void> addWeightEntry(WeightEntryModel entry) async {
    await database.insert("weight", entry.toJson());
  }

  @override
  Future<void> deleteWeightEntry(String id) async {
    await database.delete('weight', where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<List<WeightEntryModel>> getWeightEntries() async {
    var rows = await database.query("weight");
    return rows.map((row) => WeightEntryModel.fromJson(row)).toList();
  }
}
