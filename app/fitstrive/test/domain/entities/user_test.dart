import 'package:fitstrive/domain/value_objects/email.dart';
import 'package:test/test.dart';
import 'package:fitstrive/domain/enums/measurement_system.dart';
import 'package:fitstrive/domain/value_objects/height.dart';
import 'package:fitstrive/domain/value_objects/name.dart';
import 'package:fitstrive/domain/value_objects/id.dart';
import 'package:fitstrive/domain/value_objects/weight.dart';
import 'package:fitstrive/domain/entities/user.dart';
import 'package:fitstrive/domain/entities/user_profile.dart';

void main() {
  group('Test user creation', () {
    test('basic user creation should work', () {
      final UserProfile userProfile = UserProfile(
        height: Height(value: 186),
        weight: Weight(value: 75),
        measurementSystem: MeasurementSystem.metric,
      );
      expect(userProfile, isA<UserProfile>());

      final User user = User(
        id: Id(value: '569ba859-9f72-4507-8028-b72d9c507820'),
        email: Email(value: 'john.smith@gmail.com'),
        name: Name(firstName: 'John', lastName: 'Smith'),
        profile: userProfile,
      );
      expect(user, isA<User>());
    });
  });
}
