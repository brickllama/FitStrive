import 'package:fitstrive/domain/entities/user.dart';
import 'package:fitstrive/domain/repository/user_repository.dart';

class SetUserUsercase {
  final UserRepository userRepository;
  SetUserUsercase({required this.userRepository});
  Future<bool> execute(User user) async {
    return await userRepository.setUserInfo(user);
  }
}
