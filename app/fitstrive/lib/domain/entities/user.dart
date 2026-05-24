import './user_profile.dart';
import '../value_objects/email.dart';
import '../value_objects/name.dart';
import '../value_objects/id.dart';

/// Represents a user.
final class User {
  final Id id;
  final Email email;
  final Name name;
  final UserProfile profile;

  User._internal(this.id, this.email, this.name, this.profile);

  factory User({
    required final Id id,
    required final Email email,
    required final Name name,
    required final UserProfile profile,
  }) {
    return User._internal(id, email, name, profile);
  }
}
