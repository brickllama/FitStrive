import 'package:test/test.dart';
import 'package:fitstrive/domain/value_objects/weight.dart';
import 'package:fitstrive/domain/exceptions/weight_exception.dart';

void main() {
  group('Test nan value, negative value, legal value', () {
    test('nan value should throw WeightException', () {
      void act() => Weight(value: double.nan);
      expect(act, throwsA(isA<WeightException>()));
    });

    test('negative value should throw WeightException', () {
      void act() => Weight(value: -1);
      expect(act, throwsA(isA<WeightException>()));
    });

    test('legal value should construct', () {
      Weight act() => Weight(value: 45);
      expect(act(), isA<Weight>());
    });
  });
}
