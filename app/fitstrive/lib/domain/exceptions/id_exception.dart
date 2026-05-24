/// Basic Id exception.
final class IdException implements Exception {
  final String message;

  const IdException(this.message);

  @override
  String toString() {
    return message;
  }
}
