import 'package:fitstrive/application/usecases/get_foods_usecase.dart';

import '../base_viewmodel.dart';
import '../../models/daily_intake_stats/daily_intake_stats_models.dart';

// ViewModel responsible for the daily intake flow

class DailyIntakeViewModel extends BaseViewModel {
  GetFoodsUsecase getFoodsUsecase;
  DailyIntakeViewModel({required this.getFoodsUsecase});
  DailyNutritionSummary _summary = const DailyNutritionSummary();
  List<MealEntryItem> _meals = [];
  DateTime _selectedDate = DateTime.now();

  DailyNutritionSummary get summary => _summary;
  List<MealEntryItem> get meals => _meals;
  DateTime get selectedDate => _selectedDate;
  bool get hasMeals => _meals.isNotEmpty;

  // loads daily summary and meal list for the selected date
  // called on screen init and when the user changes the date
  Future<void> loadDailyIntake({DateTime? date}) async {
    _selectedDate = date ?? DateTime.now();

    await runAsync(() async {
      // TODO: connect application layer

      // hardcoded meal entry just for show
      _summary = const DailyNutritionSummary(
        caloriesConsumed: 870,
        calorieGoal: 2000,
        proteinG: 80,
        carbsG: 140,
        fatG: 45,
      );
      _meals = const [
        MealEntryItem(
          id: '1',
          foodName: 'Yoghurt and Granola',
          calories: 350,
          amountG: 200,
        ),
        MealEntryItem(
          id: '2',
          foodName: 'Chicken and Rice',
          calories: 520,
          amountG: 300,
        ),
      ];
      return true;
    });
  }

  // removes a meal entry by id
  Future<void> deleteMeal(String id) async {
    await runAsync(() async {
      // TODO: connect to application layer
      _meals = _meals.where((m) => m.id != id).toList();
      return true;
    });
  }
}
