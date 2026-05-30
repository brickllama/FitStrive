import 'package:fitstrive/application/abstractions/remote_user_datasource.dart';
import 'package:fitstrive/domain/abstractions/result.dart';
import 'package:fitstrive/domain/entities/user.dart';

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
  /// [firstName] - The user's first name.
  ///
  /// [lastName] - The user's last name.
  ///
  /// [password] - The user's password.
  Future<Result<User>> execute(
    final String email,
    final String firstName,
    final String? lastName,
    final String password,
  ) async {
    return await _remoteUserDatasource.register(
      email,
      firstName,
      lastName,
      password,
    );
  }
}
