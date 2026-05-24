import 'package:test/test.dart';
import 'package:fitstrive/domain/enums/measurement_system.dart';
import 'package:fitstrive/domain/value_objects/height.dart';
import 'package:fitstrive/domain/value_objects/weight.dart';
import 'package:fitstrive/domain/entities/user_profile.dart';

void main() {
  group('Test user creation', () {
    test('basic user-profile creation should work', () {
      final UserProfile userProfile = UserProfile(
        height: Height(value: 186),
        weight: Weight(value: 75),
        measurementSystem: MeasurementSystem.metric,
      );
      expect(userProfile, isA<UserProfile>());
    });
  });
}
