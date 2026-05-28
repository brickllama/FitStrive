import 'package:fitstrive/domain/entities/user_health.dart';
import 'package:fitstrive/domain/repository/user_health_repository.dart';

class UserHealthRepositoryImpl extends UserHealthRepository {
  Future<List<UserHealth>> getUserHealth(DateTime? from, DateTime? to) {
    // TODO: implement addUserHealth
    throw UnimplementedError();
  }

  @override
  Future<bool> addUserHealth(UserHealth entry) {
    // TODO: implement addUserHealth
    throw UnimplementedError();
  }

  @override
  Future<bool> removeUserHealth(UserHealth entry) {
    // TODO: implement removeUserHealth
    throw UnimplementedError();
  }
}
