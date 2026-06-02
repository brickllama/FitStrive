import '../exceptions/format_exception.dart';

final class Email {
  // PUBLIC

  /// Creates an [email] from a string value.
  ///
  /// The [value] parameter must be a valid email address.
  /// Ex: `first.last@proton.me`.
  ///
  /// Throws a [FormatException] if the value does not match the required format.
  factory Email({required final String value}) {
    if (!_validEmail.hasMatch(value)) {
      throw FormatException('Invalid email format');
    }
    return Email._internal(value);
  }

  // PRIVATE

  static final RegExp _validEmail = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  Email._internal(this.value);

  final String value;
}
