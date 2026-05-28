import 'package:fitstrive/domain/entities/user_health.dart';

abstract class UserHealthRepository {
  Future<List<UserHealth>> getUserHealth(DateTime? from, DateTime? to);
  Future<bool> addUserHealth(UserHealth entry);
  Future<bool> removeUserHealth(UserHealth entry);
}
