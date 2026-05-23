import '../exceptions/height_exception.dart';

/// Represents height.
///
/// BASE UNIT IS CENTIMETERS (cm).
final class Height {
  final double amount;

  const Height._internal({required this.amount});

  factory Height({required double amount}) {
    if (amount.isNaN) {
      throw HeightException("Height is not a number.");
    }

    if (amount < 0) {
      throw HeightException("Height cannot be negative");
    }

    return Height._internal(amount: amount);
  }
}
