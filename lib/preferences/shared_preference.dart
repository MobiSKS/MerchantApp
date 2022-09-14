import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/user_model.dart';

class SharedPref {
  static String userDetails = "userstore";
  late SharedPreferences _prefs;
   UserModel ? _user;
  static String isLogin = "isLogin";

  SharedPreferences get prefs => _prefs;

  init() async {
    _prefs = await SharedPreferences.getInstance();
    final  user = await read(userDetails);
    if (user != null && user is Map) {
    _user = UserModel.fromJson(user);
    }
  }

  read(String key) {
    final value = _prefs.getString(key);
    if (value != null) return json.decode(value);
    return null;
  }

  save(String key, value) async {
    await _prefs.setString(key, json.encode(value));
    if (key == userDetails) {
      await init();
    }
  }

  saveBool(String key, bool value) async {
    _prefs.setBool(key, value);
  }

  readBool(String key) async {
    bool? boolValue = _prefs.getBool(key);
    if (boolValue != null) return boolValue;

    return false;
  }

  remove(String key) async {
    await _prefs.remove(key);
  }

  preferenceClear() async {
    await _prefs.clear();
  }

  UserModel? get user => _user;
}
