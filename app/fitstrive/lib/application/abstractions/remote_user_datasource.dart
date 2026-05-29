import 'package:fitstrive/domain/abstractions/result.dart';
import 'package:fitstrive/domain/entities/user.dart';
import 'package:fitstrive/domain/value_objects/email.dart';
import 'package:fitstrive/domain/value_objects/name.dart';
import 'package:fitstrive/domain/value_objects/password.dart';

abstract interface class RemoteUserDatasource {
  Future<Result<User>> register(
    final Email email,
    final Name name,
    final Password password,
  );
}
