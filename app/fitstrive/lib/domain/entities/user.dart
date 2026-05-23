import './user_profile.dart';
import '../value_objects/email.dart';
import '../value_objects/user_id.dart';

/// Represents a user.
final class User {
  final UserId id;
  final Email? email;
  final UserProfile profile;

  User._internal(UserId? id, this.email, this.profile) : id = id ?? UserId();

  factory User.create({
    final Email? email,
    required final UserProfile profile,
  }) {
    return User._internal(UserId(), email, profile);
  }

  factory User.load({
    required final UserId id,
    final Email? email,
    required final UserProfile profile,
  }) {
    return User._internal(id, email, profile);
  }
}
