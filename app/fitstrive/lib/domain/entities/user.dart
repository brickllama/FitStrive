import '../value_objects/email.dart';
import '../value_objects/name.dart';
import '../value_objects/username.dart';
import '../value_objects/user_id.dart';
import '../value_objects/email.dart';
import '../value_objects/name.dart';

final class User {
  /// Constructs a [User] object.
  ///
  /// [id] - The user's ID.
  ///
  /// [email] - The user's email.
  ///
  /// [username] - The user's username.
  ///
  /// [name] - The user's name.
  User({
    required this.id,
    required this.email,
    required this.username,
    required this.name,
  });

  final UserID id;
  final Email email;
  final Username username;
  final Name name;
}
