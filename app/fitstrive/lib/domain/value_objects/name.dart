/// Represents a name.
final class Name {
  final String firstName;
  final String? lastName;

  Name._internal(this.firstName, this.lastName);

  factory Name({required final String firstName, final String? lastName}) {
    return Name._internal(firstName, lastName);
  }
}
