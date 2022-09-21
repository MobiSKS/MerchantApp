import 'package:dio/dio.dart';
import 'package:dtplusmerchant/model/fast_tag_otp_response.dart';
import 'package:dtplusmerchant/model/generate_qr_response.dart';
import 'package:dtplusmerchant/model/otp_response_sale.dart';
import 'package:flutter/material.dart';
import '../../const/injection.dart';
import '../const/url_constant.dart';
import '../model/card_fee_response_model.dart';
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

  FastTagOTPResponse? _fastTagOTPResponse;
  FastTagOTPResponse? get fastTagOTPResponse => _fastTagOTPResponse;

  CardFeeResponseModel? _cardFeeResponseModel;
  CardFeeResponseModel? get cardFeeResponseModel => _cardFeeResponseModel;

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

  Future<void> generateOtpFastTAG(context,
      {String? mobileNo,
      double? invoiceAmount,
      int? bankId,
      String? vehicleNo}) async {
    _dio.options.headers['Authorization'] = Utils.userToken;

    Map param = {
      "UserId": Utils.merchantId,
      "Useragent": Utils.checkOs(),
      "Userip": "10.101.10.10",
      "Latitude": "1133.2323.23",
      "Longitude": "11.2.12.2",
      "Merchantid": Utils.merchantId,
      "Terminalid": Utils.terminalId,
      "BankID": bankId,
      "Mobileno": mobileNo,
      "Vehicleno": vehicleNo,
      "Invoiceamount": invoiceAmount
    };

    try {
      showLoader(context);
      Response response =
          await _dio.post(UrlConstant.otpForFastTag, data: param);
      dismissLoader(context);
      if (response.data['Internel_Status_Code'] == 1000) {
        _fastTagOTPResponse = FastTagOTPResponse.fromJson(response.data);
      } else {
        alertPopUp(context, response.data['Data']['ResMsg'],
            doLogout: response.data['Status_Code'] == 401 ? true : false);
      }
    } on DioError catch (e) {
      return alertPopUp(context, e.response!.statusMessage!);
    }
  }

  Future<void> cardFeePaynment(context,
      {int? numberOfCards, double? invoiceAmount, String? formNumber}) async {
    _dio.options.headers['Authorization'] = Utils.userToken;

    Map param = {
      "UserId": Utils.merchantId,
      "Useragent": Utils.checkOs(),
      "Userip": "10.101.10.10",
      "Latitude": "1133.2323.23",
      "Longitude": "11.2.12.2",
      "Merchantid": Utils.merchantId,
      "Terminalid": Utils.terminalId,
      "Formno": formNumber,
      "Batchid": 1,
      "Noofcards": numberOfCards,
      "Invoiceamount": invoiceAmount,
      "Transtype": "",
      "Invoiceid": "",
      "Invoicedate": "2022-09-19T18:25:36.711Z",
      "Sourceid": 0,
      "CreatedBy": "5063857578",
      "Stan": 0,
      "Formfactor": 3
    };
    try {
      showLoader(context);
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
      {int? bankId, double? invoiceAmount, String? formNumber}) async {
    _dio.options.headers['Authorization'] = Utils.userToken;

    Map param = {
      "Userip": "10.101.10.10",
      "UserId": Utils.merchantId,
      "Latitude": "1133.2323.23",
      "Longitude": "11.2.12.2",
      "Useragent": Utils.checkOs(),
      "Merchantid": Utils.merchantId,
      "Terminalid": Utils.merchantId,
      "BankID": bankId,
      "TxnRefId": "220920759",
      "Vehicleno": "PAYTM0011123",
      "Mobileno": "9582922934",
      "Invoiceamount": invoiceAmount,
      "TxnTime": "20092022141636",
      "OTP": "743633",
      "TagId": "34161FA820327FA4027BABE0",
      "TxnNo": "220920759",
      "Invoiceid": "41",
      "Batchid": 1,
      "Invoicedate": "2022-09-22",
      "Productid": 0,
      "Odometerreading": "222",
      "TransType": "501",
      "Sourceid": 0,
      "Formfactor": 3,
      "DCSTokenNo": "",
      "Stan": 0
    };
    try {
      showLoader(context);
      Response response =
          await _dio.post(UrlConstant.confirmFastTagOtp, data: param);
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
}
