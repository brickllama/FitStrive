import '../exceptions/email_exception.dart';

/// Represents an email address.
final class Email {
  final String value;

  Email._internal(this.value);

  factory Email({required final String value}) {
    if (!_regex.hasMatch(value)) {
      throw EmailException('Invalid email format!');
    }
    return Email._internal(value);
  }

  static final RegExp _regex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
}
