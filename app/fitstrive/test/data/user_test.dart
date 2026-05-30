import 'package:test/test.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fitstrive/data/datasources/remote_user_datasource_impl.dart';
import 'package:fitstrive/domain/abstractions/result.dart';
import 'package:fitstrive/domain/entities/user.dart';
import 'package:fitstrive/domain/value_objects/email.dart';
import 'package:fitstrive/domain/value_objects/name.dart';
import 'package:fitstrive/domain/value_objects/username.dart';
import 'package:fitstrive/domain/value_objects/password.dart';

void main() async {
  await dotenv.load(fileName: 'config/.env');

  group('RemoteUserDatasourceImpl endpoints', () {
    final RemoteUserDatasourceImpl datasource = RemoteUserDatasourceImpl();
    late User user;

    test('/register POST', () async {
      final String email = 'john.smith@gmail.com';
      final String username = '02johnny';
      final String firstName = 'john';
      final String? lastName = null;
      final String password = 'p@ssW0rd!';
      final result = await datasource.register(
        Email(value: email),
        Username(value: username),
        Name(firstName: firstName, lastName: lastName),
        Password(value: password),
      );
      expect(result, isA<Ok<User>>());
      result as Ok<User>;
      user = result.value;
      expect(user.id.value, isNotNull);
      expect(user.email.value, email);
      expect(user.username.value, username);
      expect(user.name.firstName, firstName);
      expect(user.name.lastName, lastName);
    });
    test('/:uuid DELETE', () async {
      final result = await datasource.delete(user.id);
      expect(result, isA<Ok<void>>());
    });
  });
}
