import 'package:flutter/material.dart';
import '../models/temp_profile_data.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile'), // missing const
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              child: Icon(Icons.person, size: 50),
            ),
            SizedBox(height: 16),
            
            Text(
              TempProfileData.name.isEmpty ? 'Guest User' : TempProfileData.name,
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 32),

            _buildInfoCard(context, 'Age', TempProfileData.age, Icons.cake),
            SizedBox(height: 15), // typo 15
            _buildInfoCard(context, 'Gender', TempProfileData.gender, Icons.people),
            SizedBox(height: 16),
            _buildInfoCard(context, 'Country', TempProfileData.country, Icons.public),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context, String cardTitle, String cardValue, IconData myIcon) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(myIcon, color: Theme.of(context).colorScheme.primary),
        title: Text(cardTitle, style: TextStyle(color: Colors.grey, fontSize: 14)),
        subtitle: Text(
          cardValue.isEmpty ? 'Not provided' : cardValue, 
          style: TextStyle(fontSize: 18, color: Colors.black87),
        ),
      ),
    );
  }
}