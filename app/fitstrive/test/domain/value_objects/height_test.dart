import 'package:test/test.dart';
import 'package:fitstrive/domain/enums/height_unit.dart';
import 'package:fitstrive/domain/exceptions/limit_exception.dart';
import 'package:fitstrive/domain/exceptions/type_exception.dart';
import 'package:fitstrive/domain/value_objects/height.dart';

void main() {
  group('Units', () {
    late Height height;
    setUp(() {
      height = Height(value: 186, unit: HeightUnit.centimeters);
    });

    test('Height.centimeters should return base value', () {
      expect(
        height.centimeters,
        HeightUnit.centimeters.fromCentimeters(height.centimeters),
      );
    });

    test('Height.meters should convert base value to meters', () {
      expect(
        height.meters,
        HeightUnit.meters.fromCentimeters(height.centimeters),
      );
    });

    test('Height.inches should convert base value to inches', () {
      expect(
        height.inches,
        HeightUnit.inches.fromCentimeters(height.centimeters),
      );
    });

    test('Height.feet should convert base value to feet', () {
      expect(height.feet, HeightUnit.feet.fromCentimeters(height.centimeters));
    });
  });

  group('Exceptions', () {
    late HeightUnit unit;
    setUp(() {
      unit = HeightUnit.meters;
    });

    test('Height() should throw TypeException if nan value', () {
      final double nan = double.nan;

      void act() => Height(value: nan, unit: unit);

      expect(act, throwsA(isA<TypeException>()));
    });

    test('Height() should throw LimitException if negative value', () {
      final double negative = -1.0;

      void act() => Height(value: negative, unit: unit);

      expect(act, throwsA(isA<LimitException>()));
    });
  });

  group('Constructs', () {
    test('Height() should construct if imperial unit', () {
      final double value = 6;
      final HeightUnit unit = HeightUnit.feet;

      final Height height = Height(value: value, unit: unit);

      expect(height, isA<Height>());
      expect(height.feet, value);
    });

    test('Height() should construct if metric unit', () {
      final double value = 1.86;
      final HeightUnit unit = HeightUnit.meters;

      final Height height = Height(value: value, unit: unit);

      expect(height, isA<Height>());
      expect(height.meters, value);
    });
  });

  group('Comparisons', () {
    late Height tallHeightImperial;
    late Height tallHeightMetric;
    late Height shortHeightMetric;

    setUp(() {
      tallHeightImperial = Height(value: 6, unit: HeightUnit.feet);
      tallHeightMetric = Height(value: 1.83, unit: HeightUnit.meters);
      shortHeightMetric = Height(value: 175, unit: HeightUnit.centimeters);
    });

    test('6ft should be larger than 1.80 meters', () {
      expect(tallHeightImperial.compareTo(shortHeightMetric), greaterThan(0));
      expect(shortHeightMetric.compareTo(tallHeightImperial), lessThan(0));
    });

    test('6ft should be equal to 1.83 meters', () {
      expect(
        tallHeightImperial.centimeters,
        closeTo(tallHeightMetric.centimeters, 0.2),
      );
    });
  });
}
