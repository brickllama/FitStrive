import 'package:fitstrive/domain/abstractions/result.dart';
import 'package:fitstrive/domain/entities/user.dart';
import 'package:fitstrive/domain/value_objects/email.dart';
import 'package:fitstrive/domain/value_objects/name.dart';
import 'package:fitstrive/domain/value_objects/password.dart';
import 'package:fitstrive/domain/value_objects/user_id.dart';
import 'package:fitstrive/domain/value_objects/username.dart';

abstract class UserRepository {
  Future<bool> setUserInfo(User entry);
  Future<bool> removeUserInfo(UserID id);
  Future<User> getUser();
  Future<Result<User>> login({
    required Email email,
    required Password password,
  });
  Future<Result<User>> register({
    required final Email email,
    required final Username username,
    required final Name name,
    required final Password password,
  });
}
