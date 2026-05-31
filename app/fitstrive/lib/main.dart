import 'package:fitstrive/application/usecases/login_usecase.dart';
import 'package:fitstrive/application/usecases/register_usecase.dart';

import 'package:fitstrive/data/datasources/remote_user_datasource_impl.dart';
import 'package:fitstrive/data/datasources/user_local_source.dart';
import 'package:fitstrive/data/repositories/user_repository_impl.dart';
import 'package:fitstrive/presentation/viewmodels/auth/login_viewmodel.dart';
import 'package:fitstrive/presentation/viewmodels/auth/register_viewmodel.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/database/fitstrive_database.dart';
import 'presentation/presentation.dart';
import 'presentation/views/dashboard/dashboard_view.dart';
import 'presentation/views/food_entry_view.dart';
import 'presentation/views/profile_setup_view.dart';
import 'presentation/views/profile_view.dart';

void main() async {
  await dotenv.load(fileName: 'config/.env');
  AppDatabase db = AppDatabase();
  final remoteUserDataSource = RemoteUserDatasourceImpl();
  final userLocalSource = UserLocalSourceImpl(db);

  final userRepository = UserRepositoryImpl(
    localSource: userLocalSource,
    remoteSource: remoteUserDataSource,
  );
  final loginUseCase = LoginUseCase(userRepository);
  final registerUseCase = RegisterUseCase(userRepository);

  runApp(
    FitStriveApp(loginUseCase: loginUseCase, registerUseCase: registerUseCase),
  );
}

class FitStriveApp extends StatelessWidget {
  const FitStriveApp({
    super.key,
    required this.loginUseCase,
    required this.registerUseCase,
  });
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => LoginViewModel(loginUseCase: loginUseCase),
        ),
        ChangeNotifierProvider(
          create: (_) =>
              RegisterViewModel(registrationUseCase: registerUseCase),
        ),
      ],
      child: MaterialApp(
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
          '/dashboard': (_) => const DashboardView(),
          '/log-food': (_) => const FoodEntryView(),
          '/setup-profile': (_) => const ProfileSetupView(),
          '/profile': (_) => const ProfileView(),
        },
      ),
    );
  }
}
