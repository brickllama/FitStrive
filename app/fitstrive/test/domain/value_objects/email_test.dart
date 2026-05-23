import 'package:test/test.dart';
import 'package:fitstrive/domain/value_objects/email.dart';
import 'package:fitstrive/domain/exceptions/email_exception.dart';

void main() {
  group('Test illegal format, legal format', () {
    test('illegal format should throw EmailException', () {
      void act() => Email(value: '@gmail.com');
      expect(act, throwsA(isA<EmailException>()));
    });

    test('legal format should construct', () {
      final Email email = Email(value: 'good.email@gmail.com');
      expect(email, isA<Email>());
    });
  });
}
