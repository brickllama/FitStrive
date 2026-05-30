import '../abstractions/remote_user_datasource.dart';
import 'package:fitstrive/domain/abstractions/result.dart';
import 'package:fitstrive/domain/entities/user.dart';
import 'package:fitstrive/domain/value_objects/email.dart';
import 'package:fitstrive/domain/value_objects/name.dart';
import 'package:fitstrive/domain/value_objects/password.dart';
import 'package:fitstrive/domain/value_objects/username.dart';

final class UserRegistrationUseCase {
  final RemoteUserDatasource _remoteUserDatasource;

  UserRegistrationUseCase({
    required final RemoteUserDatasource remoteUserDatasource,
  }) : _remoteUserDatasource = remoteUserDatasource;

  /// Forwards the user's information to a [RemoteUserDatasource]
  /// that will process the request.
  ///
  /// [email] - The user's email.
  ///
  /// [username] - The user's username.
  ///
  /// [firstName] - The user's first name.
  ///
  /// [lastName] - The user's last name.
  ///
  /// [password] - The user's password.
  Future<Result<User>> execute(
    final Email email,
    final Username username,
    final Name name,
    final Password password,
  ) async {
    return await _remoteUserDatasource.register(
      email,
      username,
      name,
      password,
    );
  }
}
