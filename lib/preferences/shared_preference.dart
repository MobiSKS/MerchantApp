import 'dart:convert';
import 'package:dtplusmerchant/model/fast_tag_otp_response.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/user_model.dart';
import '../util/uiutil.dart';

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
    } else {
      _user = null;
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

  Future<dynamic> getPrefrenceData({dynamic defaultValue, String ?key}) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      if (defaultValue is bool) {
        return prefs.getBool(key!);
      } else if (defaultValue is String) {
        return prefs.getString(key!);
      } else if (defaultValue is int) {
        return prefs.getInt(key!);
      } else {
        return _getPrefModel(key!);
      }
    } catch (error) {
      showToast(error.toString(), true);
    }
  }

  Future<T?> _getPrefModel<T>(String prefKey) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var u = prefs.getString(
      prefKey,
    );

    if (u != null) {
      return fromJson<T>(prefKey, await json.decode(u));
    }
    return null;
  }

  fromJson<T>(String object, dynamic json) {
    if (object == SharedPref.userDetails) {
      return UserModel.fromJson(json) as T;
    } else {
      throw Exception("Unknown class");
    }
  }

  UserModel? get user => _user;
  FastTagOTPResponse? get fastTagData => _fastTagData;
}
