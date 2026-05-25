import 'package:test/test.dart';
import 'package:fitstrive/domain/enums/weight_unit.dart';
import 'package:fitstrive/domain/exceptions/limit_exception.dart';
import 'package:fitstrive/domain/exceptions/type_exception.dart';
import 'package:fitstrive/domain/value_objects/weight.dart';

void main() {
  group('Units', () {
    late Weight weight;
    setUp(() {
      weight = Weight(value: 165, unit: WeightUnit.pounds);
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

    test('Weight.ounces should convert base value to ounces', () {
      expect(weight.ounces, WeightUnit.ounces.fromKilograms(weight.kilograms));
    });

    test('Weight.pounds should convert base value to pounds', () {
      expect(weight.pounds, WeightUnit.pounds.fromKilograms(weight.kilograms));
    });

    test('Weight.stones should convert base value to stones', () {
      expect(weight.stones, WeightUnit.stones.fromKilograms(weight.kilograms));
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
    test('Weight() should construct if imperial unit', () {
      final double value = 25;
      final WeightUnit unit = WeightUnit.pounds;

      final Weight weight = Weight(value: value, unit: unit);

      expect(weight, isA<Weight>());
      expect(weight.pounds, value);
    });

    test('Weight() should construct if metric unit', () {
      final double value = 10;
      final WeightUnit unit = WeightUnit.grams;

      final Weight weight = Weight(value: value, unit: unit);

      expect(weight, isA<Weight>());
      expect(weight.grams, value);
    });
  });

  group('Comparisons', () {
    late Weight largeWeightImperial;
    late Weight largeWeightMetric;
    late Weight smallWeightMetric;

    setUp(() {
      largeWeightImperial = Weight(value: 25, unit: WeightUnit.pounds);
      largeWeightMetric = Weight(value: 11.33, unit: WeightUnit.kilograms);
      smallWeightMetric = Weight(value: 500, unit: WeightUnit.grams);
    });

    test('25lbs should be greater than 500g', () {
      expect(largeWeightImperial.compareTo(smallWeightMetric), greaterThan(0));
      expect(smallWeightMetric.compareTo(largeWeightImperial), lessThan(0));
    });

    test('25lbs should be close to 11.33kg', () {
      expect(
        largeWeightImperial.kilograms,
        closeTo(largeWeightMetric.kilograms, 0.01),
      );
    });
  });
}
