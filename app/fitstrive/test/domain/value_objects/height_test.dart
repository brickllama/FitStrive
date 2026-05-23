import 'package:test/test.dart';
import 'package:fitstrive/domain/value_objects/height.dart';
import 'package:fitstrive/domain/exceptions/height_exception.dart';

void main() {
  group('Test nan value, negative value, legal value', () {
    test('nan value should throw HeightException', () {
      void act() => Height(value: double.nan);
      expect(act, throwsA(isA<HeightException>()));
    });

    test('negative value should throw HeightException', () {
      void act() => Height(value: -1);
      expect(act, throwsA(isA<HeightException>()));
    });

    test('legal value should construct', () {
      Height act() => Height(value: 45);
      expect(act(), isA<Height>());
    });
  });
}
