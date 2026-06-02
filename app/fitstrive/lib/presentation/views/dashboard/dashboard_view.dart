import 'package:flutter/material.dart';
import '../../models/temp_profile_data.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  DateTime _selectedDate = DateTime.now(); 

  String _getWeekday(int day) {
    List<String> days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[day - 1];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FitStrive Dashboard'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
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

                      TempProfileData.activeDate = date; 
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
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 16,
                children: [
                  _buildMenuCard(context, 'Log Food', Icons.restaurant),
                  _buildMenuCard(context, 'Log Weight', Icons.scale), // Updated to Weight!
                  _buildMenuCard(context, 'My Goals', Icons.flag),
                  _buildMenuCard(context, 'Statistics', Icons.bar_chart),
                  _buildMenuCard(context, 'Profile', Icons.person),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuCard(
    BuildContext context,
    String cardName,
    IconData myIcon,
  ) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () {
          if (cardName == 'Log Food') {
            Navigator.pushNamed(context, '/log-food');
          } else if (cardName == 'Log Weight') {
            Navigator.pushNamed(context, '/log-weight'); // Updated routing!
          } else if (cardName == 'My Goals') {
            Navigator.pushNamed(context, '/my-goals');
          } else if (cardName == 'Statistics') {
            Navigator.pushNamed(context, '/statistics');
          } else if (cardName == 'Profile') {
            Navigator.pushNamed(context, '/profile');
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(cardName + ' screen coming soon!')), 
            );
          }
        },
        borderRadius: BorderRadius.circular(1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              myIcon,
              size: 12,
              color: Theme.of(context).colorScheme.primary,
            ),
            SizedBox(height: 4),
            Text(
              cardName,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
