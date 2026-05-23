/// Basic email exception.
final class EmailException implements Exception {
  final String message;

  const EmailException(this.message);

  @override
  String toString() {
    return message;
  }
}
