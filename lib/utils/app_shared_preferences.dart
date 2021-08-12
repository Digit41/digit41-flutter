import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPreferences {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  void setTheme(String the) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setString('theme', the);
  }

  Future<String?> getTheme() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString('theme');
  }

  void setLanguageCode(String lan) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setString('language', lan);
  }

  Future<String?> getLanguageCode() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString('language');
  }

  void saveCurrency(String currencyKey) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setString('currencyKey', currencyKey);
  }

  Future<String?> getCurrencyKey() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString('currencyKey');
  }

  void setPasscode(String? pass) async {
    final SharedPreferences prefs = await _prefs;
    if (pass == null)
      await prefs.remove('passcode');
    else
      await prefs.setString('passcode', pass);
  }

  Future<String?> getPasscode() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString('passcode');
  }
}
