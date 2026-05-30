import 'package:fitstrive/application/usecases/login_usecase.dart';
import 'package:fitstrive/application/usecases/register_usecase.dart';
import 'package:fitstrive/data/datasources/remote_user_datasource_impl.dart';
import 'package:fitstrive/data/datasources/user_local_source.dart';
import 'package:fitstrive/data/repositories/user_repository_impl.dart';
import 'package:fitstrive/features/food_tracking/data/datasources/food_local_data_source.dart';
import 'package:fitstrive/presentation/viewmodels/auth/login_viewmodel.dart';
import 'package:fitstrive/presentation/viewmodels/auth/register_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'core/database/fitstrive_database.dart';
import 'presentation/presentation.dart';

void main() async {
  await dotenv.load(fileName: 'config/.env');

  final db = AppDatabase();
  final foodLocalDataSource = FoodLocalDataSourceImpl(db);
  final userLocalSource = UserLocalSourceImpl(db);
  final remoteUserDataSource = RemoteUserDatasourceImpl();
  final userRepository = UserRepositoryImpl(
    localSource: userLocalSource,
    remoteSource: remoteUserDataSource,
  );
  final loginUseCase = LoginUseCase(userRepository);
  final registerUseCase = RegisterUseCase(userRepository);

  runApp(FitStriveApp(
    loginUseCase: loginUseCase,
    registerUseCase: registerUseCase,
    foodLocalDataSource: foodLocalDataSource,
  ));
}

class FitStriveApp extends StatelessWidget {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final FoodLocalDataSourceImpl foodLocalDataSource;

  const FitStriveApp({
    super.key,
    required this.loginUseCase,
    required this.registerUseCase,
    required this.foodLocalDataSource,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => LoginViewModel(loginUseCase: loginUseCase),
        ),
        ChangeNotifierProvider(
          create: (_) => RegisterViewModel(registerUseCase: registerUseCase),
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
        },
      ),
    );
  }
}