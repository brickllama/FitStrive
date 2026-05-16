import 'package:fitstrive/features/food_tracking/domain/entities/food_entry.dart';

class FoodEntryModel {
  final String id;
  final String name;
  final double calories;
  final String date;

  FoodEntryModel({
    required this.id,
    required this.name,
    required this.calories,
    required this.date,
  });

  factory FoodEntryModel.fromJson(Map<String, dynamic> json) {
    return FoodEntryModel(
      id: json['id'],
      name: json['name'],
      calories: json['calories'],
      date: json['date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'calories': calories, 'date': date};
  }

  FoodEntry toEntity() {
    return FoodEntry(
      id: id,
      name: name,
      calories: calories,
      date: DateTime.parse(date),
    );
  }

  factory FoodEntryModel.fromEntity(FoodEntry entity) {
    return FoodEntryModel(
      id: entity.id,
      name: entity.name,
      calories: entity.calories,
      date: entity.date.toIso8601String(),
    );
  }
}
