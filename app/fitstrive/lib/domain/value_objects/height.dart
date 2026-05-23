import '../exceptions/height_exception.dart';

/// Represents height.
///
/// BASE UNIT IS CENTIMETERS (cm).
final class Height {
  final double value;

  Height._internal(this.value);

  factory Height({required final double value}) {
    if (value.isNaN) {
      throw HeightException('Height is not a number.');
    }

    if (value < 0) {
      throw HeightException('Height cannot be negative');
    }

    return Height._internal(value);
  }
}
