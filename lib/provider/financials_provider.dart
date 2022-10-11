import 'package:dtplusmerchant/base/api_services.dart';
import 'package:dtplusmerchant/model/credit_outstanding_model.dart';
import 'package:flutter/material.dart';
import '../const/common_param.dart';
import '../const/injection.dart';
import '../const/url_constant.dart';
import '../model/transaction_detail_model.dart';
import '../model/transaction_summary_model.dart';
import '../model/transaction_type.dart';
import '../model/user_model.dart';
import '../preferences/shared_preference.dart';
import '../util/uiutil.dart';
import '../util/utils.dart';

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

  TransactionType? _transactionType;
  TransactionType? get transactionType => _transactionType;

  Future<void> getCreditOutstandingDetail(context, {String? userId}) async {
    showLoader(context);
    var ip = await Utils.getIp();
    var user = await _sharedPref.getPrefrenceData(key: SharedPref.userDetails)
        as UserModel;

    Map<String, String> header = {
      "Authorization": 'Bearer ${user.data!.objGetMerchantDetail![0].token}',
    };
    header.addAll(commonHeader);

    Map param = {
      "MerchantId": Utils.merchantId,
      "Useragent": Utils.checkOs(),
      "UserId": userId,
      "Userip": ip,
    };

    try {
      var response = await apiServices.post(
          UrlConstant.creditSaleOutstandingDetail,
          body: param,
          requestHeader: header);
      dismissLoader(context);
      if (response['Success']) {
        _creditOutstandingModel = CreditOutstandingModel.fromJson(response);
      } else {
        alertPopUp(context, response['Message'],
            doLogout: response['Status_Code'] == 401 ? true : false);
      }
      notifyListeners();
    } catch (e) {
      return alertPopUp(context, e.toString());
    }
  }

  Future<void> getTransactionType(context) async {
    _isLoading = true;
    var ip = await Utils.getIp();
    var user = await _sharedPref.getPrefrenceData(key: SharedPref.userDetails)
        as UserModel;

    Map<String, String> header = {
      "Authorization": 'Bearer ${user.data!.objGetMerchantDetail![0].token}',
    };
    header.addAll(commonHeader);

    Map param = {
      "Useragent": Utils.checkOs(),
      "UserId": user.data!.objGetMerchantDetail![0].merchantId,
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
      return alertPopUp(context, e.toString());
    }
  }

  Future<void> getTransactionDetail(context,
      {String terminalId = "",
      String? fromDate,
      String? toDate,
      String? transType}) async {
    _isLoading = true;
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
      "MerchantId": user.data!.objGetMerchantDetail![0].merchantId,
      "TerminalId": terminalId,
      "TransactionType": transType,
      "FromDate": fromDate,
      "ToDate": toDate
    };

    try {
      var response = await apiServices.post(UrlConstant.transactionDetail,
          body: body, requestHeader: header);
      if (response['Success']) {
        dismissLoader(context);
        _isLoading = false;
        _transactionDetailModel = TransactionDetailModel.fromJson(response);
      } else {
        _isLoading = false;
            dismissLoader(context);
        alertPopUp(context, response['Message'],
            doLogout: response['Status_Code'] == 401 ? true : false);
      }
      notifyListeners();
    } catch (e) {
      _isLoading = false;
          dismissLoader(context);
      return alertPopUp(context, e.toString());
    }
  }
}
