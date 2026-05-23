final class HeightException implements Exception {
  final String message;

  const HeightException(this.message);

  @override
  String toString() {
    return message;
  }
}
