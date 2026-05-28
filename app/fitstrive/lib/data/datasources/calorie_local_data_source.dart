import 'package:fitstrive/core/database/fitstrive_database.dart';
import 'package:fitstrive/data/model/calorie_entry_model.dart';

abstract class CalorieLocalDataSource {
  Future<List<CalorieEntryModel>> getCalorieEntries();
  Future<void> addCalorieEntry(CalorieEntryModel entry);
  Future<void> deleteCalorieEntry(String id);
}

class CalorieLocalDataSourceImpl implements CalorieLocalDataSource {
  final AppDatabase database;
  CalorieLocalDataSourceImpl(this.database);

  @override
  Future<void> addCalorieEntry(CalorieEntryModel entry) async {
    await database.insert("calorie", entry.toJson());
  }

  @override
  Future<void> deleteCalorieEntry(String id) async {
    await database.delete('calorie', where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<List<CalorieEntryModel>> getCalorieEntries() async {
    var rows = await database.query("calorie");
    return rows.map((row) => CalorieEntryModel.fromJson(row)).toList();
  }
}
