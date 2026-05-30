import 'package:fitstrive/domain/abstractions/result.dart';
import 'package:fitstrive/domain/entities/user.dart';

abstract interface class RemoteUserDatasource {
  Future<Result<void>> delete(final String userID);

  Future<Result<User>> login(final String email, final String password);

  Future<Result<User>> register(
    final String email,
    final String username,
    final String firstName,
    final String? lastName,
    final String password,
  );
}
