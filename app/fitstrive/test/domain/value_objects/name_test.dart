import 'package:test/test.dart';
import 'package:fitstrive/domain/value_objects/name.dart';

void main() {
  group('Test without last name, with last name', () {
    test('name should construct without a last name.', () {
      Name act() => Name(firstName: "John", lastName: null);
      expect(act(), isA<Name>());
    });

    test('name should construct with a last name.', () {
      Name act() => Name(firstName: "Jane", lastName: "Doe");
      expect(act(), isA<Name>());
    });
  });
}
