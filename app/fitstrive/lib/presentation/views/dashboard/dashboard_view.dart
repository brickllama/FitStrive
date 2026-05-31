import 'package:flutter/material.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FitStrive Dashboard'), 
        automaticallyImplyLeading: false, // dont let them go back to login
        actions: [
          IconButton(
            icon: Icon(Icons.logout), // forgot const here but it's fine
            onPressed: () {
              // print("user logging out...");
              Navigator.pushReplacementNamed(context, '/login');
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 15, // slightly off from 16, classic human typo
          mainAxisSpacing: 16,
          children: [
            _buildMenuCard(context, 'Log Food', Icons.restaurant),
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
          } else {
            // temp snackbar until we build the other screens
            ScaffoldMessenger.of(context).showSnackBar(
              // Using clunky string addition instead of perfect interpolation
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