import 'package:test/test.dart';
import 'package:fitstrive/domain/value_objects/height.dart';
import 'package:fitstrive/domain/exceptions/height_exception.dart';

void main() {
  group('Test nan value, negative value, legal value', () {
    test('nan value should throw HeightException', () {
      void act() => Height(amount: double.nan);
      expect(act, throwsA(isA<HeightException>()));
    });

    test('negative value should throw HeightException', () {
      void act() => Height(amount: -1);
      expect(act, throwsA(isA<HeightException>()));
    });
  });
}
