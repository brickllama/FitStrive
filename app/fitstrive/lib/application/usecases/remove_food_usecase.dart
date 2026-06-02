import 'package:fitstrive/domain/repository/food_log_repository.dart';

final class RemoveFoodUsecase {
  final FoodLogRepository _foodLogRepository;
  RemoveFoodUsecase(final FoodLogRepository foodLogRepository)
    : _foodLogRepository = foodLogRepository;

  Future<bool> execute(final String id) async {
    return await _foodLogRepository.removeFoodId(id);
  }
}
