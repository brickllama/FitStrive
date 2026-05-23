import '../exceptions/weight_exception.dart';

/// Represents weight.
///
/// BASE UNIT IS KILOGRAMS (kg).
final class Weight {
  final double value;

  Weight._internal(this.value);

  factory Weight({required final double value}) {
    if (value.isNaN) {
      throw WeightException('Weight is not a number.');
    }

    if (value < 0) {
      throw WeightException('Weight cannot be negative.');
    }

    return Weight._internal(value);
  }
}
