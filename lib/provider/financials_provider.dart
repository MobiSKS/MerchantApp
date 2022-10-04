import 'package:dtplusmerchant/base/api_services.dart';
import 'package:dtplusmerchant/model/credit_outstanding_model.dart';
import 'package:flutter/material.dart';
import '../const/common_param.dart';
import '../const/url_constant.dart';
import '../util/uiutil.dart';
import '../util/utils.dart';

class FinancialsProvider extends ChangeNotifier {
  ApiServices apiServices = ApiServices();

  final bool _isLoading = false;
  bool get isLoading => _isLoading;

  CreditOutstandingModel? _creditOutstandingModel;
  CreditOutstandingModel? get creditOutstandingModel => _creditOutstandingModel;

  Future<void> getCreditOutstandingDetail(context, {String? userId}) async {
    showLoader(context);
    var ip = await Utils.getIp();
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
          requestHeader: commonHeader);
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
}
