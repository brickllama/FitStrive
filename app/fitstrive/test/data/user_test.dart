import 'package:test/test.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fitstrive/data/datasources/remote_user_datasource_impl.dart';
import 'package:fitstrive/domain/abstractions/result.dart';
import 'package:fitstrive/domain/entities/user.dart';

void main() async {
  await dotenv.load(fileName: 'config/.env');

  group('RemoteUserDatasourceImpl endpoints', () {
    final RemoteUserDatasourceImpl datasource = RemoteUserDatasourceImpl();
    late User user;

    test('/register POST', () async {
      final String email = 'john.smith@gmail.com';
      final String firstName = 'john';
      final String? lastName = null;
      final String password = 'p@ssW0rd!';
      final result = await datasource.register(
        email,
        firstName,
        lastName,
        password,
      );
      expect(result, isA<Ok<User>>());
      result as Ok<User>;
      user = result.value;
      expect(user.id.value, isNotNull);
      expect(user.email.value, email);
      expect(user.name.firstName, firstName);
      expect(user.name.lastName, lastName);
    });
    test('/:uuid DELETE', () async {
      final result = await datasource.delete(user.id.value);
      expect(result, isA<Ok<void>>());
    });
  });
}
