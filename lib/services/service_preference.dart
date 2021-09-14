import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceService extends GetxService {
  static late SharedPreferences _preferences;

  static final _keyIsFirstLog = 'isFirstLog';
  static final _keyStatus = 'status';

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
    return _preferences;
  }

  static Future clear() async {
    _preferences.clear();
  }

  static Future setIsFirstLog(bool userId) async {
    await _preferences.setBool(_keyIsFirstLog, userId);
  }

  static bool? getIsFirstLog() {
    final data = _preferences.getBool(_keyIsFirstLog);

    if (data != null) return data;
    return null;
  }

  static Future setStatus(String token) async {
    await _preferences.setString(_keyStatus, token);
  }

  static String? getStatus() {
    final data = _preferences.getString(_keyStatus);

    if (data != null) return data;
    return null;
  }
}
