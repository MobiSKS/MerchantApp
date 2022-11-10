import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dtplusmerchant/base/api_services.dart';
import 'package:dtplusmerchant/const/common_param.dart';
import 'package:dtplusmerchant/model/fast_tag_otp_response.dart';
import 'package:dtplusmerchant/model/generate_qr_response.dart';
import 'package:dtplusmerchant/model/otp_response_sale.dart';
import 'package:dtplusmerchant/model/paycode_response_model.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../../const/injection.dart';
import '../const/url_constant.dart';
import '../model/card_enquiry_model.dart';
import '../model/card_fee_response_model.dart';
import '../model/fastag_otp_cofirm_model.dart';
import '../model/sale_by_terminal_response.dart';
import '../model/user_model.dart';
import '../preferences/shared_preference.dart';
import '../util/uiutil.dart';
import '../util/utils.dart';

class TransactionsProvider extends ChangeNotifier {
  final Dio _dio = Injection.injector.get<Dio>();
  final SharedPref _sharedPref = Injection.injector.get<SharedPref>();
  ApiServices apiServices = ApiServices();
  final bool _isLoading = false;
  bool get isLoading => _isLoading;

  OtpResponseSale? _otpResponseSale;
  OtpResponseSale? get otpResponseSale => _otpResponseSale;

  GenerateQrResponse? _generateQrResponse;
  GenerateQrResponse? get generateQrResponse => _generateQrResponse;

  SaleByTeminalResponse? _saleByTeminalResponse;
  SaleByTeminalResponse? get saleByTeminalResponse => _saleByTeminalResponse;

  FastTagOTPResponse? _fastTagOTPResponse;
  FastTagOTPResponse? get fastTagOTPResponse => _fastTagOTPResponse;

  CardFeeResponseModel? _cardFeeResponseModel;
  CardFeeResponseModel? get cardFeeResponseModel => _cardFeeResponseModel;

  FastTagOtpConfirmModel? _fastTagOtpConfirmModel;
  FastTagOtpConfirmModel? get fastTagOtpConfirmModel => _fastTagOtpConfirmModel;

  PaycodeResponseModel? _paycodeResponseModel;
  PaycodeResponseModel? get paycodeResponseModel => _paycodeResponseModel;

  CardEnquiryModel? _cardEnquiryResponseModel;
  CardEnquiryModel? get cardEnquiryResponseModel => _cardEnquiryResponseModel;

  Future<void> generateOTPSale(context,
      {String mobileNo = '',
      double invoiceAmount = 0.0,
      int transType = 522,
      String ccn = '',
      int otpType = 1}) async {
    showLoader(context);
    var ip = await Utils.getIp();
    var user = await _sharedPref.getPrefrenceData(key: SharedPref.userDetails)
        as UserModel;

    Map<String, String> header = {
      "Authorization": 'Bearer ${user.data!.objGetMerchantDetail![0].token}',
    };
    header.addAll(commonHeader);
    Map param = {
      "CCN": ccn,
      "UserId": user.data!.objGetMerchantDetail![0].merchantId,
      "CreatedBy": "5063857578",
      "Invoiceamount": invoiceAmount,
      "Mobileno": mobileNo,
      "OTPtype": otpType,
      "TransTypeId": transType,
      "Userip": ip,
      "Useragent": Utils.checkOs(),
    };

    param.addAll(commonReqBody);

    try {
      var response = await apiServices.post(UrlConstant.generateOtpForSale,
          body: param, requestHeader: header);
      dismissLoader(context);
      if (response['Success']) {
        _otpResponseSale = OtpResponseSale.fromJson(response);
      } else {
        alertPopUp(context, response['Message'],
            doLogout: response['Status_Code'] == 401 ? true : false);
      }
      notifyListeners();
    } catch (e) {
      return alertPopUp(context, e.toString());
    }
  }

  Future<void> saleByTerminal(context,
      {String mobileNo = '',
      double? invoiceAmount,
      int transType = 522,
      String? otp,
      String cardNum = '',
      int formFactor = 3,
      int productId = 0}) async {
    showLoader(context);
    var ip = await Utils.getIp();
      Position position = await  Geolocator.getCurrentPosition();
    var user = await _sharedPref.getPrefrenceData(key: SharedPref.userDetails)
        as UserModel;

    Map<String, String> header = {
      "Authorization": 'Bearer ${user.data!.objGetMerchantDetail![0].token}',
    };
    header.addAll(commonHeader);
    Map param = {
      "Userip": ip,
      "Latitude":position.latitude ,
      "Longitude":position.longitude,
      "Cardno": cardNum,
      "Batchid": 1,
      "Invoiceamount": invoiceAmount,
      "Transtype": transType,
      "Invoiceid": "",
      "Invoicedate": Utils.isoDateTimeFormat(),
      "Mobileno": mobileNo,
      "Productid": productId,
      "Odometerreading": "",
      "OTP": otp,
      "Pin": "",
      "Sourceid": "8",
      "CreatedBy": "5063857578",
      "Formfactor": formFactor,
      "DCSTokenNo": "",
      "Stan": 0,
      "OtherCardNo": "",
      "TxnRefId": "",
      "Paymentmode": "",
      "Gatewayname": "",
      "Bankname": "",
      "Paycode": ""
    };
    param.addAll(commonReqBody);

    try {
      var response = await apiServices.post(UrlConstant.saleByTerminal,
          body: param, requestHeader: header);
              log(response.toString());
      dismissLoader(context);
      if (response['Success']) {
        _saleByTeminalResponse = SaleByTeminalResponse.fromJson(response);
        if (_saleByTeminalResponse!.internelStatusCode != 1000) {
          alertPopUp(context, _saleByTeminalResponse!.data![0].reason!);
        }
      } else {
          _saleByTeminalResponse = SaleByTeminalResponse.fromJson(response);
        alertPopUp(context, response["Data"][0]['Reason'],
            doLogout: response['Status_Code'] == 401 ? true : false);
      }
      notifyListeners();
    } catch (e) {
      return alertPopUp(context, e.toString());
    }
  }

  Future<void> generateQR(context,
      {double? amount, String? productId, int? transTypeId}) async {
    var user = await _sharedPref.getPrefrenceData(key: SharedPref.userDetails)
        as UserModel;
    showLoader(context);
    var ip = await Utils.getIp();
    Map param = {
      "Amount": amount,
      "ProductId": productId,
      "Userip": ip,
      "Useragent": Utils.checkOs(),
      "UserId": user.data!.objGetMerchantDetail![0].merchantId,
      "Merchantid": user.data!.objGetMerchantDetail![0].merchantId,
      "MobileNo": user.data!.objGetMerchantDetail![0].mobileNo,
      "TransType": transTypeId
    };
    // param.addAll(commonReqBody);
    Map<String, String> header = {
      "Authorization": 'Bearer ${user.data!.objGetMerchantDetail![0].token}',
    };
    header.addAll(commonHeader);
    log('===>token ${user.data!.objGetMerchantDetail![0].token}');
    try {
      var response = await apiServices.post(UrlConstant.generateQR,
          body: param, requestHeader: header);
      dismissLoader(context);
      if (response['Success']) {
        _generateQrResponse = GenerateQrResponse.fromJson(response);
      } else {
        alertPopUp(context, response['Data']['message'],
            doLogout: response['Status_Code'] == 401 ? true : false);
      }
      notifyListeners();
    } catch (e) {
      return alertPopUp(context, e.toString());
    }
  }

  Future<void> generateOtpFastTAG(context,
      {String? mobileNo,
      double? invoiceAmount,
      int? bankId,
      String? vehicleNo}) async {
    showLoader(context);
    var ip = await Utils.getIp();
    var user = await _sharedPref.getPrefrenceData(key: SharedPref.userDetails)
        as UserModel;
    Map<String, String> header = {
      "Authorization": 'Bearer ${user.data!.objGetMerchantDetail![0].token}',
    };
    header.addAll(commonHeader);
    Map<dynamic, dynamic> param = {
      "BankID": bankId,
      "Mobileno": mobileNo,
      "Vehicleno": vehicleNo,
      "Invoiceamount": invoiceAmount,
      "Userip": ip,
    };
    param.addAll(commonReqBody);

    try {
      var response = await apiServices.post(UrlConstant.otpForFastTag,
          body: param, requestHeader: header);
      dismissLoader(context);
      if (response['Internel_Status_Code'] == 1000) {
        _fastTagOTPResponse = FastTagOTPResponse.fromJson(response);
        await _sharedPref.save(SharedPref.fastTagDetail, response);
      } else {
        alertPopUp(context, response['Message'],
            doLogout: response['Status_Code'] == 401 ? true : false);
      }
    } catch (e) {
      alertPopUp(context, e.toString());
    }
  }

  Future<void> cardFeePaynment(context,
      {int? numberOfCards, double? invoiceAmount, String? formNumber}) async {
    _dio.options.headers['Authorization'] = Utils.userToken;
    var ip = await Utils.getIp();
    showLoader(context);
     Position position = await  Geolocator.getCurrentPosition();
    Map param = {
      "Latitude": position.latitude,
      "Longitude": position.longitude,
      "Userip": ip,
      "Formno": formNumber,
      "Batchid": 1,
      "Noofcards": numberOfCards,
      "Invoiceamount": invoiceAmount,
      "Transtype": "",
      "Invoiceid": "",
      "Invoicedate": Utils.isoDateTimeFormat(),
      "Sourceid": 0,
      "CreatedBy": "5063857578",
      "Stan": 0,
      "Formfactor": 3
    };
    param.addAll(commonReqBody);
    try {
      Response response =
          await _dio.post(UrlConstant.cardFeePayment, data: param);
      dismissLoader(context);
      if (response.data['Success']) {
        _cardFeeResponseModel = CardFeeResponseModel.fromJson(response.data);
      } else {
        alertPopUp(context, response.data['Data'][0]['Reason'],
            doLogout: response.data['Status_Code'] == 401 ? true : false);
      }
      notifyListeners();
    } on DioError catch (e) {
      return alertPopUp(context, e.response!.statusMessage!);
    }
  }

  Future<void> submitFastTagPayment(context,
      {int? bankId,
      String? vehicleNo,
      String? mobile,
      double? amount,
      String? tagId,
      String? txnID,
      String? txnTime,
      String? txnNo,
      String? oTp,
      String? invoiceDate}) async {
    showLoader(context);
    var ip = await Utils.getIp();
    var user = await _sharedPref.getPrefrenceData(key: SharedPref.userDetails)
        as UserModel;

    Map<String, String> header = {
      "Authorization": 'Bearer ${user.data!.objGetMerchantDetail![0].token}',
    };
    header.addAll(commonHeader);
    Map param = {
      "BankID": bankId,
      "TxnRefId": txnID,
      "Vehicleno": vehicleNo,
      "Mobileno": mobile,
      "Invoiceamount": amount,
      "TxnTime": txnTime,
      "OTP": oTp, //OTP  for ICICI bank == 163081
      "TagId": tagId,
      "TxnNo": txnNo,
      "Invoiceid": "41",
      "Batchid": 1,
      "Invoicedate": invoiceDate,
      "Productid": 0,
      "Odometerreading": "",
      "TransType": "505",
      "Sourceid": 0,
      "Formfactor": 3,
      "DCSTokenNo": "",
      "Stan": 0,
      "Userip": ip,
    };
    param.addAll(commonReqBody);
    try {
      var response = await apiServices.post(UrlConstant.confirmFastTagOtp,
          body: param, requestHeader: header);
      dismissLoader(context);
      if (response['Internel_Status_Code'] == 1000) {
        _fastTagOtpConfirmModel = FastTagOtpConfirmModel.fromJson(response);
      } else {
          _fastTagOtpConfirmModel = FastTagOtpConfirmModel.fromJson(response);
        alertPopUp(context, response["Data"][0]["ResMsg"],
            doLogout: response['Status_Code'] == 401 ? true : false);
      }
      notifyListeners();
    } catch (e) {
      alertPopUp(context, e.toString());
    }
  }

  Future<void> payByPaycode(context, {String? payCode}) async {
    showLoader(context);
    var ip = await Utils.getIp();
       Position position = await  Geolocator.getCurrentPosition();
    var user = await _sharedPref.getPrefrenceData(key: SharedPref.userDetails)
        as UserModel;

    Map<String, String> header = {
      "Authorization": 'Bearer ${user.data!.objGetMerchantDetail![0].token}',
    };
    header.addAll(commonHeader);
    Map param = {
      "Bankname": "",
      "Gatewayname": "",
      "OtherCardNo": "",
      "Paycode": payCode,
      "Paymentmode": "",
      "Stan": 0,
      "TxnRefId": "",
      "Batchid": 1,
      "Cardno": "",
      "CreatedBy": "5063857578",
      "DCSTokenNo": "",
      "Formfactor": 6,
      "Invoiceamount": 0.0,
      "Invoicedate": Utils.dateTimeFormat(),
      "Invoiceid": "",
      "Latitude": position.latitude,
      "Longitude": position.longitude,
      "Userip": ip,
      "Odometerreading": "",
      "Mobileno": "9582922934",
      "Pin": "",
      "Productid": 0,
      "Sourceid": 8,
      "Transtype": "532",
      "Vehicleno": ""
    };

    param.addAll(commonReqBody);

    try {
      var response = await apiServices.post(UrlConstant.saleByTerminal,
          body: param, requestHeader: header);
      dismissLoader(context);
      if (response['Internel_Status_Code'] == 1000) {
        _paycodeResponseModel = PaycodeResponseModel.fromJson(response);
        if (_paycodeResponseModel!.internelStatusCode != 1000) {
          alertPopUp(context, _paycodeResponseModel!.data![0].reason!);
        }
      } else {
        alertPopUp(context, response['Message'],
            doLogout: response['Status_Code'] == 401 ? true : false);
      }
      notifyListeners();
    } catch (e) {
      return alertPopUp(context, e.toString());
    }
  }

  Future<void> cardEnquiryDetails(context,
      {String? mobileNo, String? otp, Function? callBack}) async {
    showLoader(context);
    var ip = await Utils.getIp();
    var user = await _sharedPref.getPrefrenceData(key: SharedPref.userDetails);
    Map param = {
      "Userip": ip,
      "Latitude": _sharedPref.read(SharedPref.lat),
      "Longitude":_sharedPref.read(SharedPref.long),
      "Cardno": "",
      "Useragent": Utils.checkOs(),
      "Mobileno": mobileNo,
      "OTP": otp,
      "Pin": "",
      "Sourceid": "8",
      "CreatedBy": "5063857578",
      "Formfactor": "3",
    };
    Map<String, String> header = {
      "Authorization": 'Bearer ${user.data!.objGetMerchantDetail![0].token}',
    };
    header.addAll(commonHeader);
    param.addAll(commonReqBody);
    debugPrint("payload for card enquiry ===> $param");
    try {
      var response = await apiServices.post(UrlConstant.cardbalance,
          body: param, requestHeader: header);
      dismissLoader(context);
      if (response['Success']) {
        _cardEnquiryResponseModel = CardEnquiryModel.fromJson(response);
        if (_cardEnquiryResponseModel!.internelStatusCode != 1000) {
          alertPopUp(context, _cardEnquiryResponseModel!.data![0].reason!);
        }
      } else {
        callBack!();
        alertPopUp(context, response["Data"][0]["Reason"],
            doLogout: response['Status_Code'] == 401 ? true : false);
      }
      notifyListeners();
    } catch (e) {
      return alertPopUp(context, e.toString());
    }
  }
}
