import '../dtos/user_dto.dart';
import 'package:fitstrive/domain/entities/user.dart';
import 'package:fitstrive/domain/value_objects/email.dart';
import 'package:fitstrive/domain/value_objects/name.dart';
import 'package:fitstrive/domain/value_objects/user_id.dart';

final class UserMapper {
  /// Converts a [UserDTO] to [User].
  ///
  /// [dto] - The user data-transfer-object (data layer).
  static User toDomain(UserDTO dto) {
    return User(
      id: UserID(value: dto.id),
      email: Email(value: dto.email),
      name: Name(firstName: dto.firstName, lastName: dto.lastName),
    );
  }

  /// Converts a [User] to [UserDTO].
  ///
  /// [user] - The user object (domain layer).
  static UserDTO fromDomain(User user) {
    return UserDTO(
      id: user.id.value,
      email: user.email.value,
      firstName: user.name.firstName,
      lastName: user.name.lastName,
    );
  }
}
