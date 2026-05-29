import 'package:fitstrive/core/database/fitstrive_database.dart';
import 'package:fitstrive/data/model/user_model.dart';

abstract class UserLocalSource {
  Future<bool> setUserData(UserModel entry);
  Future<UserModel> getUserData();
  Future<bool> deleteUserData(String id);
}

class UserLocalSourceImpl extends UserLocalSource {
  final AppDatabase database;
  UserLocalSourceImpl(this.database);
  @override
  Future<bool> deleteUserData(String id) async {
    var res = await database.delete("user", where: 'id = ?', whereArgs: [id]);
    if (res == 0) {
      return false;
    }
    return true;
  }

  @override
  Future<UserModel> getUserData() async {
    var res = await database.query("user");
    return res.map((row) => UserModel.fromJson(row)).toList()[0];
  }

  @override
  Future<bool> setUserData(UserModel entry) async {
    await deleteUserData(entry.id);
    await database.insert("user", entry.toJson());
    return true;
  }
}
