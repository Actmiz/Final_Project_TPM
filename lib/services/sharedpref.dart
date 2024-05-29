import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static const String _emailKey = 'email';
  static const String _passwordKey = 'password';
  static const String _dobKey = 'date_of_birth';
  static const String _nameKey = 'name';

  static Future<void> saveEmail(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_emailKey, email);
  }

  static Future<String?> getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_emailKey);
  }

  static Future<void> savePassword(String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_passwordKey, password);
  }

  static Future<String?> getPassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_passwordKey);
  }

  static Future<void> saveDateOfBirth(String dob) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_dobKey, dob);
  }

  static Future<String?> getDateOfBirth() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_dobKey);
  }

  static Future<void> saveName(String dob) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_nameKey, dob);
  }

  static Future<String?> getName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_nameKey);
  }

  static Future<void> removeEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_emailKey);
  }

  static Future<void> removePassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_passwordKey);
  }
}
