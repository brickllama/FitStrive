import 'package:test/test.dart';
import 'package:fitstrive/domain/exceptions/format_exception.dart';
import 'package:fitstrive/domain/value_objects/user_id.dart';

void main() {
  test('UserID() throws FormatException if format is invalid', () {
    final String invalidFormat = '1-2-3-4-5';

    void result() => UserID(value: invalidFormat);

    expect(result, throwsA(isA<FormatException>()));
  });

  test('UserID() constructs if the format is valid', () {
    final String normal = 'de4c3ed7-4994-41dc-8457-efce746d999a';

    final UserID result = UserID(value: normal);

    expect(result, isA<UserID>());
    expect(result.value, normal);
  });
}
