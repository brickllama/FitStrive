import 'package:fitstrive/application/abstractions/remote_user_datasource.dart';
import 'package:fitstrive/data/datasources/user_local_source.dart';
import 'package:fitstrive/data/model/user_model.dart';
import 'package:fitstrive/domain/abstractions/result.dart';
import 'package:fitstrive/domain/entities/user.dart';
import 'package:fitstrive/domain/repository/user_repository.dart';
import 'package:fitstrive/domain/value_objects/email.dart';
import 'package:fitstrive/domain/value_objects/password.dart';
import 'package:fitstrive/domain/value_objects/user_id.dart';

class UserRepositoryImpl extends UserRepository {
  UserLocalSource localSource;
  RemoteUserDatasource remoteSource;

  UserRepositoryImpl({required this.localSource, required this.remoteSource});

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

  @override
  Future<Result<User>> login({
    required Email email,
    required Password password,
  }) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<Result<User>> register({
    required Email email,
    required Password password,
  }) {
    // TODO: implement register
    throw UnimplementedError();
  }
}
