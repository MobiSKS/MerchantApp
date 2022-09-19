import 'package:dio/dio.dart';
import 'package:dtplusmerchant/const/url_constant.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';

import '../preferences/shared_preference.dart';

class Injection {
  static Injector injector = Injector();

  static final Dio _dio = Dio();

  static final SharedPref _sharedPrefs = SharedPref();

  static String token = "";

  static Future initInjection() async {
    await _sharedPrefs.init();
    if (_sharedPrefs.user != null) {
      await setupDioInterceptor();
    }

    _dio.options.baseUrl = UrlConstant.baseUrl;
    injector.map<Dio>((i) => _dio, isSingleton: true);
    injector.map<SharedPref>((i) => _sharedPrefs, isSingleton: true);
  }

  static Future<void> setupDioInterceptor() async {
    _dio.options.headers['API_Key'] = UrlConstant.apiKey;
    _dio.options.headers['Secret_Key'] = UrlConstant.secretKey;
  }
}
