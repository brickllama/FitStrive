import '../exceptions/email_exception.dart';

/// Represents an email address.
final class Email {
  final String value;

  const Email._internal({required this.value});

  factory Email({required String value}) {
    if (!_regex.hasMatch(value)) {
      throw EmailException('Invalid email format!');
    }
    return ._internal(value: value);
  }

  static final RegExp _regex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
}
