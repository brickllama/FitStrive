import '../value_objects/bmi.dart';
import '../value_objects/height.dart';
import '../value_objects/weight.dart';

final class UserHealth {
  // PUBLIC

  /// Creates a [UserHealth] from a [height] and [weight].
  ///
  ///
  factory UserHealth({
    required final Height height,
    required final Weight weight,
    required final DateTime time,
  }) {
    return UserHealth._internal(height, weight, time);
  }

  BodyMassIndex get bmi => BodyMassIndex(height: height, weight: weight);

  final Height height;
  final Weight weight;
  final DateTime time;

  // PRIVATE

  UserHealth._internal(this.height, this.weight, this.time);
}
