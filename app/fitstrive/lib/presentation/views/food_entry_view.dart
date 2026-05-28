import 'package:flutter/material.dart';

class FoodEntryView extends StatefulWidget {
  const FoodEntryView({super.key});

  @override
  State<FoodEntryView> createState() => _FoodEntryViewState();
}

class _FoodEntryViewState extends State<FoodEntryView> {
  // New controller just for the weight input
  final TextEditingController _weightController = TextEditingController(); 
  
  String _selectedMeal = 'Breakfast'; 
  final List<String> _mealOptions = ['Breakfast', 'Lunch', 'Dinner', 'Snack'];

  // 1. The Upgraded Database: Calories per 100 grams
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

  // 2. The Calculator Engine
  // This runs every time the user types a new weight or picks a new food
  void _calculateCalories() {
    final weightText = _weightController.text;
    
    // If they haven't typed a weight or picked a food, reset to 0
    if (weightText.isEmpty || _selectedFoodCaloriesPer100g == 0) {
      setState(() {
        _totalCalculatedCalories = 0;
      });
      return;
    }

    // Convert their text into a decimal number
    final weightInGrams = double.tryParse(weightText) ?? 0;
    
    // The Math: (Weight / 100) * Calories per 100g
    setState(() {
      _totalCalculatedCalories = ((weightInGrams / 100) * _selectedFoodCaloriesPer100g).round();
    });
  }

  void _saveFood() async {
    if (_finalSelectedFood.isEmpty || _totalCalculatedCalories == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a food and enter its weight!')),
      );
      return;
    }

    FocusScope.of(context).unfocus();

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Logged $_totalCalculatedCalories kcal of $_finalSelectedFood!')),
      );
      Navigator.pop(context); 
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log a Meal'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButtonFormField<String>(
              value: _selectedMeal,
              decoration: const InputDecoration(
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
            const SizedBox(height: 16),
            
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
                  // Look up the baseline calories and run the math!
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
            
            // 3. The New Weight Input Field
            TextField(
              controller: _weightController,
              decoration: const InputDecoration(
                labelText: 'Weight (in grams)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.scale),
                suffixText: 'g',
              ),
              keyboardType: TextInputType.number,
              // Run the math every single time they press a key!
              onChanged: (value) => _calculateCalories(),
            ),
            const SizedBox(height: 32),
            
            // 4. The Live Results Display
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  const Text(
                    'Total Calories',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '$_totalCalculatedCalories kcal',
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
              child: const Text('Save Meal', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}