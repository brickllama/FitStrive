import 'package:test/test.dart';
import 'package:fitstrive/domain/enums/weight_unit.dart';
import 'package:fitstrive/domain/exceptions/limit_exception.dart';
import 'package:fitstrive/domain/exceptions/type_exception.dart';
import 'package:fitstrive/domain/value_objects/weight.dart';

void main() {
  group('Units', () {
    late Weight weight;
    setUp(() {
      weight = Weight(value: 165, unit: WeightUnit.grams);
    });

    test('Weight.milligrams should convert base value to milligrams', () {
      expect(
        weight.milligrams,
        WeightUnit.milligrams.fromKilograms(weight.kilograms),
      );
    });

    test('Weight.grams should convert base value to grams', () {
      expect(weight.grams, WeightUnit.grams.fromKilograms(weight.kilograms));
    });

    test('Weight.kilograms should return base value', () {
      expect(
        weight.kilograms,
        WeightUnit.kilograms.fromKilograms(weight.kilograms),
      );
    });
  });

  group('Exceptions', () {
    late WeightUnit unit;
    setUp(() {
      unit = WeightUnit.kilograms;
    });

    test('Weight() should throw TypeException if nan value', () {
      final double nan = double.nan;

      void act() => Weight(value: nan, unit: unit);

      expect(act, throwsA(isA<TypeException>()));
    });

    test('Weight() should throw LimitException if negative value', () {
      final double negative = -1.0;

      void act() => Weight(value: negative, unit: unit);

      expect(act, throwsA(isA<LimitException>()));
    });
  });

  group('Constructs', () {
    test('Weight() should construct if metric unit', () {
      final double value = 10;
      final WeightUnit unit = WeightUnit.grams;

      final Weight weight = Weight(value: value, unit: unit);

      expect(weight, isA<Weight>());
      expect(weight.grams, value);
    });
  });
}
