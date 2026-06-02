import 'package:fitstrive/domain/entities/user_health.dart';
import 'package:fitstrive/domain/enums/height_unit.dart';
import 'package:fitstrive/domain/enums/weight_unit.dart';
import 'package:fitstrive/domain/value_objects/height.dart';
import 'package:fitstrive/domain/value_objects/weight.dart';

class UserHealthModel {
  final String id;
  final double height;
  final double weight;
  final String date;

  UserHealthModel({
    required this.id,
    required this.height,
    required this.weight,
    required this.date,
  });

  factory UserHealthModel.fromJson(Map<String, dynamic> json) {
    return UserHealthModel(
      id: json['id'],
      height: json['height'],
      weight: json['weight'],
      date: json['date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'height': height, 'weight': weight, 'date': date};
  }

  UserHealth toEntity() {
    return UserHealth(
      id: id,
      height: Height(value: height, unit: HeightUnit.meters),
      weight: Weight(value: weight, unit: WeightUnit.kilograms),
      time: DateTime.parse(date),
    );
  }

  factory UserHealthModel.fromEntity(UserHealth entity) {
    return UserHealthModel(
      id: entity.id,
      height: entity.height.meters,
      weight: entity.weight.kilograms,
      date: entity.time.toIso8601String(),
    );
  }
}
