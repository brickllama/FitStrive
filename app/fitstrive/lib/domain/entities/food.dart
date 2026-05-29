import 'package:fitstrive/domain/value_objects/food_name.dart';
import 'package:fitstrive/domain/value_objects/macronutrients.dart';
import 'package:fitstrive/domain/value_objects/weight.dart';

final class Food {
  factory Food({
    required final String id,
    required final FoodName foodname,
    required final Macronutrients macronutrients,
    required final Weight weight,
    required final double calories,
    required final DateTime date,
  }) {
    return Food._internal(id, foodname, macronutrients, weight, calories, date);
  }

  Food._internal(
    this.id,
    this.foodname,
    this.macronutrients,
    this.weight,
    this.calories,
    this.date,
  );
  final String id;
  final FoodName foodname;
  final Macronutrients macronutrients;
  final Weight weight;
  final double calories;
  final DateTime date;
}
