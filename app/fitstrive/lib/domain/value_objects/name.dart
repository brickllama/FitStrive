final class Name {
  // PUBLIC

  /// Creates a [Name] from two string values.
  ///
  /// The [firstName] parameter is required.
  ///
  /// The [lastName] parameter is optional, may be null.
  factory Name({required final String firstName, final String? lastName}) {
    return Name._internal(firstName, lastName);
  }

  // PRIVATE

  Name._internal(this.firstName, this.lastName)
    : value = (lastName == null || lastName.isEmpty)
          ? firstName
          : '$firstName $lastName';

  final String firstName;
  final String? lastName;
  final String value;
}
