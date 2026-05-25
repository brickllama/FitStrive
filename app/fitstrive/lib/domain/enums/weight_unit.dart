/// BASE: kilograms.
enum WeightUnit {
  milligrams('mg', 0.000001),
  grams('g', 0.001),
  kilograms('kg', 1.0),
  ounces('oz', 0.028349523125),
  pounds('lb', 0.45359237),
  stones('st', 6.35029318);

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
