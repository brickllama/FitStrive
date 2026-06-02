final class UserDTO {
  /// Constructs a [UserDTO] object.
  ///
  /// [id] - The user's ID.
  ///
  /// [email] - The user's email.
  ///
  /// [username] - The user's username.
  ///
  /// [firstName] - The user's first name.
  ///
  /// [lastName] - The user's last name (optional).
  UserDTO({
    required this.id,
    required this.email,
    required this.username,
    required this.firstName,
    this.lastName,
  });

  /// Deserializes JSON format into a [UserDTO] object.
  ///
  /// [json] - The user in JSON format.
  factory UserDTO.fromJson(Map<String, dynamic> json) {
    return UserDTO(
      id: json['uuid'] as String,
      email: json['email'] as String,
      username: json['username'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String?,
    );
  }

  final String id;
  final String email;
  final String username;
  final String firstName;
  final String? lastName;
}
