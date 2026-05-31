import 'package:fitstrive/domain/repository/food_log_repository.dart';
import 'package:fitstrive/domain/entities/food_log.dart';

final class GetFoodsUsecase {
  final FoodLogRepository _foodLogRepository;
  GetFoodsUsecase(final FoodLogRepository foodLogRepository)
    : _foodLogRepository = foodLogRepository;

  Future<List<FoodLog>> execute(DateTime from, DateTime to) async {
    return _foodLogRepository.getFoods(from, to);
  }
}
