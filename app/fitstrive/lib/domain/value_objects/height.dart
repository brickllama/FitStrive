import '../enums/height_unit.dart';
import '../exceptions/limit_exception.dart';
import '../exceptions/type_exception.dart';

final class Height implements Comparable<Height> {
  // PUBLIC

  /// Creates a [Height] value object.
  ///
  /// The input is always normalized to centimeters, which is the
  /// representation for all [Height] instances.
  ///
  /// Throws a [TypeException] if the value isn't finite.
  /// Throws a [LimitException] if the value is a negative number.
  factory Height({required double value, required HeightUnit unit}) {
    if (!value.isFinite) {
      throw TypeException('Height must be a finite number');
    }
    if (value.isNegative) {
      throw LimitException('Height cannot be negative');
    }
    return Height._internal(unit.toCentimeters(value));
  }

  double get centimeters => _value;

  double get meters => _toUnit(HeightUnit.meters);

  double get inches => _toUnit(HeightUnit.inches);

  double get feet => _toUnit(HeightUnit.feet);

  @override
  int compareTo(Height other) => _value.compareTo(other._value);

  @override
  bool operator ==(Object other) => other is Height && _value == other._value;

  @override
  int get hashCode => _value.hashCode;

  // PRIVATE

  Height._internal(this._value);

  double _toUnit(final HeightUnit unit) {
    return unit.fromCentimeters(_value);
  }

  final double _value;
}
