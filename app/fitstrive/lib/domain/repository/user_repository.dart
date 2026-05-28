import 'package:fitstrive/domain/entities/user.dart';
import 'package:fitstrive/domain/value_objects/user_id.dart';

abstract class UserRepository {
  Future<bool> setUserInfo(User entry);
  Future<bool> removeUserInfo(UserID id);
  Future<User> getUser();
}
