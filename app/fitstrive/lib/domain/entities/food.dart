import 'package:fitstrive/domain/value_objects/food_name.dart';
import 'package:fitstrive/domain/value_objects/macronutrients.dart';
import 'package:fitstrive/domain/value_objects/weight.dart';

final class Food {
  factory Food({
    required final FoodName foodname,
    required final Macronutrients macronutrients,
    required final Weight weight,
  }) {
    return Food._internal(foodname, macronutrients, weight);
  }

  Food._internal(this.foodname, this.macronutrients, this.weight);

  final FoodName foodname;
  final Macronutrients macronutrients;
  final Weight weight;
}
