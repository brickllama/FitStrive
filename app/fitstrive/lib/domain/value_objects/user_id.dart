import 'package:uuid/uuid.dart';

/// Represents a user id.
final class UserId {
  static final Uuid _uuid = Uuid();

  final String value;

  UserId() : value = _uuid.v4();
}
