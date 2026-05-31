// Presentation layer models for the daily intake stats
// These are ui data shapes only, not domain entities

class DailyNutritionSummary {
  final int caloriesConsumed;
  final int calorieGoal;
  final double proteinG;
  final double carbsG;
  final double fatG;

  const DailyNutritionSummary({
    this.caloriesConsumed = 0,
    this.calorieGoal = 0,
    this.proteinG = 0,
    this.carbsG = 0,
    this.fatG = 0,
  });

  int get caloriesRemaining => calorieGoal - caloriesConsumed;

  // progress as a 0-1 value for progress indicators
  double get calorieProgress =>
      calorieGoal == 0 ? 0 : (caloriesConsumed / calorieGoal).clamp(0.0, 1.0);
}

class MealEntryItem {
  final String id;
  final String foodName;
  final int calories;
  final double amountG;

  const MealEntryItem({
    required this.id,
    required this.foodName,
    required this.calories,
    required this.amountG,
  });
}