import 'package:flutter/material.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FitStrive Dashboard'),
        // This removes the "back" arrow so they can't accidentally go back to the login screen
        automaticallyImplyLeading: false, 
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // Logs them out and sends them back to the login screen
              Navigator.pushReplacementNamed(context, '/login');
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2, // Creates a 2-column grid
          crossAxisSpacing: 16,
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

  // A custom widget to make identical, nice-looking buttons
  Widget _buildMenuCard(BuildContext context, String title, IconData icon) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () {
          // For now, this just pops up a message. We will connect real screens later!
          if (title == 'Log Food') {
            Navigator.pushNamed(context, '/log-food');
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('$title screen coming soon!')),
            );
          }
        },
        borderRadius: BorderRadius.circular(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: Theme.of(context).colorScheme.primary),
            const SizedBox(height: 16),
            Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}