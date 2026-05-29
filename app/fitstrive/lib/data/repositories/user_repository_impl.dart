import 'package:fitstrive/data/datasources/user_local_source.dart';
import 'package:fitstrive/data/model/user_model.dart';
import 'package:fitstrive/domain/entities/user.dart';
import 'package:fitstrive/domain/repository/user_repository.dart';
import 'package:fitstrive/domain/value_objects/user_id.dart';

class UserRepositoryImpl extends UserRepository {
  UserLocalSource localSource;

  UserRepositoryImpl(this.localSource);

  @override
  Future<User> getUser() async {
    UserModel user = await localSource.getUserData();
    return user.toEntity();
  }

  @override
  Future<bool> removeUserInfo(UserID id) async {
    return await localSource.deleteUserData(id.value);
  }

  @override
  Future<bool> setUserInfo(User entry) async {
    return await localSource.setUserData(UserModel.fromEntity(entry));
  }
}
