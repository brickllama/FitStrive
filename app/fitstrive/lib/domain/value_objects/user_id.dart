import 'package:uuid/uuid.dart';
import '../exceptions/format_exception.dart';

final class UserID {
  // PUBLIC

  /// Creates an [UserID] from a string value.
  ///
  /// The [value] parameter must be a valid UUID (v4).
  /// Ex: `de4c3ed7-4994-41dc-8457-efce746d999a`.
  ///
  /// Throws a [FormatException] if the value does not match the required format.
  factory UserID({required final String value}) {
    if (!Uuid.isValidUUID(fromString: value)) {
      throw FormatException('Invalid UUID');
    }
    return UserID._internal(value);
  }

  // PRIVATE

  UserID._internal(this.value);

  final String value;
}
