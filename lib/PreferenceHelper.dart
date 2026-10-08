import 'package:shared_preferences/shared_preferences.dart';

class Preferencehelper {
  static const String _keyUsername = 'username';
  static const String _keyIsDarkMode = 'is_dark_mode';
  static const String _keyUserAge = 'user_age';

  static Future<void> saveData({
    required String username,
    required bool isDarkMode,
    required int age,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyUsername, username);
    await prefs.setBool(_keyIsDarkMode, isDarkMode);
    await prefs.setInt(_keyUserAge, age); 
  }
  static Future<String?> getUsername()async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyUsername);
  }
  static Future<bool> getDarkMode()async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyIsDarkMode) ?? false;
  }
  static Future<int?> getUserAge()async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_keyUserAge);
  }

  static Future<void> clearData() async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}