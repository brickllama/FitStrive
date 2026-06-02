import 'package:test/test.dart';
import 'package:fitstrive/domain/exceptions/validation_exception.dart';
import 'package:fitstrive/domain/value_objects/password.dart';

void main() {
  test(
    'Password() throws ValidationExpection if the value is shorter than 8 characters',
    () {
      final String short = 'p@ssW0r';

      void result() => Password(value: short);

      expect(result, throwsA(isA<ValidationException>()));
    },
  );

  test(
    'Password() throws ValidationExpection if the value has no uppercase character',
    () {
      final String withoutUppercase = 'p@ssw0rd';

      void result() => Password(value: withoutUppercase);

      expect(result, throwsA(isA<ValidationException>()));
    },
  );

  test(
    'Password() throws ValidationExpection if the value has no lowercase character',
    () {
      final String withoutLowercase = 'P@SSW0RD';

      void result() => Password(value: withoutLowercase);

      expect(result, throwsA(isA<ValidationException>()));
    },
  );

  test('Password() throws ValidationExpection if the value has no digit', () {
    final String withoutDigit = 'p@ssWord';

    void result() => Password(value: withoutDigit);

    expect(result, throwsA(isA<ValidationException>()));
  });

  test(
    'Password() throws ValidationExpection if the value has no special character',
    () {
      final String withoutSpecial = 'passW0rd';

      void result() => Password(value: withoutSpecial);

      expect(result, throwsA(isA<ValidationException>()));
    },
  );

  test('Password() constructs if the value is valid', () {
    final String normal = 'p@ssW0rd';

    final Password result = Password(value: normal);

    expect(result, isA<Password>());
    expect(result.value, normal);
  });
}
