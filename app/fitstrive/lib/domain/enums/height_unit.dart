/// BASE: centimeters.
enum HeightUnit {
  centimeters('cm', 1.0),
  meters('m', 100.0);

  // PUBLIC

  const HeightUnit(this.symbol, this.centimetersPerUnit);

  final String symbol;
  final double centimetersPerUnit;

  double fromCentimeters(double value) {
    return value / centimetersPerUnit;
  }

  double toCentimeters(double value) {
    return value * centimetersPerUnit;
  }

  double convertTo(double value, HeightUnit target) {
    final centimeters = toCentimeters(value);
    return target.fromCentimeters(centimeters);
  }
}
