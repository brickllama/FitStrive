abstract class DomainException implements Exception {
  const DomainException(this.message);

  @override
  String toString() {
    return message;
  }

  final String message;
}
