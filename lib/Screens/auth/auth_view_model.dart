import 'package:dio/dio.dart';
import 'package:dtplusmerchant/model/user_model.dart';
import 'package:flutter/material.dart';
import '../../const/injection.dart';
import '../../const/url_constant.dart';
import '../../model/otp_response_model.dart';
import '../../preferences/shared_preference.dart';
import '../../util/uiutil.dart'; 

class AuthViewModel extends ChangeNotifier {
  final Dio _dio = Injection.injector.get<Dio>();
  final SharedPref _sharedPref = Injection.injector.get<SharedPref>();

  final bool _isLoading = false;
  bool get isLoading => _isLoading;

  late String userAgent;

  UserModel? _userModel;
  UserModel? get userModel => _userModel;

  OtpResponseModel? _otpResponseModel;
  OtpResponseModel? get otpResponseModel => _otpResponseModel;


  Future<void> loginApi(context, String userId, String password) async {
    _dio.options.headers['API_Key'] = UrlConstant.apiKey;
    _dio.options.headers['Secret_key'] = UrlConstant.secretKey;
    Map param = {
      "username": "",
      "password": password,
      "Userip": "Simulator",
      "mobileno": "",
      "Useragent": checkOs(),
      "Userid": userId
    };
    try {
      Response response = await _dio.post(UrlConstant.loginApi, data: param);
      if (response.statusCode == 200 ) {
        _userModel = UserModel.fromJson(response.data);
        if (_userModel!.internelStatusCode == 1000) {
          await _sharedPref.saveBool(SharedPref.isLogin, true);
          await _sharedPref.save(SharedPref.userDetails, response.data);
        }
      }
    } on DioError catch (e) {
      return alertPopUp(context, e.response!.data);
    }
  }



  Future<void> sendOTP(context, String mobileNo) async {
    _dio.options.headers['API_Key'] = UrlConstant.apiKey;
    _dio.options.headers['Secret_key'] = UrlConstant.secretKey;

    Map param = {
      "Mobileno": mobileNo,
      "Useragent": checkOs(),
      "UserId": "",
      "Userip": ""
    };

    try {
      Response response = await _dio.post(UrlConstant.sendOTPApi, data: param);
      if (response.statusCode == 200) {
        _otpResponseModel = OtpResponseModel.fromJson(response.data);
      }
    } on DioError catch (e) {
      return alertPopUp(context, e.response!.data!);
    }
  }
}
