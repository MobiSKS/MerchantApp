import 'package:dio/dio.dart';
import 'package:dtplusmerchant/model/otp_response_sale.dart';
import 'package:flutter/material.dart';
import '../../const/injection.dart';
import '../const/url_constant.dart';
import '../model/sale_by_terminal_response.dart';
import '../util/uiutil.dart';
import '../util/utils.dart';

class SaleReloadViewModel extends ChangeNotifier {
  final Dio _dio = Injection.injector.get<Dio>();

  final bool _isLoading = false;
  bool get isLoading => _isLoading;

  OtpResponseSale? _otpResponseSale;
  OtpResponseSale? get otpResponseSale => _otpResponseSale;

  SaleByTeminalResponse? _saleByTeminalResponse;
  SaleByTeminalResponse? get saleByTeminalResponse => _saleByTeminalResponse;

  Future<void> generateOTPSale(context,
      {String? mobileNo, double? invoiceAmount, int? transType}) async {
    Map param = {
      "CCN": "",
      "CreatedBy": "5063857578",
      "Invoiceamount": invoiceAmount,
      "Merchantid": Utils.merchantId,
      "Mobileno": mobileNo,
      "OTPtype": 1,
      "Terminalid": Utils.terminalId,
      "TransTypeId": transType,
      "Useragent": checkOs(),
      "UserId": Utils.merchantId,
      "Userip": "6bea26ac1371de0"
    };

    try {
      Response response =
          await _dio.post(UrlConstant.generateOtpForSale, data: param);
      if (response.data['Success']) {
        _otpResponseSale = OtpResponseSale.fromJson(response.data);
      } else {
        alertPopUp(context, response.data['Message']);
      }
    } on DioError catch (e) {
      return alertPopUp(context, e.response!.data!);
    }
  }

  Future<void> saleByTerminal(context,
      {String? mobileNo,
      double? invoiceAmount,
      int? transType,
      String? otp,
      int? productId}) async {

      int invoiceId= 5;
    Map param = {
      "Useragent": checkOs(),
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
      "Invoiceid": "$invoiceId",
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
      Response response =
          await _dio.post(UrlConstant.saleByTerminal, data: param);
      if (response.data['Success']) {
        _saleByTeminalResponse = SaleByTeminalResponse.fromJson(response.data);
      } else {
        alertPopUp(context, response.data['Message']);
      }
    } on DioError catch (e) {
      return alertPopUp(context, e.response!.data!);
    }
  }
}
