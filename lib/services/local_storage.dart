import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  SharedPreferences? prefs;

  setString(String key, String val) async {
    prefs = await SharedPreferences.getInstance();
    prefs!.setString(key, val);
  }

  getString(String key) async {
    prefs = await SharedPreferences.getInstance();
    return prefs!.getString(key);
  }

    setBool(String key, bool val) async {
    prefs = await SharedPreferences.getInstance();
    prefs!.setBool(key, val);
  }

  getBool(String key) async {
    prefs = await SharedPreferences.getInstance();
    return prefs!.getBool(key);
  }

  clearPref() async {
    prefs = await SharedPreferences.getInstance();
    return prefs!.clear();
  }
}
