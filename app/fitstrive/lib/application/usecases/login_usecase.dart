import 'package:fitstrive/data/repositories/user_repository_impl.dart';
import 'package:fitstrive/domain/abstractions/result.dart';
import 'package:fitstrive/domain/entities/user.dart';
import 'package:fitstrive/domain/repository/user_repository.dart';
import 'package:fitstrive/domain/value_objects/email.dart';
import 'package:fitstrive/domain/value_objects/password.dart';

class LoginUseCase {
  final UserRepository userRepository;
  LoginUseCase(this.userRepository);

  Future<Result<User>> execute({
    required final Email email,
    required final Password password,
  }) async {
    return userRepository.login(email: email, password: password);
  }
}
