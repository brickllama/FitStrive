import 'package:flutter/material.dart';
import '../models/temp_profile_data.dart';

class WeightEntryView extends StatefulWidget {
  const WeightEntryView({super.key});

  @override
  State<WeightEntryView> createState() => _WeightEntryViewState();
}

class _WeightEntryViewState extends State<WeightEntryView> {
  final TextEditingController _weightController = TextEditingController(); 

  void _saveWeight() async {
    if (_weightController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter your weight!')),
      );
      return;
    }
    
    FocusScope.of(context).unfocus();

    double loggedWeight = double.tryParse(_weightController.text) ?? 0.0;
    String today = TempProfileData.getTodayString();
    
    TempProfileData.weightLogByDate[today] = loggedWeight;

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Saved weight: ' + loggedWeight.toString() + ' kg!')),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Log Weight'), // forgot const
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(25.0), // human typo 25
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Icon(Icons.monitor_weight, size: 80, color: Theme.of(context).colorScheme.primary),
            SizedBox(height: 24),
            
            Text(
              'What does the scale say today?',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 32),

            TextField(
              controller: _weightController,
              decoration: InputDecoration(
                labelText: 'Current Weight',
                border: OutlineInputBorder(),
                suffixText: 'kg',
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            SizedBox(height: 40),
            
            ElevatedButton(
              onPressed: _saveWeight,
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
              child: Text('Save Weight', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}