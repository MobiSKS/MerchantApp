import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:dtplusmerchant/model/user_model.dart';
import 'package:flutter/material.dart';
import '../../const/injection.dart';
import '../../const/url_constant.dart';
import '../../model/otp_response_model.dart';
import '../../preferences/shared_preference.dart';
import '../../util/uiutil.dart';
import '../../util/utils.dart';

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
      "UserId": userId,
      "Useragent": Utils.checkOs(),
      "Userip": "10.101.10.10",
      "Latitude": "1133.2323.23",
      "Longitude": "11.2.12.2",
      "MerchantId": "3010000087",
      "HWSerialNo": "1490147844",
      "Password": password
    };
    try {
      showLoader(context);
      Response response = await _dio.post(UrlConstant.loginApi, data: param);
      dismissLoader(context);
      if (response.data['Success']) {
        _userModel = UserModel.fromJson(response.data);
        log(_userModel!.data!.objGetMerchantDetail![0].token!);
        await _sharedPref.saveBool(SharedPref.isLogin, true);
        await _sharedPref.save(SharedPref.userDetails, response.data);
      } else {
        alertPopUp(context, 'Invalid username or Password');
      }
    } on DioError catch (e) {
      return alertPopUp(context, e.response!.statusMessage!);
    }
  }

  Future<void> sendOTP(context, String mobileNo) async {
    _dio.options.headers['API_Key'] = UrlConstant.apiKey;
    _dio.options.headers['Secret_key'] = UrlConstant.secretKey;

    Map param = {
      "Mobileno": mobileNo,
      "Useragent": Utils.checkOs(),
      "UserId": "",
      "Userip": ""
    };

    try {
      Response response = await _dio.post(UrlConstant.sendOTPApi, data: param);
      if (response.data['Success']) {
        _otpResponseModel = OtpResponseModel.fromJson(response.data);
      }
    } on DioError catch (e) {
      return alertPopUp(context, e.response!.data!);
    }
  }
}
