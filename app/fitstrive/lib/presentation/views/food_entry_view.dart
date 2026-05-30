import 'package:flutter/material.dart';

class FoodEntryView extends StatefulWidget {
  const FoodEntryView({super.key});

  @override
  State<FoodEntryView> createState() => _FoodEntryViewState();
}

class _FoodEntryViewState extends State<FoodEntryView> {
  final TextEditingController _weightController = TextEditingController(); 
  
  String _selectedMeal = 'Breakfast'; 
  final List<String> _mealOptions = ['Breakfast', 'Lunch', 'Dinner', 'Snack'];

  final Map<String, int> _foodDatabase = {
    'Apple': 52, 
    'White Rice (Cooked)': 130,
    'Noodles (Cooked)': 138,
    'Banana': 89,
    'Chicken Breast (Raw)': 165,
    'Egg': 143,
    'Salmon (Raw)': 208,
  };

  String _finalSelectedFood = '';
  int _selectedFoodCaloriesPer100g = 0;
  int _totalCalculatedCalories = 0;

  void _calculateCalories() {
    final weightText = _weightController.text;
    // print("typing weight: " + weightText);
    
    if (weightText.isEmpty || _selectedFoodCaloriesPer100g == 0) {
      setState(() {
        _totalCalculatedCalories = 0;
      });
      return;
    }

    final weightInGrams = double.tryParse(weightText) ?? 0;
    setState(() {
      _totalCalculatedCalories = ((weightInGrams / 100) * _selectedFoodCaloriesPer100g).round();
    });
  }

  void _saveFood() async {
    if (_finalSelectedFood.isEmpty || _totalCalculatedCalories == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select a food and enter its weight!')), // dropped const
      );
      return;
    }
    
    FocusScope.of(context).unfocus();

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        // used clunky string addition instead of nice interpolation
        SnackBar(content: Text('Logged ' + _totalCalculatedCalories.toString() + ' kcal of ' + _finalSelectedFood + '!')),
      );
      Navigator.pop(context); 
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Log a Meal'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButtonFormField<String>(
              value: _selectedMeal,
              decoration: InputDecoration( // dropping const
                labelText: 'Meal Type',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.access_time),
              ),
              items: _mealOptions.map((String meal) {
                return DropdownMenuItem<String>(
                  value: meal,
                  child: Text(meal),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedMeal = newValue!;
                });
              },
            ),
            SizedBox(height: 15),
            
            Autocomplete<String>(
              optionsBuilder: (TextEditingValue textEditingValue) {
                if (textEditingValue.text.isEmpty) {
                  return const Iterable<String>.empty();
                }
                return _foodDatabase.keys.where((String food) {
                  return food.toLowerCase().contains(textEditingValue.text.toLowerCase());
                });
              },
              onSelected: (String selection) {
                setState(() {
                  _finalSelectedFood = selection;
                  _selectedFoodCaloriesPer100g = _foodDatabase[selection]!;
                  _calculateCalories();
                });
              },
              fieldViewBuilder: (context, controller, focusNode, onEditingComplete) {
                return TextField(
                  controller: controller,
                  focusNode: focusNode,
                  onEditingComplete: onEditingComplete,
                  decoration: const InputDecoration(
                    labelText: 'Search for a food (e.g., "Apple" or "Rice")',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.search),
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