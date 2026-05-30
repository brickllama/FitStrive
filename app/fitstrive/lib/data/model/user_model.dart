import 'package:fitstrive/domain/entities/user.dart';
import 'package:fitstrive/domain/value_objects/email.dart';
import 'package:fitstrive/domain/value_objects/name.dart';
import 'package:fitstrive/domain/value_objects/user_id.dart';

class UserModel {
  final String id;
  final String email;
  final String firstName;
  final String? lastName;

  UserModel({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['uuid'],
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uuid': id,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
    };
  }

  User toEntity() {
    return User(
      id: UserID(value: this.id),
      email: Email(value: this.email),
      name: Name(firstName: this.firstName, lastName: this.lastName),
    );
  }

  factory UserModel.fromEntity(User entry) {
    return UserModel(
      id: entry.id.value,
      email: entry.email.value,
      firstName: entry.name.firstName,
      lastName: entry.name.lastName,
    );
  }
}
