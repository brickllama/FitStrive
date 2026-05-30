import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../configs/app_config.dart';
import '../dtos/user_dto.dart';
import '../mappers/user_mapper.dart';
import 'package:fitstrive/application/abstractions/remote_user_datasource.dart';
import 'package:fitstrive/domain/abstractions/result.dart';
import 'package:fitstrive/domain/entities/user.dart';

final class RemoteUserDatasourceImpl implements RemoteUserDatasource {
  static final String _url = '${AppConfig.apiUrl}/users';

  /// Attempts to remove a user from the remote server, based on
  /// their user ID.
  ///
  /// [userID] - The user's ID.
  @override
  Future<Result<void>> delete(final String userID) async {
    try {
      final response = await http.delete(Uri.parse('$_url/$userID'));

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
  Future<Result<User>> login(final String email, final String password) async {
    try {
      final response = await http.post(
        Uri.parse('$_url/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
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
  /// [firstName] - The user's first name.
  ///
  /// [lastName] - The user's last name.
  ///
  /// [password] - The user's password.
  @override
  Future<Result<User>> register(
    final String email,
    final String firstName,
    final String? lastName,
    final String password,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('$_url/register'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'first_name': firstName,
          'last_name': ?lastName,
          'password': password,
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
