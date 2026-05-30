import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../configs/app_config.dart';
import '../dtos/user_dto.dart';
import '../mappers/user_mapper.dart';
import 'package:fitstrive/application/abstractions/remote_user_datasource.dart';
import 'package:fitstrive/domain/abstractions/result.dart';
import 'package:fitstrive/domain/entities/user.dart';
import 'package:fitstrive/domain/value_objects/email.dart';
import 'package:fitstrive/domain/value_objects/name.dart';
import 'package:fitstrive/domain/value_objects/username.dart';
import 'package:fitstrive/domain/value_objects/user_id.dart';
import 'package:fitstrive/domain/value_objects/password.dart';

final class RemoteUserDatasourceImpl implements RemoteUserDatasource {
  static final String _url = '${AppConfig.apiUrl}/users';

  /// Attempts to remove a user from the remote server, based on
  /// their user ID.
  ///
  /// [userID] - The user's ID.
  @override
  Future<Result<void>> delete(final UserID userID) async {
    try {
      final response = await http.delete(Uri.parse('$_url/${userID.value}'));

      if (response.statusCode == 204) {
        return Result.ok(null);
      }
      return Result.error(
        HttpException('${response.statusCode}: ${response.body}'),
      );
    } on Exception catch (exception) {
      return Result.error(exception);
    }
  }

  /// Attempts to perform a user login by comparing
  /// login details to what's held in the remote server.
  ///
  /// [email] - The user's email.
  ///
  /// [password] - The user's password.
  @override
  Future<Result<User>> login(final Email email, final Password password) async {
    try {
      final response = await http.post(
        Uri.parse('$_url/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email.value,
          'password': password.value,
        }),
      );

      if (response.statusCode == 200) {
        final UserDTO dto = UserDTO.fromJson(jsonDecode(response.body));
        return Result.ok(UserMapper.toDomain(dto));
      }
      return Result.error(
        HttpException('${response.statusCode}: ${response.body}'),
      );
    } on Exception catch (exception) {
      return Result.error(exception);
    }
  }

  /// Attempts to register a user to the remote server,
  /// based on their email and password.
  ///
  /// [email] - The user's email.
  ///
  /// [username] - The user's username.
  ///
  /// [firstName] - The user's first name.
  ///
  /// [lastName] - The user's last name.
  ///
  /// [password] - The user's password.
  @override
  Future<Result<User>> register(
    final Email email,
    final Username username,
    final Name name,
    final Password password,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('$_url/register'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'email': email.value,
          'username': username.value,
          'firstName': name.firstName,
          'lastName': name.lastName,
          'password': password.value,
        }),
      );

      if (response.statusCode == 201) {
        final UserDTO dto = UserDTO.fromJson(jsonDecode(response.body));
        return Result.ok(UserMapper.toDomain(dto));
      }
      return Result.error(
        HttpException('${response.statusCode}: ${response.body}'),
      );
    } on Exception catch (exception) {
      return Result.error(exception);
    }
  }
}
