/// BASE: kilograms.
enum WeightUnit {
  milligrams('mg', 0.000001),
  grams('g', 0.001),
  kilograms('kg', 1.0);

  // PUBLIC

  const WeightUnit(this.symbol, this.kilogramsPerUnit);

  final String symbol;
  final double kilogramsPerUnit;

  double fromKilograms(double value) {
    return value / kilogramsPerUnit;
  }

  double toKilograms(double value) {
    return value * kilogramsPerUnit;
  }

  double convertTo(double value, WeightUnit target) {
    double kilograms = toKilograms(value);
    return target.fromKilograms(kilograms);
  }
}
