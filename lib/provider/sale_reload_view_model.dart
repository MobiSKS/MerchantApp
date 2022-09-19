import 'package:dio/dio.dart';
import 'package:dtplusmerchant/model/generate_qr_response.dart';
import 'package:dtplusmerchant/model/otp_response_sale.dart';
import 'package:flutter/material.dart';
import '../../const/injection.dart';
import '../const/url_constant.dart';
import '../model/sale_by_terminal_response.dart';
import '../preferences/shared_preference.dart';
import '../util/uiutil.dart';
import '../util/utils.dart';

class SaleReloadViewModel extends ChangeNotifier {
  final Dio _dio = Injection.injector.get<Dio>();
  final SharedPref _sharedPref = Injection.injector.get<SharedPref>();

  final bool _isLoading = false;
  bool get isLoading => _isLoading;

  OtpResponseSale? _otpResponseSale;
  OtpResponseSale? get otpResponseSale => _otpResponseSale;

  GenerateQrResponse? _generateQrResponse;
  GenerateQrResponse? get generateQrResponse => _generateQrResponse;

  SaleByTeminalResponse? _saleByTeminalResponse;
  SaleByTeminalResponse? get saleByTeminalResponse => _saleByTeminalResponse;

  Future<void> generateOTPSale(context,
      {String? mobileNo, double? invoiceAmount, int? transType}) async {
    _dio.options.headers['Authorization'] = Utils.userToken;

    Map param = {
      "CCN": "",
      "CreatedBy": "5063857578",
      "Invoiceamount": invoiceAmount,
      "Merchantid": Utils.merchantId,
      "Mobileno": mobileNo,
      "OTPtype": 1,
      "Terminalid": Utils.terminalId,
      "TransTypeId": transType,
      "Useragent": Utils.checkOs(),
      "UserId": Utils.merchantId,
      "Userip": "10.101.10.10"
    };

    try {
      showLoader(context);
      Response response =
          await _dio.post(UrlConstant.generateOtpForSale, data: param);
      dismissLoader(context);
      if (response.data['Success']) {
        _otpResponseSale = OtpResponseSale.fromJson(response.data);
      } else {
        alertPopUp(context, response.data['Data']['message'],
            doLogout: response.data['Status_Code'] == 401 ? true : false);
      }
      notifyListeners();
    } on DioError catch (e) {
      return alertPopUp(context, e.response!.statusMessage!);
    }
  }

  Future<void> saleByTerminal(context,
      {String? mobileNo,
      double? invoiceAmount,
      int? transType,
      String? otp,
      int? productId}) async {
   
    _dio.options.headers['Authorization'] = Utils.userToken;
    Map param = {
      "Useragent": Utils.checkOs(),
      "UserId": Utils.merchantId,
      "Userip": "10.101.10.10",
      "Latitude": "1133.2323.23",
      "Longitude": "11.2.12.2",
      "Merchantid": Utils.merchantId,
      "Terminalid": Utils.terminalId,
      "Cardno": "",
      "Batchid": 1,
      "Invoiceamount": invoiceAmount,
      "Transtype": transType,
      "Invoiceid": "",
      "Invoicedate": "2000-04-23T05:00:35.991Z",
      "Mobileno": "9582922934",
      "Productid": productId,
      "Odometerreading": "",
      "OTP": otp,
      "Pin": "",
      "Sourceid": "8",
      "CreatedBy": "5063857578",
      "Formfactor": 3,
      "DCSTokenNo": "",
      "Stan": 0,
      "OtherCardNo": "",
      "TxnRefId": "",
      "Paymentmode": "",
      "Gatewayname": "",
      "Bankname": "",
      "Paycode": ""
    };

    try {
      showLoader(context);
      Response response =
          await _dio.post(UrlConstant.saleByTerminal, data: param);
      dismissLoader(context);
      if (response.statusCode == 200) {
        _saleByTeminalResponse = SaleByTeminalResponse.fromJson(response.data);
        var inv = await _sharedPref.readInt(SharedPref.invoiceId) + 1;
        await _sharedPref.remove(SharedPref.invoiceId);
        await _sharedPref.saveInt(SharedPref.invoiceId, inv);
        if (_saleByTeminalResponse!.internelStatusCode != 1000) {
          alertPopUp(context, _saleByTeminalResponse!.data![0].reason!);
        }
      } else {
        alertPopUp(context, response.data['Message'],
            doLogout: response.data['Status_Code'] == 401 ? true : false);
      }
      notifyListeners();
    } on DioError catch (e) {
      return alertPopUp(context, e.response!.data!);
    }
  }

  Future<void> generateQR(context, {double? amount, String? productId}) async {
    _dio.options.headers['Authorization'] = Utils.userToken;

    Map param = {
      "UserId": Utils.merchantId,
      "Useragent": Utils.checkOs(),
      "Userip": "10.101.10.10",
      "MerchantId": Utils.merchantId,
      "Amount": amount,
      "ProductId": productId
    };

    try {
      showLoader(context);
      Response response = await _dio.post(UrlConstant.generateQR, data: param);
      dismissLoader(context);
      if (response.data['Success']) {
        _generateQrResponse = GenerateQrResponse.fromJson(response.data);
      } else {
        alertPopUp(context, response.data['Data']['message'],
            doLogout: response.data['Status_Code'] == 401 ? true : false);
      }
      notifyListeners();
    } on DioError catch (e) {
      return alertPopUp(context, e.response!.statusMessage!);
    }
  }
}
