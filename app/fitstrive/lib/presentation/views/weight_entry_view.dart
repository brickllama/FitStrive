import 'package:flutter/material.dart';
import '../models/temp_profile_data.dart';

class WeightEntryView extends StatefulWidget {
  const WeightEntryView({super.key});

  @override
  State<WeightEntryView> createState() => _WeightEntryViewState();
}

class _WeightEntryViewState extends State<WeightEntryView> {
  final TextEditingController _weightController = TextEditingController(); 
  
  // NEW: Keep track of the date locally on this screen!
  DateTime _selectedDate = DateTime.now();

  String _getWeekday(int day) {
    List<String> days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[day - 1];
  }

  void _saveWeight() async {
    if (_weightController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter your weight!')), 
      );
      return;
    }
    
    FocusScope.of(context).unfocus();

    double loggedWeight = double.tryParse(_weightController.text) ?? 0.0;

    String dateString = _selectedDate.year.toString() + '-' + _selectedDate.month.toString() + '-' + _selectedDate.day.toString();
    TempProfileData.weightLogByDate[dateString] = loggedWeight;

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Saved ' + loggedWeight.toString() + ' kg for ' + dateString + '!')),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Log Weight'), 
      ),
      body: Column(
        children: [

          Container(
            height: 90,
            padding: EdgeInsets.symmetric(vertical: 10), 
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 14, 
              itemBuilder: (context, index) {
                DateTime date = DateTime.now().subtract(Duration(days: 7 - index));
                bool isSelected = date.day == _selectedDate.day && date.month == _selectedDate.month;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedDate = date;
                    });
                  },
                  child: Container(
                    width: 60,
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      color: isSelected ? Theme.of(context).colorScheme.primary : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(15), 
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _getWeekday(date.weekday),
                          style: TextStyle(
                            fontSize: 14,
                            color: isSelected ? Colors.white : Colors.grey.shade700,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          date.day.toString(),
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: isSelected ? Colors.white : Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(25.0), 
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Icon(Icons.monitor_weight, size: 80, color: Theme.of(context).colorScheme.primary),
                  SizedBox(height: 24),
                  
                  Text(
                    'What is your weight today?',
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
          ),
        ],
      ),
    );
  }
}