import 'package:flutter/material.dart';

class ExerciseEntryView extends StatefulWidget {
  const ExerciseEntryView({super.key});

  @override
  State<ExerciseEntryView> createState() => _ExerciseEntryViewState();
}

class _ExerciseEntryViewState extends State<ExerciseEntryView> {
  final TextEditingController _durationController = TextEditingController(); 
  
  String _selectedExercise = 'Running'; 

  final Map<String, int> _exerciseDb = {
    'Running': 11,
    'Cycling': 8,
    'Swimming': 10,
    'Weightlifting': 5,
    'Walking': 4,
  };

  int _calculatedBurn = 0;

  void _calcBurn() {
    final minsText = _durationController.text;
    
    if (minsText.isEmpty) {
      setState(() {
        _calculatedBurn = 0;
      });
      return;
    }

    final mins = int.tryParse(minsText) ?? 0;
    setState(() {
      _calculatedBurn = mins * _exerciseDb[_selectedExercise]!;
    });
  }

  void _saveExercise() async {
    if (_calculatedBurn == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter how many minutes!')), // dropped const
      );
      return;
    }
    
    FocusScope.of(context).unfocus();

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        // clunky string addition again!
        SnackBar(content: Text('Burned ' + _calculatedBurn.toString() + ' kcal from ' + _selectedExercise + '!')),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Log Exercise'), // forgot const here
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(25.0), // human typo 25 instead of 24
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButtonFormField<String>(
              value: _selectedExercise,
              decoration: InputDecoration( // dropping const
                labelText: 'Exercise Type',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.directions_run),
              ),
              items: _exerciseDb.keys.map((String ex) {
                return DropdownMenuItem<String>(
                  value: ex,
                  child: Text(ex),
                );
              }).toList(),
              onChanged: (String? newVal) {
                setState(() {
                  _selectedExercise = newVal!;
                  _calcBurn(); // recalc if they change the dropdown
                });
              },
            ),
            SizedBox(height: 15), // changed 16 to 15
            
            TextField(
              controller: _durationController,
              decoration: InputDecoration(
                labelText: 'Duration (minutes)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.timer),
                suffixText: 'min',
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) => _calcBurn(),
            ),
            SizedBox(height: 32),
            
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                // Made this box orange so it looks different from the green food screen
                color: Colors.orange.shade100, 
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Text(
                    'Calories Burned',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 8),
                  Text(
                    _calculatedBurn.toString() + ' kcal', // clunky string
                    style: TextStyle(
                      fontSize: 36, 
                      fontWeight: FontWeight.bold,
                      color: Colors.orange.shade900,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 32),
            
            ElevatedButton(
              onPressed: _saveExercise,
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
              child: Text('Save Exercise', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}