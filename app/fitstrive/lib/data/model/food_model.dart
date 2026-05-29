import 'package:fitstrive/domain/entities/food.dart';
import 'package:fitstrive/domain/enums/weight_unit.dart';
import 'package:fitstrive/domain/value_objects/food_name.dart';
import 'package:fitstrive/domain/value_objects/macronutrients.dart';
import 'package:fitstrive/domain/value_objects/weight.dart';

class FoodModel {
  final String id;
  final String foodname;
  final double calories;
  final double weight;
  final String unitSymbol;
  final double carbohydrates;
  final double protein;
  final double fats;
  final String date;

  FoodModel({
    required this.id,
    required this.foodname,
    required this.calories,
    required this.weight,
    required this.unitSymbol,
    required this.carbohydrates,
    required this.fats,
    required this.protein,
    required this.date,
  });

  factory FoodModel.fromJson(Map<String, dynamic> json) {
    return FoodModel(
      id: json['id'],
      foodname: json['foodname'],
      calories: json['calories'],
      date: json['date'],
      weight: json['weight'],
      unitSymbol: json['unitSymbol'],
      carbohydrates: json['carbohydrates'],
      protein: json['protein'],
      fats: json['fats'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'foodname': foodname,
      'calories': calories,
      'weight': weight,
      'unitSymbol': unitSymbol,
      'carbohydrates': carbohydrates,
      'protein': protein,
      'fats': fats,
      'date': date,
    };
  }

  Food toEntity() {
    FoodName foodName = FoodName(foodName: foodname);
    Macronutrients macronutrients = Macronutrients(
      carbohydrates: carbohydrates,
      proteins: protein,
      fats: fats,
    );
    Weight weight = Weight(value: this.weight, unit: WeightUnit.kilograms);
    return Food(
      id: id,
      foodname: foodName,
      macronutrients: macronutrients,
      calories: calories,
      weight: weight,
      date: DateTime.parse(date),
    );
  }

  factory FoodModel.fromEntity(Food entity) {
    return FoodModel(
      id: entity.id,
      foodname: entity.foodname.foodname,
      calories: entity.calories,
      weight: entity.weight.kilograms,
      unitSymbol: WeightUnit.kilograms.symbol,
      carbohydrates: entity.macronutrients.carbohydrates,
      fats: entity.macronutrients.fats,
      protein: entity.macronutrients.proteins,
      date: entity.date.toIso8601String(),
    );
  }
}
