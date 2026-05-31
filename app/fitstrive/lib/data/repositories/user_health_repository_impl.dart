import 'package:fitstrive/data/datasources/user_health_local_source.dart';
import 'package:fitstrive/data/model/user_health_model.dart';
import 'package:fitstrive/domain/entities/user_health.dart';
import 'package:fitstrive/domain/repository/user_health_repository.dart';

class UserHealthRepositoryImpl extends UserHealthRepository {
  UserHealthLocalSource localSource;
  UserHealthRepositoryImpl(this.localSource);

  Future<List<UserHealth>> getUserHealth(DateTime from, DateTime to) async {
    List<UserHealthModel> rows = await localSource.getUserHealth(from, to);
    return rows.map((userhealthmodel) => userhealthmodel.toEntity()).toList();
  }

  @override
  Future<bool> addUserHealth(UserHealth entry) async {
    return localSource.addUserHealth(UserHealthModel.fromEntity(entry));
  }

  @override
  Future<bool> removeUserHealth(UserHealth entry) async {
    return await localSource.deleteUserHealth(
      UserHealthModel.fromEntity(entry),
    );
  }
}
