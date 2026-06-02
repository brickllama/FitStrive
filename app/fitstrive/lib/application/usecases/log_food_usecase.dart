import 'package:fitstrive/domain/abstractions/result.dart';
import 'package:fitstrive/domain/entities/food_log.dart';
import 'package:fitstrive/domain/entities/user.dart';
import 'package:fitstrive/domain/enums/weight_unit.dart';
import 'package:fitstrive/domain/repository/food_log_repository.dart';
import 'package:fitstrive/domain/value_objects/email.dart';
import 'package:fitstrive/domain/value_objects/food_name.dart';
import 'package:fitstrive/domain/value_objects/macronutrients.dart';
import 'package:fitstrive/domain/value_objects/password.dart';
import 'package:fitstrive/domain/value_objects/weight.dart';

class LogFoodUseCase {
  final FoodLogRepository foodLogRepository;
  LogFoodUseCase(this.foodLogRepository);

  Future<bool> execute({
    required final String foodname,
    required final double carbohydrates,
    required final double proteins,
    required final double fats,
    required final double weight,
    required final double calories,
    required final DateTime date,
  }) async {
    final food = FoodLog(
      foodname: FoodName(foodName: foodname),
      macronutrients: Macronutrients(
        carbohydrates: carbohydrates,
        proteins: proteins,
        fats: fats,
      ),
      weight: Weight(value: weight, unit: WeightUnit.grams),
      calories: calories,
      date: date,
    );
    return await foodLogRepository.addFood(food);
  }
}
