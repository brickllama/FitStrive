import 'package:uuid/uuid.dart';
import 'package:fitstrive/domain/exceptions/id_exception.dart';

/// Represents a user id.
final class Id {
  final String value;

  Id._internal(this.value);

  factory Id({required final String value}) {
    final result = Uuid.isValidUUID(fromString: value);

    if (!result) {
      throw IdException('Invalid UUID');
    }

    return Id._internal(value);
  }
}
