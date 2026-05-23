/// Represents a name.
final class Name {
  final String firstName;
  final String? lastName;

  const Name._internal({required this.firstName, this.lastName});

  factory Name({required String firstName, String? lastName}) {
    return Name._internal(firstName: firstName, lastName: lastName);
  }
}
