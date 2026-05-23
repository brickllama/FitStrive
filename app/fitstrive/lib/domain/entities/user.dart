import './user_profile.dart';
import '../value_objects/email.dart';
import '../value_objects/user_id.dart';

/// Represents a user.
final class User {
  final UserId id;
  final Email? email;
  final UserProfile profile;

  User({UserId? id, this.email, required this.profile}) : id = id ?? UserId();

  User.clone(User user)
    : this(id: user.id, email: user.email, profile: user.profile);
}
