import 'dart:developer';

import 'package:fitstrive/application/usecases/get_foods_usecase.dart';
import 'package:fitstrive/application/usecases/remove_food_usecase.dart';
import 'package:fitstrive/domain/entities/food_log.dart';

import '../base_viewmodel.dart';
import '../../models/daily_intake_stats/daily_intake_stats_models.dart';

class DailyIntakeViewModel extends BaseViewModel {
  final GetFoodsUsecase getFoodsUsecase;
  final RemoveFoodUsecase removeFoodUsecase;

  DailyIntakeViewModel({
    required this.getFoodsUsecase,
    required this.removeFoodUsecase,
  });

  DailyNutritionSummary _summary = const DailyNutritionSummary();
  List<MealEntryItem> _meals = [];
  DateTime _selectedDate = DateTime.now();

  DailyNutritionSummary get summary => _summary;
  List<MealEntryItem> get meals => _meals;
  DateTime get selectedDate => _selectedDate;
  bool get hasMeals => _meals.isNotEmpty;

  Future<void> loadDailyIntake({DateTime? date}) async {
    _selectedDate = date ?? _selectedDate;

    final from = DateTime(
      _selectedDate.year,
      _selectedDate.month,
      _selectedDate.day,
    );

    final to = from.add(const Duration(days: 1));

    await runAsync(() async {
      final foodLogs = await getFoodsUsecase.execute(from, to);
      log("Food Log Items: ${foodLogs.length.toString()}");
      _meals = foodLogs.map(_toMealEntryItem).toList();

      final totalCalories = foodLogs.fold<double>(
        0,
        (sum, food) => sum + food.calories,
      );

      final totalProtein = foodLogs.fold<double>(
        0,
        (sum, food) => sum + food.macronutrients.proteins,
      );

      final totalCarbs = foodLogs.fold<double>(
        0,
        (sum, food) => sum + food.macronutrients.carbohydrates,
      );

      final totalFats = foodLogs.fold<double>(
        0,
        (sum, food) => sum + food.macronutrients.fats,
      );

      _summary = DailyNutritionSummary(
        caloriesConsumed: totalCalories.round(),
        calorieGoal: 2000,
        proteinG: totalProtein.round().toDouble(),
        carbsG: totalCarbs.round().toDouble(),
        fatG: totalFats.round().toDouble(),
      );
      return true;
    });
  }

  MealEntryItem _toMealEntryItem(FoodLog food) {
    log(food.id);
    return MealEntryItem(
      id: food.id,
      foodName: food.foodname.foodname,
      calories: food.calories.round(),
      amountG: food.weight.grams,
    );
  }

  double _toGrams(double weight, String unitSymbol) {
    if (unitSymbol.toLowerCase() == 'kg') {
      return weight * 1000;
    }

    return weight;
  }

  Future<void> deleteMeal(String id) async {
    await runAsync(() async {
      // TODO: call delete food log usecase here later

      _meals = _meals.where((m) => m.id != id).toList();
      log("Remove food id: ${id}");

      final deleted = await removeFoodUsecase.execute(id);

      if (!deleted) {
        throw Exception("Could not delete food entry");
      }

      await loadDailyIntake(date: _selectedDate);

      final totalCalories = _meals.fold<int>(
        0,
        (sum, meal) => sum + meal.calories,
      );

      _summary = DailyNutritionSummary(
        caloriesConsumed: totalCalories,
        calorieGoal: _summary.calorieGoal,
        proteinG: _summary.proteinG,
        carbsG: _summary.carbsG,
        fatG: _summary.fatG,
      );
      return true;
    });
  }
}
