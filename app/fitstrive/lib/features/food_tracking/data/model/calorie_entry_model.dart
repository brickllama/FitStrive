import 'package:fitstrive/features/food_tracking/domain/entities/calorie_entry.dart';

class CalorieEntryModel {
  final String id;
  final int calories;
  final String date;

  CalorieEntryModel({
    required this.id,
    required this.calories,
    required this.date,
  });

  factory CalorieEntryModel.fromJson(Map<String, dynamic> json) {
    return CalorieEntryModel(
      id: json['id'],
      calories: json['calories'],
      date: json['date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'calories': calories, 'date': date};
  }

  CalorieEntry toEntity() {
    return CalorieEntry(id: id, calories: calories, date: DateTime.parse(date));
  }

  factory CalorieEntryModel.fromEntity(CalorieEntry entity) {
    return CalorieEntryModel(
      id: entity.id,
      calories: entity.calories,
      date: entity.date.toIso8601String(),
    );
  }
}
