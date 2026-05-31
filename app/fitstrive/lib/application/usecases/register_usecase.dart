import 'dart:developer';

import 'package:fitstrive/domain/abstractions/result.dart';
import 'package:fitstrive/domain/entities/user.dart';
import 'package:fitstrive/domain/repository/user_repository.dart';
import 'package:fitstrive/domain/value_objects/email.dart';
import 'package:fitstrive/domain/value_objects/name.dart';
import 'package:fitstrive/domain/value_objects/password.dart';
import 'package:fitstrive/domain/value_objects/username.dart';

class RegisterUseCase {
  final UserRepository userRepository;
  RegisterUseCase(this.userRepository);

  Future<Result<User>> execute({
    required final Email email,
    required final Username username,
    required final Name name,
    required final Password password,
  }) async {
    log("Attempting to register account");
    return await userRepository.register(
      email: email,
      password: password,
      name: name,
      username: username,
    );
  }
}
