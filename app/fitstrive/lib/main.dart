import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';
import 'core/database/fitstrive_database.dart';
import 'presentation/presentation.dart';

void main() async {
  await dotenv.load(fileName: 'config/.env');
  AppDatabase db = AppDatabase();

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
        '/daily-intake-stats': (_) => const DailyIntakeView(),
      },
    );
  }
}
