import 'dart:convert';
import 'package:dtplusmerchant/model/fast_tag_otp_response.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/user_model.dart';

class SharedPref {
  static String userDetails = "userstore";
  static String fastTagDetail = "fastTagDetail";
  late SharedPreferences _prefs;
  UserModel? _user;
  FastTagOTPResponse? _fastTagData;

  static String isLogin = "isLogin";
  static String invoiceId = "invoiceID";
  SharedPreferences get prefs => _prefs;

  init() async {
    _prefs = await SharedPreferences.getInstance();
    final user = await read(userDetails);
    if (user != null && user is Map) {
      _user = UserModel.fromJson(user);
    }
  }

  storeFastTagData() async {
    _prefs = await SharedPreferences.getInstance();
    final fastTagData = await read(fastTagDetail);
    if (fastTagData != null && fastTagData is Map) {
      _fastTagData = FastTagOTPResponse.fromJson(fastTagData);
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

  saveInt(String key, int value) async {
    _prefs.setInt(key, value);
  }

  readInt(String key) {
    final value = _prefs.getInt(key);
    if (value != null) return value;
    return null;
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
  FastTagOTPResponse? get fastTagData => _fastTagData;
}
