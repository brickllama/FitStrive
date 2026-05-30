import '../value_objects/user_id.dart';
import '../value_objects/email.dart';
import '../value_objects/name.dart';

final class User {
  /// Constructs a [User] object.
  ///
  /// [id] The user's ID.
  ///
  /// [email] The user's email.
  ///
  /// [name] The user's name.
  User({required this.id, required this.email, required this.name});

  final UserID id;
  final Email email;
  final Name name;
}
