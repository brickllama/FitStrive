import 'package:test/test.dart';
import 'package:fitstrive/domain/value_objects/name.dart';

void main() {
  group('Test without last name, with last name', () {
    test('name should construct without a last name.', () {
      final Name withoutLastName = Name(firstName: "John", lastName: null);
      expect(withoutLastName, isA<Name>());
    });

    test('name should construct with a last name.', () {
      final Name withLastName = Name(firstName: "Jane", lastName: "Doe");
      expect(withLastName, isA<Name>());
    });
  });
}
