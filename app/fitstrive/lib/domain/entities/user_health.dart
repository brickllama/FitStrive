import '../value_objects/bmi.dart';
import '../value_objects/height.dart';
import '../value_objects/weight.dart';

final class UserHealth {
  // PUBLIC

  /// Creates a [UserHealth] from a [height] and [weight].
  ///
  ///
  UserHealth({
    required this.id,
    required this.height,
    required this.weight,
    required this.time,
  });

  BodyMassIndex get bmi => BodyMassIndex(height: height, weight: weight);

  final String id;
  final Height height;
  final Weight weight;
  final DateTime time;
}
