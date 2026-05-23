import 'package:test/test.dart';
import 'package:fitstrive/domain/value_objects/weight.dart';
import 'package:fitstrive/domain/exceptions/weight_exception.dart';

void main() {
  group('Test nan value, negative value, legal value', () {
    test('nan value should throw WeightException', () {
      void act() => Weight(amount: double.nan);
      expect(act, throwsA(isA<WeightException>()));
    });

    test('negative value should throw WeightException', () {
      void act() => Weight(amount: -1);
      expect(act, throwsA(isA<WeightException>()));
    });
  });
}
