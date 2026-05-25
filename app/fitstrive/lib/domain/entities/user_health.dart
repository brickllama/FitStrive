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
  }) {
    return UserHealth._internal(height, weight);
  }

  BodyMassIndex get bmi => BodyMassIndex(height: height, weight: weight);

  final Height height;
  final Weight weight;

  // PRIVATE

  UserHealth._internal(this.height, this.weight);
}
