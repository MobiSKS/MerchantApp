// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dtplusmerchant/base/api_services.dart';
import 'package:dtplusmerchant/model/change_password_model.dart';
import 'package:dtplusmerchant/model/user_model.dart';
import 'package:flutter/material.dart';
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

  Future<void> loginApi(context, String userId, String password) async {
    _dio.options.headers['API_Key'] = UrlConstant.apiKey;
    _dio.options.headers['Secret_key'] = UrlConstant.secretKey;
    showLoader(context);
    var ip = await Utils.getIp();
    Map param = {
      "UserId": userId,
      "Useragent": Utils.checkOs(),
      "Userip": ip,
      "Latitude": "1133.2323.23",
      "Longitude": "11.2.12.2",
      "MerchantId": userId,
      "HWSerialNo": "1490147844",
      "Password": password
    };
    try {
      Response response = await _dio.post(UrlConstant.loginApi, data: param);
      dismissLoader(context);
      if (response.data['Success']) {
        _userModel = UserModel.fromJson(response.data);
        log('===>token ${_userModel!.data!.objGetMerchantDetail![0].token}');
        await _sharedPref.saveBool(SharedPref.isLogin, true);
        await _sharedPref.save(SharedPref.userDetails, response.data);
        notifyListeners();
      } else {
        alertPopUp(context, response.data["Message"]);
      }
    } on DioError catch (e) {
      dismissLoader(context);
      return alertPopUp(context, e.response!.statusMessage!);
    }
  }

  Future<void> changePasswordApi(context,
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
      "Useragent": Utils.checkOs(),
      "UserId": user.data!.objGetMerchantDetail![0].merchantId,
      "Userip": ip,
      "UserName": user.data!.objGetMerchantDetail![0].merchantId,
      "OldPassword": oldPass,
      "NewPassword": newPass,
      "ConfirmNewPassword": confirmNewPass,
    };

    try {
      var response = await apiServices.post(UrlConstant.changePassword,
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

  Future<void> forgetPassword(BuildContext context) async {}

  Future<void> logout(BuildContext context) async {
    await _sharedPref.preferenceClear();
    notifyListeners();
    Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false);
  }
}
  