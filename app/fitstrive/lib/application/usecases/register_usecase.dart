import 'package:fitstrive/domain/abstractions/result.dart';
import 'package:fitstrive/domain/entities/user.dart';
import 'package:fitstrive/domain/repository/user_repository.dart';
import 'package:fitstrive/domain/value_objects/email.dart';
import 'package:fitstrive/domain/value_objects/password.dart';

class RegisterUseCase {
  final UserRepository userRepository;
  RegisterUseCase(this.userRepository);

  Future<Result<User>> execute({
    required final String email,
    required final String password,
  }) async {
    final emailValue = Email(value: email);
    final passwordValue = Password(value: password);
    return userRepository.register(
      email: Email(value: email),
      password: Password(value: password),
    );
  }
}
