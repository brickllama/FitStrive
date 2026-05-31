import 'package:flutter/material.dart';


class GoalsSetupView extends StatefulWidget {
  const GoalsSetupView({super.key});

  @override
  State<GoalsSetupView> createState() => _GoalsSetupViewState();
}

class _GoalsSetupViewState extends State<GoalsSetupView> {
  final TextEditingController _weightController = TextEditingController();
  
  String _goalType = 'Lose Weight'; 
  DateTime? _deadlineDate;
  
  int _dailyCalorieDeficit = 0;
  int _daysRemaining = 0;

  // open the calendar popup
  void _pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(Duration(days: 30)),
      firstDate: DateTime.now().add(Duration(days: 1)),
      lastDate: DateTime.now().add(Duration(days: 730)),
    );

    if (picked != null) {
      setState(() {
        _deadlineDate = picked;
        _calculateMath();
      });
    }
  }

  void _calculateMath() {
    final weightText=_weightController.text;
    if (weightText.isEmpty || _deadlineDate == null) {
      setState(() {
        _dailyCalorieDeficit=0;
        _daysRemaining=0;
      });
      return;
    }

    final targetWeightAmount = double.tryParse(weightText) ?? 0;

    final days = _deadlineDate!.difference(DateTime.now()).inDays;
    
    if (days> 0) {
      final totalCaloriesToBurn = targetWeightAmount * 7700;
      
      setState(() {
        _daysRemaining = days;
        _dailyCalorieDeficit= (totalCaloriesToBurn / days).round();
      });
    }
  }

  void _saveGoal() {
    if (_dailyCalorieDeficit == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter weight and pick a date!')),
      );
      return;
    }

    FocusScope.of(context).unfocus();
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Goal saved! You need a deficit of ' + _dailyCalorieDeficit.toString() + ' kcal per day.')),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Set a Goal'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'What is your target?',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 15),
            
            DropdownButtonFormField<String>(
              value: _goalType,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
              items: ['Lose Weight', 'Gain Weight'].map((String type) {
                return DropdownMenuItem<String>(
                  value: type,
                  child: Text(type),
                );
              }).toList(),
              onChanged: (String? newVal) {
                setState(() {
                  _goalType = newVal!;
                });
              },
            ),
            SizedBox(height: 16),

            TextField(
              controller: _weightController,
              decoration: InputDecoration(
                labelText: 'Amount (in kg)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.monitor_weight),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) => _calculateMath(),
            ),
            SizedBox(height: 32),

            Text(
              'When is your deadline?',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 15),

            InkWell(
              onTap: _pickDate,
              child: InputDecorator(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.calendar_month),
                ),
                child: Text(
                  _deadlineDate == null 
                      ? 'Tap to select a date' 
                      : _deadlineDate!.year.toString() + '-' + _deadlineDate!.month.toString() + '-' + _deadlineDate!.day.toString(),
                  style: TextStyle(
                    fontSize: 16,
                    color: _deadlineDate == null ? Colors.grey.shade600 : Colors.black87,
                  ),
                ),
              ),
            ),
            SizedBox(height: 32),

            if (_dailyCalorieDeficit > 0)
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Text('Your Target Plan', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 16),
                    Text(
                      'You have ' + _daysRemaining.toString() + ' days to reach your goal.',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Target Daily Deficit:',
                      style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
                    ),
                    Text(
                      _dailyCalorieDeficit.toString() + ' kcal / day',
                      style: TextStyle(
                        fontSize: 28, 
                        fontWeight: FontWeight.bold, 
                        color: Theme.of(context).colorScheme.onPrimaryContainer
                      ),
                    ),
                  ],
                ),
              ),
            
            SizedBox(height: 32),

            ElevatedButton(
              onPressed: _saveGoal,
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
              child: Text('Save Goal', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}