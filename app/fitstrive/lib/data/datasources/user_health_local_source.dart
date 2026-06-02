import 'package:fitstrive/core/database/fitstrive_database.dart';
import 'package:fitstrive/data/model/user_health_model.dart';

abstract class UserHealthLocalSource {
  Future<bool> addUserHealth(UserHealthModel entry);
  Future<List<UserHealthModel>> getUserHealth(DateTime from, DateTime to);
  Future<bool> deleteUserHealth(UserHealthModel entry);
}

class UserHealthLocalSourceImpl extends UserHealthLocalSource {
  final AppDatabase database;
  UserHealthLocalSourceImpl(this.database);

  @override
  Future<bool> addUserHealth(UserHealthModel entry) async {
    if (await database.insert("health", entry.toJson()) != 0) {
      return true;
    }
    return false;
  }

  @override
  Future<bool> deleteUserHealth(UserHealthModel entry) async {
    var res = await database.delete(
      "health",
      where: "id = ?",
      whereArgs: [entry.id],
    );
    if (res == 0) {
      return false;
    }
    return true;
  }

  @override
  Future<List<UserHealthModel>> getUserHealth(
    DateTime from,
    DateTime to,
  ) async {
    var res = await database.query(
      "health",
      where: 'date => ? and date <= ?',
      whereArgs: [from.toIso8601String(), to.toIso8601String()],
    );
    return res.map((row) => UserHealthModel.fromJson(row)).toList();
  }
}
