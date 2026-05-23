import '../exceptions/weight_exception.dart';

/// Represents weight.
///
/// BASE UNIT IS KILOGRAMS (kg).
final class Weight {
  final double value;

  const Weight._internal({required this.value});

  factory Weight({required double value}) {
    if (value.isNaN) {
      throw WeightException('Weight is not a number.');
    }

    if (value < 0) {
      throw WeightException('Weight cannot be negative.');
    }

    return ._internal(value: value);
  }
}
