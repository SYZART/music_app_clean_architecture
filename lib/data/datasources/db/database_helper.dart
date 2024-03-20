import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class DatabaseHelper {
  Future<bool> setAccessToken(String value) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.setString('accessToken', value);
  }

  Future<String?> getAccessToken() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("accessToken");
  }

  Future<bool> setRefreshToken(String value) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.setString('refreshToken', value);
  }

  Future<String?> getRefreshToken() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("refreshToken");
  }

  Future<bool> logout() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.clear();
  }
}
