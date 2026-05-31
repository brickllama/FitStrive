import '../abstractions/remote_user_datasource.dart';
import 'package:fitstrive/domain/abstractions/result.dart';
import 'package:fitstrive/domain/entities/user.dart';
import 'package:fitstrive/domain/value_objects/email.dart';
import 'package:fitstrive/domain/value_objects/password.dart';

final class UserLoginUseCase {
  final RemoteUserDatasource _remoteUserDatasource;

  UserLoginUseCase({required final RemoteUserDatasource remoteUserDatasource})
    : _remoteUserDatasource = remoteUserDatasource;

  Future<Result<User>> execute(
    final Email email,
    final Password password,
  ) async {
    return await _remoteUserDatasource.login(email, password);
  }
}
