import 'package:shared_preferences/shared_preferences.dart';

enum PrefKey { loginDetails,saveuse, getProfile, getMenu,username,password ,passbool}

class SharedPref {
  static late SharedPreferences _sharedPreferences;

  static Future<void> init() async =>
      _sharedPreferences = await SharedPreferences.getInstance();

  static Future<void> save(
          {required String value, required PrefKey prefKey}) async =>
      // _sharedPreferences.remove(prefKey.name);
      await _sharedPreferences.setString(prefKey.name, value);

  static String? get({required PrefKey prefKey}) {
    return _sharedPreferences.getString(prefKey.name);
  }

  static Future<void> deleteSpecific({required PrefKey prefKey}) async =>
      await _sharedPreferences.remove(prefKey.name);

  static Future<void> deleteAll() async => await _sharedPreferences.clear();
}
