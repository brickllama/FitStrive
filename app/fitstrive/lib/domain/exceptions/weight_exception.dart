/// Basic weight exception.
final class WeightException implements Exception {
  final String message;

  const WeightException(this.message);

  @override
  String toString() {
    return message;
  }
}
