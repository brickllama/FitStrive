import 'package:flutter_dotenv/flutter_dotenv.dart';

final class AppConfig {
  static String get apiUrl => dotenv.get('API_URL');
}
