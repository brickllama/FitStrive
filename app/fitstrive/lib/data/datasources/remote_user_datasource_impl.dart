import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:fitstrive/application/abstractions/remote_user_datasource.dart';
import 'package:fitstrive/data/configs/app_config.dart';
import 'package:fitstrive/data/model/user_model.dart';
import 'package:fitstrive/domain/abstractions/result.dart';
import 'package:fitstrive/domain/entities/user.dart';
import 'package:fitstrive/domain/value_objects/email.dart';
import 'package:fitstrive/domain/value_objects/name.dart';
import 'package:fitstrive/domain/value_objects/password.dart';
import 'package:fitstrive/domain/value_objects/user_id.dart';

final class RemoteUserDatasourceImpl implements RemoteUserDatasource {
  static final String _url = AppConfig.apiUrl;

  @override
  Future<Result<void>> delete(final UserID userID) async {
    /// TODO: finish
    return Result.ok(null);
  }

  @override
  Future<Result<User>> login(final Email email, final Password password) async {
    /// TODO: finish
    return Result.ok(
      UserModel(id: '', email: '', firstName: '', lastName: '').toEntity(),
    );
  }

  @override
  Future<Result<User>> register(
    final Email email,
    final Name name,
    final Password password,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('$_url/users'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email.value,
          'firstName': name.firstName,
          'lastName': name.lastName ?? '',
          'password': password.value,
        }),
      );

      if (response.statusCode == 201) {
        final UserModel userModel = UserModel.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>,
        );
        return Result.ok(userModel.toEntity());
      }
      return Result.error(HttpException('Invalid Response'));
    } on Exception catch (exception) {
      return Result.error(exception);
    }
  }
}
