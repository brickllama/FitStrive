import 'package:fitstrive/domain/entities/user.dart';
import 'package:fitstrive/domain/repository/user_repository.dart';
import 'package:fitstrive/domain/value_objects/user_id.dart';

class UserRepositoryImpl extends UserRepository {
  @override
  Future<User> getUser() {
    // TODO: implement getUser
    throw UnimplementedError();
  }

  @override
  Future<bool> removeUserInfo(UserID id) {
    // TODO: implement removeUserInfo
    throw UnimplementedError();
  }

  @override
  Future<bool> setUserInfo(User entry) {
    // TODO: implement setUserInfo
    throw UnimplementedError();
  }
}
