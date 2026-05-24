import '../enums/measurement_system.dart';
import '../value_objects/height.dart';
import '../value_objects/weight.dart';

/// Represents a user's profile.
final class UserProfile {
  final Height height;
  final Weight weight;
  final MeasurementSystem measurementSystem;

  UserProfile({
    required this.height,
    required this.weight,
    this.measurementSystem = MeasurementSystem.metric, // Defaults to metric
  });
}
