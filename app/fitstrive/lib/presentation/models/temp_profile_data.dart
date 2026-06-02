// temporary data holder until we hook up sqflite
class TempProfileData {
  static String name = '';
  static String age = '';
  static String gender = '';
  static String country = '';
  static int dailyCalorieDeficit = 0;
  static double targetDailyWeightDeficit = 0.0;
  static String goalType = ''; 
  static double totalTargetAmount = 0.0;
  static String deadlineDate = '';

  static Map<String, int> foodLogByDate = {};
  static Map<String, double> weightLogByDate = {};
  static DateTime activeDate = DateTime.now();

  static String getTodayString() {
    return activeDate.year.toString() + '-' + activeDate.month.toString() + '-' + activeDate.day.toString();
  }
}