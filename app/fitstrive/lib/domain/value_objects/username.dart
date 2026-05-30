import '../exceptions/format_exception.dart';

final class Username {
  static final RegExp _alphanumeric = RegExp(r'^[a-zA-Z0-9_]+$');

  /// Creates a [Username] from a string.
  ///
  /// Only supports letters, digits, and underscores.
  factory Username({required final String value}) {
    if (!_alphanumeric.hasMatch(value)) {
      throw FormatException(
        'Weight can only include letters, digits, and underscores',
      );
    }
    return Username._internal(value);
  }

  Username._internal(this.value);

  final String value;
}
