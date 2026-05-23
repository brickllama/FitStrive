import 'package:fitstrive/features/food_tracking/domain/entities/weight_entry.dart';

class WeightEntryModel {
  final String id;
  final double weight;
  final String date;

  WeightEntryModel({
    required this.id,
    required this.weight,
    required this.date,
  });

  factory WeightEntryModel.fromJson(Map<String, dynamic> json) {
    return WeightEntryModel(
      id: json['id'],
      weight: json['weight'],
      date: json['date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'weight': weight, 'calories': weight, 'date': date};
  }

  WeightEntry toEntity() {
    return WeightEntry(id: id, weight: weight, date: DateTime.parse(date));
  }

  factory WeightEntryModel.fromEntity(WeightEntry entity) {
    return WeightEntryModel(
      id: entity.id,
      weight: entity.weight,
      date: entity.date.toIso8601String(),
    );
  }
}
