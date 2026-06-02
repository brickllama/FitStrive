import 'package:fitstrive/application/usecases/add_food_item_usecase.dart';
import 'package:fitstrive/application/usecases/get_food_item_usecase.dart';
import 'package:fitstrive/application/usecases/get_foods_usecase.dart';
import 'package:fitstrive/application/usecases/log_food_usecase.dart';
import 'package:fitstrive/application/usecases/login_usecase.dart';
import 'package:fitstrive/application/usecases/register_usecase.dart';
import 'package:fitstrive/application/usecases/remove_food_item_usecase.dart';
import 'package:fitstrive/data/datasources/food_item_local_source.dart';
import 'package:fitstrive/data/datasources/food_log_local_source.dart';

import 'package:fitstrive/data/datasources/remote_user_datasource_impl.dart';
import 'package:fitstrive/data/datasources/user_health_local_source.dart';
import 'package:fitstrive/data/datasources/user_local_source.dart';
import 'package:fitstrive/data/repositories/food_item_repository_impl.dart';
import 'package:fitstrive/data/repositories/food_log_repository_impl.dart';
import 'package:fitstrive/data/repositories/user_health_repository_impl.dart';
import 'package:fitstrive/data/repositories/user_repository_impl.dart';
import 'package:fitstrive/domain/repository/food_item_repository.dart';
import 'package:fitstrive/domain/repository/food_log_repository.dart';
import 'package:fitstrive/domain/repository/user_health_repository.dart';
import 'package:fitstrive/presentation/viewmodels/auth/login_viewmodel.dart';
import 'package:fitstrive/presentation/viewmodels/auth/register_viewmodel.dart';
import 'package:fitstrive/presentation/viewmodels/daily_intake_stats/daily_intake_stats_viewmodel.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/database/fitstrive_database.dart';
import 'presentation/presentation.dart';
import 'presentation/views/dashboard/dashboard_view.dart';
import 'presentation/views/food_entry_view.dart';
import 'presentation/views/profile_setup_view.dart';
import 'presentation/views/profile_view.dart';
import 'presentation/views/weight_entry_view.dart';
import 'presentation/views/goals_setup_view.dart';
import 'presentation/views/statistics_view.dart';

void main() async {
  await dotenv.load(fileName: 'config/.env');
  AppDatabase db = AppDatabase();
  final remoteUserDataSource = RemoteUserDatasourceImpl();
  final userLocalSource = UserLocalSourceImpl(db);

  final FoodLogLocalSource foodLogLocalSource = FoodLogLocalSourceImpl(db);
  final FoodItemLocalSource foodItemLocalSource = FoodItemLocalSourceImpl(db);
  final UserHealthLocalSource userHealthLocalSource = UserHealthLocalSourceImpl(
    db,
  );

  final userRepository = UserRepositoryImpl(
    localSource: userLocalSource,
    remoteSource: remoteUserDataSource,
  );

  final FoodLogRepository foodLogRepository = FoodLogRepositoryImpl(
    foodLogLocalSource,
  );

  final FoodItemRepository foodItemRepository = FoodItemRepositoryImpl(
    foodItemLocalSource,
  );
  final UserHealthRepository userHealthRepository = UserHealthRepositoryImpl(
    userHealthLocalSource,
  );

  final loginUseCase = LoginUseCase(userRepository);
  final registerUseCase = RegisterUseCase(userRepository);

  // Food Log.
  final getFoodsUsecase = GetFoodsUsecase(foodLogRepository);
  final addFoodUsecase = LogFoodUseCase(foodLogRepository);
  // Food Items
  final AddFoodItemUsecase addFoodItemUsecase = AddFoodItemUsecase(
    foodItemRepository,
  );
  final RemoveFoodItemUsecase removeFoodItemUsecase = RemoveFoodItemUsecase(
    foodItemRepository,
  );
  final GetFoodItemUsecase getFoodItemUsecase = GetFoodItemUsecase(
    foodItemRepository,
  );

  runApp(
    FitStriveApp(
      loginUseCase: loginUseCase,
      registerUseCase: registerUseCase,
      getfoodUsecase: getFoodsUsecase,
      logfoodUsecase: addFoodUsecase,
      addFoodItemUsecase: addFoodItemUsecase,
      removeFoodItemUsecase: removeFoodItemUsecase,
      getFoodItemUsecase: getFoodItemUsecase,
    ),
  );
}

class FitStriveApp extends StatelessWidget {
  const FitStriveApp({
    super.key,
    required this.loginUseCase,
    required this.registerUseCase,
    required this.getfoodUsecase,
    required this.logfoodUsecase,
    required this.addFoodItemUsecase,
    required this.removeFoodItemUsecase,
    required this.getFoodItemUsecase,
  });

  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final GetFoodsUsecase getfoodUsecase;
  final LogFoodUseCase logfoodUsecase;
  final AddFoodItemUsecase addFoodItemUsecase;
  final RemoveFoodItemUsecase removeFoodItemUsecase;
  final GetFoodItemUsecase getFoodItemUsecase;

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
        ChangeNotifierProvider(
          create: (_) => DailyIntakeViewModel(getFoodsUsecase: getfoodUsecase),
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
          '/log-food': (_) => FoodEntryView(
            getFoodItemUsecase: getFoodItemUsecase,
            logFoodUseCase: logfoodUsecase,
          ),
          '/log-weight': (_) => const WeightEntryView(),
          '/my-goals': (_) => const GoalsSetupView(),
          '/statistics': (_) => const StatisticsView(),
          '/setup-profile': (_) => const ProfileSetupView(),
          '/profile': (_) => const ProfileView(),
        },
      ),
    );
  }
}
