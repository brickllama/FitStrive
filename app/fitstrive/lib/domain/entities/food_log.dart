import 'package:fitstrive/domain/value_objects/food_name.dart';
import 'package:fitstrive/domain/value_objects/macronutrients.dart';
import 'package:fitstrive/domain/value_objects/weight.dart';
import 'package:uuid/uuid.dart';

final class FoodLog {
  factory FoodLog({
    required final FoodName foodname,
    required final Macronutrients macronutrients,
    required final Weight weight,
    required final double calories,
    required final DateTime date,
  }) {
    final Uuid id = Uuid();
    return FoodLog._internal(
      id.v4(),
      foodname,
      macronutrients,
      weight,
      calories,
      date,
    );
  }

  FoodLog._internal(
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
