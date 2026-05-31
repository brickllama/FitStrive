import 'dart:developer';
import 'package:fitstrive/domain/entities/user_health.dart';
import 'package:fitstrive/domain/repository/user_health_repository.dart';

final class RemoveUserHealthUsecase {
  final UserHealthRepository _userHealthRepository;
  RemoveUserHealthUsecase(UserHealthRepository userHealthRepository)
    : _userHealthRepository = userHealthRepository;

  Future<bool> execute({required final UserHealth userHealth}) async {
    log('Attempting to log user health');
    return await _userHealthRepository.removeUserHealth(userHealth);
  }
}
