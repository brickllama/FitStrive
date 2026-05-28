final class Macronutrients {
  factory Macronutrients({
    required final double carbohydrates,
    required final double proteins,
    required final double fats,
  }) {
    return Macronutrients._internal(carbohydrates, proteins, fats);
  }

  Macronutrients._internal(this.carbohydrates, this.proteins, this.fats);

  final double carbohydrates;
  final double proteins;
  final double fats;
}
