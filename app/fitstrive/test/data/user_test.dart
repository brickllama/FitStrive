// import 'package:fitstrive/domain/abstractions/result.dart';
// import 'package:fitstrive/domain/entities/user.dart';
import 'package:fitstrive/domain/entities/user.dart';
import 'package:test/test.dart';
import 'package:fitstrive/data/datasources/remote_user_datasource_impl.dart';
import 'package:fitstrive/domain/value_objects/email.dart';
import 'package:fitstrive/domain/value_objects/name.dart';
import 'package:fitstrive/domain/value_objects/password.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() {
  test('HTTP EXCTION NO BUENO', () async {
    await dotenv.load(fileName: 'config/.env');

    final Name name = Name(firstName: 'Timothy', lastName: 'Tough Knuckles');
    final Email email = Email(value: 'timmy@timmail.com');
    final Password password = Password(value: 'tImmyToughKnuckl3!');
    final RemoteUserDatasourceImpl datasource = RemoteUserDatasourceImpl();
    final result = await datasource.register(email, name, password);
  });
}
