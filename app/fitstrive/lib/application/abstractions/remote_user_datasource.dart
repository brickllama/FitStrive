import 'package:fitstrive/domain/abstractions/result.dart';
import 'package:fitstrive/domain/entities/user.dart';
import 'package:fitstrive/domain/value_objects/email.dart';
import 'package:fitstrive/domain/value_objects/name.dart';
import 'package:fitstrive/domain/value_objects/password.dart';
import 'package:fitstrive/domain/value_objects/user_id.dart';

abstract interface class RemoteUserDatasource {
  Future<Result<void>> delete(final UserID userID);

  Future<Result<User>> login(final Email email, final Password password);

  Future<Result<User>> register(
    final Email email,
    final Name name,
    final Password password,
  );
}
