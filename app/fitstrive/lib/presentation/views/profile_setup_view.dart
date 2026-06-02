import 'dart:ffi';

import 'package:fitstrive/application/usecases/get_user_usercase.dart';
import 'package:fitstrive/application/usecases/set_user_usercase.dart';
import 'package:flutter/material.dart';
import '../models/temp_profile_data.dart';

class ProfileSetupView extends StatefulWidget {
  const ProfileSetupView({
    super.key,
    required this.getUserUsecase,
    required this.setUserUsecase,
  });

  final GetUserUsercase getUserUsecase;
  final SetUserUsercase setUserUsecase;
  @override
  State<ProfileSetupView> createState() => _ProfileSetupViewState(
    getUserUsecase: getUserUsecase,
    setUserUsecase: setUserUsecase,
  );
}

class _ProfileSetupViewState extends State<ProfileSetupView> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _lengthController = TextEditingController();

  final GetUserUsercase getUserUsecase;
  final SetUserUsercase setUserUsecase;
  String? _selectedGender;

  _ProfileSetupViewState({
    required this.getUserUsecase,
    required this.setUserUsecase,
  });
  final List<String> _genderOptions = ['Male', 'Female'];

  void _saveProfile() {
    if (_nameController.text.isEmpty ||
        _ageController.text.isEmpty ||
        _countryController.text.isEmpty ||
        _selectedGender == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill out all fields to continue!')),
      );
      return;
    }

    TempProfileData.name = _nameController.text;
    TempProfileData.age = _ageController.text;
    TempProfileData.gender = _selectedGender!;
    TempProfileData.country = _countryController.text;

    FocusScope.of(context).unfocus();

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Welcome, ' + TempProfileData.name + '! Profile saved.',
          ),
        ),
      );

      Navigator.pushReplacementNamed(context, '/daily-intake-stats');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Complete Your Profile'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Tell us about yourself!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),

            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Full Name',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
            ),
            SizedBox(height: 15),

            TextField(
              controller: _ageController,
              decoration: InputDecoration(
                labelText: 'Age',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.cake),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),

            DropdownButtonFormField<String>(
              value: _selectedGender,
              decoration: InputDecoration(
                labelText: 'Gender',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.people),
              ),
              items: _genderOptions.map((String gender) {
                return DropdownMenuItem<String>(
                  value: gender,
                  child: Text(gender),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedGender = newValue;
                });
              },
            ),
            SizedBox(height: 16),

            TextField(
              controller: _countryController,
              decoration: InputDecoration(
                labelText: 'Country',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.public),
              ),
            ),
            SizedBox(height: 32),

            ElevatedButton(
              onPressed: _saveProfile,

              child: Text('Save & Continue', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
