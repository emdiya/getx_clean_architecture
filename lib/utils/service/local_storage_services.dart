import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static SharedPreferences? _prefs;

  static Future<bool?> getBooleanValue(String key) async {
    return (_prefs!.getBool(key));
  }

  static Future<double> getDoubleValue(String key) async {
    return (_prefs!.getDouble(key) ?? 0.0);
  }

  // function for get data from local storage

  static Future<int> getIntValue(String key) async {
    return (_prefs!.getInt(key) ?? 0);
  }

  static Future<String> getStringValue(String key) async {
    return (_prefs!.getString(key) ?? "");
  }

  // initial SharedPreferences

  static Future<SharedPreferences> init() async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs!;
  }

  // store data to local storage

  static Future<void> storeData({String? key, dynamic value}) async {
    if (value.runtimeType == String) {
      await _prefs!.setString(key!, value);
    } else if (value.runtimeType == int) {
      await _prefs!.setInt(key!, value);
    } else if (value.runtimeType == bool) {
      await _prefs!.setBool(key!, value);
    } else if (value.runtimeType == double) {
      await _prefs!.setDouble(key!, value);
    } else {
      _prefs!.setStringList(key!, value);
    }
  }
}
