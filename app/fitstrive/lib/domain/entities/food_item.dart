import 'package:fitstrive/domain/value_objects/food_name.dart';
import 'package:fitstrive/domain/value_objects/macronutrients.dart';
import 'package:fitstrive/domain/value_objects/weight.dart';

final class FoodItem {
  factory FoodItem({
    required final String id,
    required final FoodName foodname,
    required final Macronutrients macronutrients,
    required final Weight weight,
    required final double calories,
  }) {
    return FoodItem._internal(id, foodname, macronutrients, weight, calories);
  }

  FoodItem._internal(
    this.id,
    this.foodname,
    this.macronutrients,
    this.weight,
    this.calories,
  );
  final String id;
  final FoodName foodname;
  final Macronutrients macronutrients;
  final Weight weight;
  final double calories;
}
