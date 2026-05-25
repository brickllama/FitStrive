import 'package:test/test.dart';
import 'package:fitstrive/domain/value_objects/name.dart';

void main() {
  test('Name() constructs if the last name is excluded', () {
    final String firstName = 'Jake';

    final Name result = Name(firstName: firstName);

    expect(result, isA<Name>());
    expect(result.firstName, firstName);
    expect(result.lastName, null);
  });

  test('Name() constructs if the last name is included', () {
    final String firstName = 'Sven';
    final String lastName = 'Svensson';

    final Name result = Name(firstName: firstName, lastName: lastName);

    expect(result, isA<Name>());
    expect(result.firstName, firstName);
    expect(result.lastName, lastName);
  });
}
