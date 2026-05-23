import '../exceptions/height_exception.dart';

/// Represents height.
///
/// BASE UNIT IS CENTIMETERS (cm).
final class Height {
  final double value;

  const Height._internal({required this.value});

  factory Height({required double value}) {
    if (value.isNaN) {
      throw HeightException('Height is not a number.');
    }

    if (value < 0) {
      throw HeightException('Height cannot be negative');
    }

    return ._internal(value: value);
  }
}
