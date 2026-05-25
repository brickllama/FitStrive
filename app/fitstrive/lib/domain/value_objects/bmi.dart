import './height.dart';
import './weight.dart';

final class BodyMassIndex {
  // PUBLIC

  factory BodyMassIndex({
    required final Height height,
    required final Weight weight,
  }) {
    final double value = weight.kilograms / (height.meters * height.meters);
    return BodyMassIndex._internal(value);
  }

  // PRIVATE

  BodyMassIndex._internal(this.value);

  final double value;
}
