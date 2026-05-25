import './user_health.dart';
import '../value_objects/user_id.dart';
import '../value_objects/email.dart';
import '../value_objects/name.dart';

final class User {
  // PUBLIC

  factory User({
    required final UserID id,
    required final Email email,
    required final Name name,
    required final UserHealth health,
  }) {
    return User._internal(id, email, name, health);
  }

  final UserID id;
  final Email email;
  final Name name;
  final UserHealth health;

  // PRIVATE

  User._internal(this.id, this.email, this.name, this.health);
}
