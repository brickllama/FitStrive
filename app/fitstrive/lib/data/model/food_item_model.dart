import 'package:fitstrive/domain/entities/food_item.dart';
import 'package:fitstrive/domain/entities/food_log.dart';
import 'package:fitstrive/domain/enums/weight_unit.dart';
import 'package:fitstrive/domain/value_objects/food_name.dart';
import 'package:fitstrive/domain/value_objects/macronutrients.dart';
import 'package:fitstrive/domain/value_objects/weight.dart';

class FoodItemModel {
  final String id;
  final String foodname;
  final double calories;
  final double weight;
  final String unitSymbol;
  final double carbohydrates;
  final double protein;
  final double fats;

  FoodItemModel({
    required this.id,
    required this.foodname,
    required this.calories,
    required this.weight,
    required this.unitSymbol,
    required this.carbohydrates,
    required this.fats,
    required this.protein,
  });

  factory FoodItemModel.fromJson(Map<String, dynamic> json) {
    return FoodItemModel(
      id: json['id'].toString(),
      foodname: json['foodname'] as String,
      calories: (json['calories'] as num).toDouble(),
      weight: (json['weight'] as num).toDouble(),
      unitSymbol: json['unitSymbol'] as String,
      carbohydrates: (json['carbohydrates'] as num).toDouble(),
      protein: (json['protein'] as num).toDouble(),
      fats: (json['fats'] as num).toDouble(),
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
    };
  }

  FoodItem toEntity() {
    FoodName foodName = FoodName(foodName: foodname);
    Macronutrients macronutrients = Macronutrients(
      carbohydrates: carbohydrates,
      proteins: protein,
      fats: fats,
    );
    Weight weight = Weight(value: this.weight, unit: WeightUnit.kilograms);
    return FoodItem(
      id: id,
      foodname: foodName,
      macronutrients: macronutrients,
      calories: calories,
      weight: weight,
    );
  }

  factory FoodItemModel.fromEntity(FoodItem entity) {
    return FoodItemModel(
      id: entity.id,
      foodname: entity.foodname.foodname,
      calories: entity.calories,
      weight: entity.weight.kilograms,
      unitSymbol: WeightUnit.kilograms.symbol,
      carbohydrates: entity.macronutrients.carbohydrates,
      fats: entity.macronutrients.fats,
      protein: entity.macronutrients.proteins,
    );
  }
}
