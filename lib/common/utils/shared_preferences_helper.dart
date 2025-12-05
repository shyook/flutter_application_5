import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static late SharedPreferences _sharedPreferences;

  static Future<void> initialize() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static final String key_phone_number = "key_phone_number";
  static final String key_member_id = 'key_member_id';
  static final String key_user_check = 'key_user_check';
  static final String key_skip_pin = 'key_skip_pin';

  static Future<bool> setData<T>({required String key, T? value}) async {
    if (value is int) {
      return await _sharedPreferences.setInt(key, value);
    }
    if (value is bool) {
      return await _sharedPreferences.setBool(key, value);
    }
    if (value is String) {
      return await _sharedPreferences.setString(key, value);
    }
    if (value is double) {
      return await _sharedPreferences.setDouble(key, value);
    }
    if (value is List<String>) {
      return await _sharedPreferences.setStringList(key, value);
    }
    return false;
  }

  static T? getData<T>({required String key}) {
    final data = _sharedPreferences.get(key);
    return data as T?;
  }

  static Future<bool> removeData({required String key}) async {
    return await _sharedPreferences.remove(key);
  }
}