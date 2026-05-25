import '../enums/weight_unit.dart';
import '../exceptions/limit_exception.dart';
import '../exceptions/type_exception.dart';

/// BASE UNIT IS KILOGRAMS (kg).
final class Weight implements Comparable<Weight> {
  // PUBLIC

  /// Creates a [Weight] value object.
  ///
  /// The input is always normalized to kilograms, which is the
  /// representation for all [Weight] instances.
  ///
  /// Throws a [TypeException] if the value isn't finite.
  /// Throws a [LimitException] if the value is a negative number.
  factory Weight({
    required final double value,
    required final WeightUnit unit,
  }) {
    if (!value.isFinite) {
      throw TypeException('Weight must be a finite number');
    }
    if (value.isNegative) {
      throw LimitException('Weight cannot be negative');
    }
    return Weight._internal(unit.toKilograms(value));
  }

  double get milligrams => _toUnit(WeightUnit.milligrams);

  double get grams => _toUnit(WeightUnit.grams);

  double get kilograms => _value;

  double get ounces => _toUnit(WeightUnit.ounces);

  double get pounds => _toUnit(WeightUnit.pounds);

  double get stones => _toUnit(WeightUnit.stones);

  @override
  int compareTo(Weight other) => _value.compareTo(other._value);

  @override
  bool operator ==(Object other) => other is Weight && _value == other._value;

  @override
  int get hashCode => _value.hashCode;

  // PRIVATE

  Weight._internal(this._value);

  double _toUnit(final WeightUnit unit) {
    return unit.fromKilograms(_value);
  }

  final double _value;
}
