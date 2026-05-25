import 'package:test/test.dart';
import 'package:fitstrive/domain/exceptions/format_exception.dart';
import 'package:fitstrive/domain/value_objects/email.dart';

void main() {
  test('Email() throws FormatException if the format is invalid', () {
    final String invalidFormat = 'john.smith@gmail';

    void result() => Email(value: invalidFormat);

    expect(result, throwsA(isA<FormatException>()));
  });

  test('Email() constructs if the format is valid', () {
    final String normal = 'jane.doe@outlook.com';

    final Email result = Email(value: normal);

    expect(result, isA<Email>());
    expect(result.value, normal);
  });
}
