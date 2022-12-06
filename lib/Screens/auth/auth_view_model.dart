// ignore_for_file: use_build_context_synchronously
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:dtplusmerchant/base/api_services.dart';
import 'package:dtplusmerchant/model/change_pass_otp.dart';
import 'package:dtplusmerchant/model/change_password_model.dart';
import 'package:dtplusmerchant/model/forget_otp_verify.dart';
import 'package:dtplusmerchant/model/forget_password_otp_model.dart';
import 'package:dtplusmerchant/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../../const/common_param.dart';
import '../../const/injection.dart';
import '../../const/url_constant.dart';
import '../../preferences/shared_preference.dart';
import '../../util/uiutil.dart';
import '../../util/utils.dart';

class AuthViewModel extends ChangeNotifier {
  final Dio _dio = Injection.injector.get<Dio>();
  final SharedPref _sharedPref = Injection.injector.get<SharedPref>();
  ApiServices apiServices = ApiServices();
  final bool _isLoading = false;
  bool get isLoading => _isLoading;

  late String userAgent;

  UserModel? _userModel;
  UserModel? get userModel => _userModel;

  ChangePasswordModel? _changePasswordModel;
  ChangePasswordModel? get changePasswordModel => _changePasswordModel;

  ForgetPasswordOTPModel? _forgetPasswordOTPModel;
  ForgetPasswordOTPModel? get forgetPasswordOTPModel => _forgetPasswordOTPModel;

  ForgetOTPverify? _forgetOTPverify;
  ForgetOTPverify? get forgetOTPverify => _forgetOTPverify;

  ChangePasswordOTp? _changePasswordOTp;
  ChangePasswordOTp? get changePasswordOTp => _changePasswordOTp;

  Future<void> loginApi(context, String userId, String password) async {
    await _sharedPref.preferenceClear();
    _dio.options.headers['API_Key'] = UrlConstant.apiKey;
    _dio.options.headers['Secret_key'] = UrlConstant.secretKey;
    showLoader(context);
    var ip = await Utils.getIp();
    Position position = await Geolocator.getCurrentPosition();
    Map param = {
      "UserId": userId,
      "Useragent": Utils.checkOs(),
      "Userip": ip ,
      "Latitude": position.latitude ,
      "Longitude": position.longitude ,
      "MerchantId": userId,
      "HWSerialNo": "1490147844",
      "Password": password
    };
    try {
      log("param ${param.toString()}");
      Response response = await _dio.post(UrlConstant.loginApi, data: param);
      dismissLoader(context);
      if (response.data['Success']) {
        _userModel = UserModel.fromJson(response.data);
        log('===>token ${_userModel!.data!.objGetMerchantDetail![0].token}');
        await _sharedPref.saveBool(SharedPref.isLogin, true);
        await _sharedPref.save(SharedPref.lat, position.latitude);
        await _sharedPref.save(SharedPref.long, position.longitude);
        await _sharedPref.save(SharedPref.userDetails, response.data);
        notifyListeners();
      } else {
        _userModel = null;
        notifyListeners();
        alertPopUp(context, response.data["Data"]["ObjGetMerchantDetail"][0]["Reason"]);
      }
    } on DioError catch (e) {
      dismissLoader(context);
      return alertPopUp(context, e.response!.data!);
    }
  }

  Future<void> verifyChangePasswordOtp(context,
      {String? otp,
      String? oldPass,
      String? newPass,
      String? confirmNewPass}) async {
    showLoader(context);
    var ip = await Utils.getIp();
    var user = await _sharedPref.getPrefrenceData(key: SharedPref.userDetails)
        as UserModel;

    Map<String, String> header = {
      "Authorization": 'Bearer ${user.data!.objGetMerchantDetail![0].token}',
    };
    header.addAll(commonHeader);

    Map body = {
      "UserId": user.data!.objGetMerchantDetail![0].merchantId,
      "Useragent": Utils.checkOs(),
      "Userip": ip,
      "UserName": user.data!.objGetMerchantDetail![0].merchantId,
      "MobileNo": user.data!.objGetMerchantDetail![0].mobileNo,
      "OldPassword": oldPass,
      "NewPassword": newPass,
      "ConfirmNewPassword": confirmNewPass,
      "OTPType": 21,
      "PageIdentifier": 2,
      "PageType": 2,
      "OTP": otp
    };

    try {
      var response = await apiServices.post(UrlConstant.changePasswordVerifyOTP,
          body: body, requestHeader: header);
      if (response['Success']) {
        dismissLoader(context);
        _changePasswordModel = ChangePasswordModel.fromJson(response);
      } else {
        dismissLoader(context);
        alertPopUp(context, response["Message"],
            doLogout: response['Status_Code'] == 401 ? true : false);
      }
      notifyListeners();
    } catch (e) {
      dismissLoader(context);
      return alertPopUp(context, e.toString());
    }
  }

  Future<void> changePasswordOTP(context,
      {String? newPass, String? oldPass, String? confirmNewPass}) async {
    showLoader(context);
    var ip = await Utils.getIp();
    var user = await _sharedPref.getPrefrenceData(key: SharedPref.userDetails)
        as UserModel;

    Map<String, String> header = {
      "Authorization": 'Bearer ${user.data!.objGetMerchantDetail![0].token}',
    };
    header.addAll(commonHeader);

    Map body = {
      "UserId": user.data!.objGetMerchantDetail![0].merchantId,
      "Useragent": Utils.checkOs(),
      "Userip": ip,
      "UserName": user.data!.objGetMerchantDetail![0].merchantId,
      "MobileNo": user.data!.objGetMerchantDetail![0].mobileNo,
      "OldPassword": oldPass,
      "NewPassword": newPass,
      "ConfirmNewPassword": confirmNewPass,
      "OTPType": 21,
      "PageIdentifier": 2,
      "PageType": 2,
    };
    log(body.toString());
    try {
      var response = await apiServices.post(UrlConstant.changePasswordOTP,
          body: body, requestHeader: header);
      log(response.toString());
      if (response['Success']) {
        dismissLoader(context);
        _changePasswordOTp = ChangePasswordOTp.fromJson(response);
      } else {
        dismissLoader(context);
        _changePasswordOTp = null;
        alertPopUp(context, response['Message'],
            doLogout: response['Status_Code'] == 401 ? true : false);
      }
      notifyListeners();
    } catch (e) {
      dismissLoader(context);
      return alertPopUp(context, e.toString());
    }
  }

  Future<void> forgetPasswordOTP(
    BuildContext context, {
    String? userName,
    String? emailId,
  }) async {
    showLoader(context);
    var ip = await Utils.getIp();
    Map body = {
      "UserId": userName,
      "Useragent": Utils.checkOs(),
      "Userip": ip,
      "UserName": userName,
      "EmailId": emailId,
      "PageIdentifier": 1,
      "PageType": 1,
      "OTPType": 21,
    };

    try {
      var response = await apiServices.post(UrlConstant.forgetPassOTP,
          body: body, requestHeader: commonHeader);
      if (response['Success']) {
        dismissLoader(context);
        _forgetPasswordOTPModel = ForgetPasswordOTPModel.fromJson(response);
      } else {
        dismissLoader(context);
        alertPopUp(context, response["Message"],
            doLogout: response['Status_Code'] == 401 ? true : false);
      }
      notifyListeners();
    } catch (e) {
      dismissLoader(context);
      return alertPopUp(context, e.toString());
    }
  }

  Future<void> forgetPasswordOTPVerify(
    BuildContext context, {
    String? userName,
    String? emailId,
    String? oTP,
  }) async {
    showLoader(context);
    var ip = await Utils.getIp();
    Map body = {
      "UserId": userName,
      "Useragent": Utils.checkOs(),
      "Userip": ip,
      "UserName": userName,
      "EmailId": emailId,
      "PageIdentifier": 1,
      "PageType": 1,
      "OTPType": 21,
      "OTP": oTP
    };

    try {
      var response = await apiServices.post(UrlConstant.forgetPassOTPVerify,
          body: body, requestHeader: commonHeader);
      if (response['Success']) {
        dismissLoader(context);
        _forgetOTPverify = ForgetOTPverify.fromJson(response);
      } else {
        dismissLoader(context);
        alertPopUp(context, response["Message"],
            doLogout: response['Status_Code'] == 401 ? true : false);
      }
      notifyListeners();
    } catch (e) {
      dismissLoader(context);
      return alertPopUp(context, e.toString());
    }
  }

  Future<void> logout(BuildContext context) async {
    await _sharedPref.preferenceClear();
    notifyListeners();
    Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false);
  }
}
