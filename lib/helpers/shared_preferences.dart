import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  final String key = 'logged-in';
  void loggedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, true);
  }

  void logOut() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  Future<bool> appState() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool? isLoggedIn = prefs.getBool(key);

    if (isLoggedIn == null) {
      return false;
    }
    return isLoggedIn;
  }
}
