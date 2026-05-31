import 'package:flutter/material.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

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
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 16,
          children: [
            _buildMenuCard(context, 'Log Food', Icons.restaurant),
            _buildMenuCard(context, 'Log Exercise', Icons.fitness_center),
            _buildMenuCard(context, 'My Goals', Icons.flag),
            _buildMenuCard(context, 'Statistics', Icons.bar_chart),
            _buildMenuCard(context, 'Profile', Icons.person),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuCard(BuildContext context, String cardName, IconData myIcon) {
    return Card(
      elevation: 4.0, 
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () {
          if (cardName == 'Log Food') {
            Navigator.pushNamed(context, '/log-food');
          } else if (cardName == 'Log Exercise') {
            Navigator.pushNamed(context, '/log-exercise');
          } else if (cardName == 'My Goals') {
            Navigator.pushNamed(context, '/my-goals');
          } else if (cardName == 'Profile') {

            Navigator.pushNamed(context, '/profile');
          } else {

            ScaffoldMessenger.of(context).showSnackBar(

              SnackBar(content: Text(cardName + ' screen coming soon!')), 
            );
          }
        },
        borderRadius: BorderRadius.circular(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(myIcon, size: 48, color: Theme.of(context).colorScheme.primary),
            SizedBox(height: 16), 
            Text(cardName, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}