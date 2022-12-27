import 'dart:developer';
import 'package:dtplusmerchant/base/api_services.dart';
import 'package:dtplusmerchant/model/batch_detail_model.dart';
import 'package:dtplusmerchant/model/credit_outstanding_model.dart';
import 'package:dtplusmerchant/model/settlement_model.dart';
import 'package:dtplusmerchant/model/transaction_slip.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import '../const/common_param.dart';
import '../const/injection.dart';
import '../const/url_constant.dart';
import '../model/payment_model.dart';
import '../model/receivable_payable_model.dart';
import '../model/transaction_detail_model.dart';
import '../model/transaction_summary_model.dart';
import '../model/transaction_type.dart';
import '../model/user_model.dart';
import '../preferences/shared_preference.dart';
import '../util/uiutil.dart';
import '../util/utils.dart';
import 'location_provider.dart';

class FinancialsProvider extends ChangeNotifier {
  ApiServices apiServices = ApiServices();
  final SharedPref _sharedPref = Injection.injector.get<SharedPref>();
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  CreditOutstandingModel? _creditOutstandingModel;
  CreditOutstandingModel? get creditOutstandingModel => _creditOutstandingModel;

  TransactionSummaryModel? _transactionSummaryModel;
  TransactionSummaryModel? get transactionSummaryModel =>
      _transactionSummaryModel;

  TransactionDetailModel? _transactionDetailModel;
  TransactionDetailModel? get transactionDetailModel => _transactionDetailModel;

  TransactionSlip? _transactionSlip;
  TransactionSlip? get transactionSlip => _transactionSlip;

  TransactionType? _transactionType;
  TransactionType? get transactionType => _transactionType;

  ReceivablePayableModel? _receivablePayableResponseModel;
  ReceivablePayableModel? get receivablePayableResponseModel =>
      _receivablePayableResponseModel;

  SettlementModel? _settlementModel;
  SettlementModel? get settlementModel => _settlementModel;

  BatchDetailModel? _batchDetailModel;
  BatchDetailModel? get batchDetailModel => _batchDetailModel;

  PaymentModel? _paymentModel;
  PaymentModel? get paymentModel => _paymentModel;

  Future<void> getCreditOutstandingDetail(context, {String? userId}) async {
  _isLoading =true;
    var ip = await Utils.getIp();
    var user = await _sharedPref.getPrefrenceData(key: SharedPref.userDetails)
        as UserModel;

    Map<String, String> header = {
      "Authorization": 'Bearer ${user.data?.objGetMerchantDetail?.first.token}',
    };
    header.addAll(commonHeader);

    Map param = {
      "MerchantId": user.data?.objGetMerchantDetail?.first.merchantId,
      "Useragent": Utils.checkOs(),
      "UserId": user.data?.objGetMerchantDetail?.first.merchantId,
      "Userip": ip,
    };

    try {
      var response = await apiServices.post(
          UrlConstant.creditSaleOutstandingDetail,
          body: param,
          requestHeader: header);
_isLoading = false;
      if (response['Success']) {
        _creditOutstandingModel = CreditOutstandingModel.fromJson(response);
      } else {
        _isLoading = false;
        _creditOutstandingModel = null;
        alertPopUp(context, response['Message'],
            doLogout: response['Status_Code'] == 401 ? true : false);
      }
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      return alertPopUp(context, e.toString());
    }
  }

  Future<void> getTransactionType(context) async {
    _isLoading = true;
    var ip = await Utils.getIp();
    var user = await _sharedPref.getPrefrenceData(key: SharedPref.userDetails)
        as UserModel;

    Map<String, String> header = {
      "Authorization": 'Bearer ${user.data?.objGetMerchantDetail?.first.token}',
    };
    header.addAll(commonHeader);

    Map param = {
      "Useragent": Utils.checkOs(),
      "UserId": user.data?.objGetMerchantDetail?.first.merchantId,
      "Userip": ip
    };

    try {
      var response = await apiServices.post(UrlConstant.transactionType,
          body: param, requestHeader: header);
      if (response['Success']) {
        _isLoading = false;
        _transactionType = TransactionType.fromJson(response);
      } else {
        _isLoading = false;
        dismissLoader(context);
        alertPopUp(context, response['Message'],
            doLogout: response['Status_Code'] == 401 ? true : false);
      }
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      return alertPopUp(context, e.toString().substring(0, 60));
    }
  }

  Future<void> getTransactionDetail(context, {String? txnId,String ?terminalId}) async {
   showLoader(context);
    String? ip;
    String? lat;
    String? long;

    var locPro = Provider.of<LocationProvider>(context, listen: false);
    if (locPro.lat == null) {
      Position position = await Geolocator.getCurrentPosition();
      lat = position.latitude.toString();
      long = position.longitude.toString();
      ip = await Utils.getIp();
      locPro.setValues(position: position, ip: ip);
      notifyListeners();
    }

    var user = await _sharedPref.getPrefrenceData(key: SharedPref.userDetails)
        as UserModel;

    Map<String, String> header = {
      "Authorization": 'Bearer ${user.data?.objGetMerchantDetail?.first.token}',
    };
    header.addAll(commonHeader);

    Map body = {
      "UserId": user.data?.objGetMerchantDetail?.first.merchantId,
      "Useragent": Utils.checkOs(),
      "Userip": locPro.ip?? ip,
      "Latitude": locPro.lat?? lat,
      "Longitude": locPro.long?? long,
      "AppVersion": "string",
      "TerminalId": terminalId,
      "MerchantID": user.data?.objGetMerchantDetail?.first.merchantId,
      "TxnNo": txnId
    };

    log(body.toString());

    try {
      var response = await apiServices.post(
          UrlConstant.duplicateTransactionDetail,
          body: body,
          requestHeader: header);
          dismissLoader(context);
      log(response.toString());
      if (response['Success']) {
        _isLoading = false;
        _transactionDetailModel = TransactionDetailModel.fromJson(response);
      } else if (response['Status_Code'] != 200) {
        _isLoading = false;
        alertPopUp(context, response['Message'],
            doLogout: response['Status_Code'] == 401 ? true : false);
      } else {
        _isLoading = false;
      }
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      return alertPopUp(context, e.toString());
    }
  }

  Future<void> receivablePayableDetails(context,
      {String terminalId = '', String? fromDate, String? toDate}) async {
    _isLoading = true;
    var user = await _sharedPref.getPrefrenceData(key: SharedPref.userDetails)
        as UserModel;
    var ip = await Utils.getIp();
    Map param = {
      "UserId": user.data?.objGetMerchantDetail?.first.merchantId ?? "",
      "Useragent": Utils.checkOs(),
      "Userip": ip,
      "MerchantId": user.data?.objGetMerchantDetail?.first.merchantId,
      "TerminalId": terminalId,
      "FromDate":
          fromDate ?? Utils.convertDateFormatInYYMMDD(dateT: DateTime.now()),
      "ToDate":
          toDate ?? Utils.convertDateFormatInYYMMDD(dateT: DateTime.now()),
    };
    Map<String, String> header = {
      "Authorization": 'Bearer ${user.data?.objGetMerchantDetail?.first.token}',
    };
    header.addAll(commonHeader);
    try {
      var response = await apiServices.post(UrlConstant.receivablePayable,
          body: param, requestHeader: header);

      if (response['Success']) {
        _isLoading = false;
        _receivablePayableResponseModel =
            ReceivablePayableModel.fromJson(response);

        if (_receivablePayableResponseModel?.internelStatusCode != 1000) {
          alertPopUp(context, 'Error Occured');
        }
      } else if (response['Status_Code'] != 200) {
        _isLoading = false;
        alertPopUp(context, response['Message'],
            doLogout: response['Status_Code'] == 401 ? true : false);
      } else {
        _receivablePayableResponseModel = null;
        _isLoading = false;
      }
      notifyListeners();
    } catch (e) {
      return alertPopUp(context, e.toString());
    }
  }

  Future<void> getSettlementDetail(context, {String? date}) async {
    _isLoading = true;
    var ip;
    var lat;
    var long;
    var locPro = Provider.of<LocationProvider>(context, listen: false);
    if (locPro.lat == null) {
      ip = await Utils.getIp();
      Position position = await Geolocator.getCurrentPosition();
      lat = position.latitude.toString();
      long = position.latitude.toString();
      notifyListeners();
      locPro.setValues(position: position, ip: ip);
    }

    var user = await _sharedPref.getPrefrenceData(key: SharedPref.userDetails)
        as UserModel;

    Map<String, String> header = {
      "Authorization": 'Bearer ${user.data?.objGetMerchantDetail?.first.token}',
    };
    header.addAll(commonHeader);
    if (date != null) {
      date = Utils.convertDateFormatInYYMMDD(dateS: date);
    }

    Map body = {
      "UserId": user.data?.objGetMerchantDetail?.first.merchantId,
      "Useragent": Utils.checkOs(),
      "Userip": ip ?? locPro.ip,
      "Latitude": lat ?? locPro.lat,
      "Longitude": long ?? locPro.long,
      "LoginType": "string",
      "IMEI": "string",
      "DeviceOSversion": "string",
      "DeviceModel": "string",
      "DeviceToken": "string",
      "DeviceId": "string",
      "AppVersion": "string",
      "Date": date ?? Utils.convertDateFormatInYYMMDD(dateT: DateTime.now()),
      "MerchantId": user.data?.objGetMerchantDetail?.first.merchantId,
    };

    try {
      var response = await apiServices.post(UrlConstant.settlementlistApi,
          body: body, requestHeader: header);
      if (response['Success']) {
        _isLoading = false;
        _settlementModel = SettlementModel.fromJson(response);
      } else if (response['Status_Code'] != 200) {
        _isLoading = false;
        _settlementModel = null;
        alertPopUp(context, response['Message'],
            doLogout: response['Status_Code'] == 401 ? true : false);
      } else {
        _settlementModel = null;
        _isLoading = false;
      }
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      return alertPopUp(context, e.toString());
    }
  }

  Future<void> getbatchtDetail(context,
      {String? terminalId, int? batchId}) async {
    _isLoading = true;
    var ip = await Utils.getIp();
    var user = await _sharedPref.getPrefrenceData(key: SharedPref.userDetails)
        as UserModel;
    Map<String, String> header = {
      "Authorization": 'Bearer ${user.data?.objGetMerchantDetail?.first.token}',
    };
    header.addAll(commonHeader);
    Map body = {
      "UserId": user.data?.objGetMerchantDetail?.first.merchantId,
      "Useragent": Utils.checkOs(),
      "Userip": ip,
      "TerminalId": terminalId,
      "BatchId": batchId
    };

    try {
      var response = await apiServices.post(UrlConstant.batchDetailApi,
          body: body, requestHeader: header);
      if (response['Success']) {
        _isLoading = false;
        _batchDetailModel = BatchDetailModel.fromJson(response);
      } else if (response['Status_Code'] != 200) {
        _isLoading = false;
        alertPopUp(context, response['Message'],
            doLogout: response['Status_Code'] == 401 ? true : false);
      } else {
        _isLoading = false;
      }
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      return alertPopUp(context, e.toString());
    }
  }

  Future<void> getPaymentList(context, {String? date}) async {
    _isLoading = true;
    var ip;
    var lat;
    var long;
    var locPro = Provider.of<LocationProvider>(context, listen: false);
    if (locPro.lat == null) {
      ip = await Utils.getIp();
      Position position = await Geolocator.getCurrentPosition();
      lat = position.latitude.toString();
      long = position.latitude.toString();
      notifyListeners();
      locPro.setValues(position: position, ip: ip);
    }

    var user = await _sharedPref.getPrefrenceData(key: SharedPref.userDetails)
        as UserModel;

    Map<String, String> header = {
      "Authorization": 'Bearer ${user.data?.objGetMerchantDetail?.first.token}',
    };
    header.addAll(commonHeader);
    if (date != null) {
      date = Utils.convertDateFormatInYYMMDD(dateS: date);
    }

    Map body = {
      "UserId": user.data?.objGetMerchantDetail?.first.merchantId,
      "Useragent": Utils.checkOs(),
      "Userip": ip ?? locPro.ip,
      "Latitude": lat ?? locPro.lat,
      "Longitude": long ?? locPro.long,
      "LoginType": "string",
      "IMEI": "string",
      "DeviceOSversion": "string",
      "DeviceModel": "string",
      "DeviceToken": "string",
      "DeviceId": "string",
      "AppVersion": "string",
      "Date": date ?? Utils.convertDateFormatInYYMMDD(dateT: DateTime.now()),
      "MerchantId": user.data?.objGetMerchantDetail?.first.merchantId,
    };

    try {
      var response = await apiServices.post(UrlConstant.paymentListApi,
          body: body, requestHeader: header);
      if (response['Success']) {
        _isLoading = false;
        _paymentModel = PaymentModel.fromJson(response);
      } else if (response['Status_Code'] != 200) {
        _isLoading = false;
        _paymentModel = null;
        alertPopUp(context, response['Message'],
            doLogout: response['Status_Code'] == 401 ? true : false);
      } else {
        _paymentModel = null;
        _isLoading = false;
      }
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      return alertPopUp(context, e.toString());
    }
  }

  Future<void> getTransactionSlip(context,
      {String terminalId = "",
      String? fromDate,
      String? toDate,
      String? transType}) async {
    _isLoading = true;
    String? ip;
    var locPro = Provider.of<LocationProvider>(context, listen: false);
    if (locPro.ip == null) {
      ip = await Utils.getIp();
    }

    var user = await _sharedPref.getPrefrenceData(key: SharedPref.userDetails)
        as UserModel;

    Map<String, String> header = {
      "Authorization": 'Bearer ${user.data?.objGetMerchantDetail?.first.token}',
    };
    header.addAll(commonHeader);

    Map body = {
      "UserId": user.data?.objGetMerchantDetail?.first.merchantId,
      "Useragent": Utils.checkOs(),
      "Userip": locPro.ip ?? ip,
      "Latitude": locPro.lat,
      "Longitude": locPro.long,
      "DeviceOSversion": "string",
      "DeviceModel": "string",
      "DeviceToken": "string",
      "DeviceId": "string",
      "AppVersion": "string",
      "MerchantId": user.data?.objGetMerchantDetail?.first.merchantId,
      "TerminalId": terminalId,
      "TransactionType": transType,
      "FromDate":
          fromDate ?? Utils.convertDateFormatInYYMMDD(dateT: DateTime.now()),
      "ToDate":
          toDate ?? Utils.convertDateFormatInYYMMDD(dateT: DateTime.now()),
    };
    log(body.toString());
    log('=====>Transtype $transType}');
    try {
      var response = await apiServices.post(UrlConstant.transationSlip,
          body: body, requestHeader: header);
      log(response.toString());
      if (response['Success']) {
        _transactionSlip = TransactionSlip.fromJson(response);
        _isLoading = false;
      } else if (response['Status_Code'] != 200) {
        _isLoading = false;
        alertPopUp(context, response['Message'],
            doLogout: response['Status_Code'] == 401 ? true : false);
      } else {
        _isLoading = false;
      }
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      return alertPopUp(context, e.toString());
    }
  }
}
