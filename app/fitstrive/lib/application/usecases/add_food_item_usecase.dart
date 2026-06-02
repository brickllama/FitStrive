import 'package:fitstrive/domain/entities/food_item.dart';
import 'package:fitstrive/domain/repository/food_item_repository.dart';

final class AddFoodItemUsecase {
  FoodItemRepository foodItemRepository;
  AddFoodItemUsecase(this.foodItemRepository);

  Future<bool> execute({required final FoodItem foodItem}) async {
    return await foodItemRepository.addFood(foodItem);
  }
}
