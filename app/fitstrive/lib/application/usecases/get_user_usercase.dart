import 'package:fitstrive/domain/entities/user.dart';
import 'package:fitstrive/domain/repository/user_repository.dart';

class GetUserUsercase {
  final UserRepository userRepository;
  GetUserUsercase({required this.userRepository});

  Future<User> execute() async {
    return await userRepository.getUser();
  }
}
