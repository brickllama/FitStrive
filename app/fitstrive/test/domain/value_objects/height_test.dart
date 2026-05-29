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
    test('Height() should construct if metric unit', () {
      final double value = 1.86;
      final HeightUnit unit = HeightUnit.meters;

      final Height height = Height(value: value, unit: unit);

      expect(height, isA<Height>());
      expect(height.meters, value);
    });
  });
}
