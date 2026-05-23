import '../exceptions/weight_exception.dart';

/// Represents weight.
///
/// BASE UNIT IS KILOGRAMS (kg).
final class Weight {
  final double amount;

  const Weight._internal({required this.amount});

  factory Weight({required double amount}) {
    if (amount.isNaN) {
      throw WeightException("Weight is not a number.");
    }

    if (amount < 0) {
      throw WeightException("Weight cannot be negative.");
    }

    return Weight._internal(amount: amount);
  }
}
