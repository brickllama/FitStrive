import 'package:fitstrive/domain/entities/food_item.dart';
import 'package:fitstrive/domain/repository/food_item_repository.dart';

final class RemoveFoodItemUsecase {
  final FoodItemRepository foodItemRepository;
  RemoveFoodItemUsecase(this.foodItemRepository);

  Future<bool> execute(FoodItem fooditem) async {
    return await foodItemRepository.removeFoodId(fooditem.id);
  }
}
