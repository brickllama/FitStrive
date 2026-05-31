import 'package:fitstrive/features/food_tracking/data/datasources/food_local_data_source.dart';
import 'package:flutter/material.dart';
import 'core/database/fitstrive_database.dart';
import 'presentation/presentation.dart';
import 'presentation/views/dashboard/dashboard_view.dart';
import 'presentation/views/food_entry_view.dart';
import 'presentation/views/profile_setup_view.dart';
import 'presentation/views/profile_view.dart';
import 'presentation/views/exercise_entry_view.dart';
import 'presentation/views/goals_setup_view.dart';



void main() {
  AppDatabase db = AppDatabase();
  FoodLocalDataSourceImpl foodLocalDataSourceImpl = FoodLocalDataSourceImpl(db);
  runApp(const FitStriveApp());
}

class FitStriveApp extends StatelessWidget {
  const FitStriveApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FitStrive',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF00C853)),
        fontFamily: 'Roboto',
      ),
      home: const LaunchView(),
      routes: {
        '/launch': (_) => const LaunchView(),
        '/login': (_) => const LoginView(),
        '/register': (_) => const RegisterView(),
        '/forgot-password': (_) => const ForgotPasswordView(),
        '/dashboard': (_) => const DashboardView(),
        '/log-food': (_) => const FoodEntryView(),
        '/log-exercise': (_) => const ExerciseEntryView(),
        '/my-goals': (_) => const GoalsSetupView(),
        '/setup-profile': (_) => const ProfileSetupView(),
        '/profile': (_) => const ProfileView(),

      },
    );
  }
}