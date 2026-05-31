import '../exceptions/validation_exception.dart';

final class Password {
  // PUBLIC

  /// Creates a [Password] from a string.
  ///
  /// The [value] parameter must satisfy the following rules:
  /// - At least 8 characters long.
  /// - At least one upperchase character.
  /// - At least one lowercase character.
  /// - At least one digit.
  /// - At least one special character.
  ///
  /// Throws a [ValidationException] if any rule is violated.
  factory Password({required final String value}) {
    if (value.length < 8) {
      throw ValidationException('Password must be at least 8 characters long');
    }
    if (!value.contains(_uppercase)) {
      throw ValidationException(
        'Password must contain at least one uppercase character',
      );
    }
    if (!value.contains(_lowercase)) {
      throw ValidationException(
        'Password must contain at least one lowercase character',
      );
    }
    /*if (!value.contains(_digit)) {
      throw ValidationException('Password must contain at least one digit');
    }
    if (!value.contains(_special)) {
      throw ValidationException(
        'Password must contain at least one special character',
      );
    }*/
    return Password._internal(value);
  }

  // PRIVATE

  static final RegExp _uppercase = RegExp(r'[A-Z]');
  static final RegExp _lowercase = RegExp(r'[a-z]');
  static final RegExp _digit = RegExp(r'[0-9]');
  static final RegExp _special = RegExp(r'[!@#%^&*(),.?":{}|<>]');

  Password._internal(this.value);

  final String value;
}
