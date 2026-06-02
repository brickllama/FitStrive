import 'package:fitstrive/domain/entities/food_item.dart';
import 'package:fitstrive/domain/repository/food_item_repository.dart';

final class GetFoodItemUsecase {
  final FoodItemRepository foodItemRepository;
  GetFoodItemUsecase(this.foodItemRepository);
  Future<List<FoodItem>> execute(String search) async {
    return await foodItemRepository.getFoods(search);
  }
}
