import 'dart:developer';

import 'package:fitstrive/application/usecases/get_food_item_usecase.dart';
import 'package:fitstrive/application/usecases/log_food_usecase.dart';
import 'package:fitstrive/application/usecases/remove_food_usecase.dart';
import 'package:fitstrive/domain/entities/food_item.dart';
import 'package:flutter/material.dart';

class FoodEntryView extends StatefulWidget {
  final GetFoodItemUsecase getFoodItemUsecase;
  final LogFoodUseCase logFoodUseCase;

  FoodEntryView({
    super.key,
    required this.getFoodItemUsecase,
    required this.logFoodUseCase,
  });

  @override
  State<FoodEntryView> createState() => _FoodEntryViewState(
    getFoodItemUsecase: getFoodItemUsecase,
    logFoodUseCase: logFoodUseCase,
  );
}

class _FoodEntryViewState extends State<FoodEntryView> {
  final TextEditingController _weightController = TextEditingController();
  final GetFoodItemUsecase getFoodItemUsecase;
  final LogFoodUseCase logFoodUseCase;

  _FoodEntryViewState({
    required this.getFoodItemUsecase,
    required this.logFoodUseCase,
  });

  @override
  void initState() {
    super.initState();
    _loadFoodItems();
  }

  String _selectedMeal = 'Breakfast';
  final List<String> _mealOptions = ['Breakfast', 'Lunch', 'Dinner', 'Snack'];

  List<FoodItem> foodData = [];
  FoodItem? _selectedFood;

  bool _isLoadingFoodItems = true;

  String _finalSelectedFood = '';
  double _selectedFoodCaloriesPer100g = 0;
  int _totalCalculatedCalories = 0;

  void _calculateCalories() {
    final weightText = _weightController.text;

    if (weightText.isEmpty || _selectedFoodCaloriesPer100g == 0) {
      setState(() {
        _totalCalculatedCalories = 0;
      });
      return;
    }

    final weightInGrams = double.tryParse(weightText) ?? 0;

    setState(() {
      _totalCalculatedCalories =
          ((weightInGrams / 100) * _selectedFoodCaloriesPer100g).round();
    });
  }

  void _saveFood() async {
    if (_selectedFood == null || _totalCalculatedCalories == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a food and enter its weight!'),
        ),
      );
      return;
    }

    // TODO: call logFoodUseCase.execute here
    await logFoodUseCase.execute(
      calories: double.parse(_totalCalculatedCalories.toString()),
      carbohydrates: _selectedFood!.macronutrients.carbohydrates,
      fats: _selectedFood!.macronutrients.fats,
      proteins: _selectedFood!.macronutrients.proteins,
      date: DateTime.now(),
      foodname: _selectedFood!.foodname.foodname,
      weight: double.parse(_weightController.text),
    );

    FocusScope.of(context).unfocus();

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Logged $_totalCalculatedCalories kcal of $_finalSelectedFood!',
        ),
      ),
    );

    Navigator.pop(context);
  }

  Future<void> _loadFoodItems() async {
    try {
      final foods = await getFoodItemUsecase.execute("");

      if (!mounted) return;

      setState(() {
        foodData = foods;
        log(foodData.length.toString());
        _isLoadingFoodItems = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _isLoadingFoodItems = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not load food items')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Log a Meal')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButtonFormField<String>(
              value: _selectedMeal,
              decoration: InputDecoration(
                labelText: 'Meal Type',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.access_time),
              ),
              items: _mealOptions.map((String meal) {
                return DropdownMenuItem<String>(value: meal, child: Text(meal));
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedMeal = newValue!;
                });
              },
            ),
            SizedBox(height: 15),

            Autocomplete<FoodItem>(
              displayStringForOption: (FoodItem food) => food.foodname.foodname,
              optionsBuilder: (TextEditingValue textEditingValue) {
                if (_isLoadingFoodItems || textEditingValue.text.isEmpty) {
                  return const Iterable<FoodItem>.empty();
                }

                final query = textEditingValue.text.toLowerCase();

                return foodData
                    .where((FoodItem food) {
                      return food.foodname.foodname.toLowerCase().contains(
                        query,
                      );
                    })
                    .take(25);
              },
              onSelected: (FoodItem selection) {
                _selectedFood = selection;
                _finalSelectedFood = selection.foodname.foodname;
                _selectedFoodCaloriesPer100g = selection.calories;

                _calculateCalories();
              },
              fieldViewBuilder:
                  (context, controller, focusNode, onEditingComplete) {
                    return TextField(
                      controller: controller,
                      focusNode: focusNode,
                      onEditingComplete: onEditingComplete,
                      decoration: InputDecoration(
                        labelText: _isLoadingFoodItems
                            ? 'Loading foods...'
                            : 'Search for a food',
                        border: const OutlineInputBorder(),
                        prefixIcon: const Icon(Icons.search),
                      ),
                    );
                  },
            ),
            const SizedBox(height: 16),

            // weight input
            TextField(
              controller: _weightController,
              decoration: const InputDecoration(
                labelText: 'Weight (in grams)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.scale),
                suffixText: 'g',
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) => _calculateCalories(),
            ),
            const SizedBox(height: 32),

            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Text(
                    'Total Calories',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _totalCalculatedCalories.toString() + ' kcal',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            ElevatedButton(
              onPressed: _saveFood,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              child: Text('Save Meal', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
