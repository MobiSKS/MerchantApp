class CreditOutstandingModel {
  bool? success;
  int? statusCode;
  int? internelStatusCode;
  String? message;
  String? methodName;
  Data? data;
  Null? modelState;

  CreditOutstandingModel(
      {this.success,
      this.statusCode,
      this.internelStatusCode,
      this.message,
      this.methodName,
      this.data,
      this.modelState});

  CreditOutstandingModel.fromJson(Map<String, dynamic> json) {
    success = json['Success'];
    statusCode = json['Status_Code'];
    internelStatusCode = json['Internel_Status_Code'];
    message = json['Message'];
    methodName = json['Method_Name'];
    data = json['Data'] != null ? new Data.fromJson(json['Data']) : null;
    modelState = json['Model_State'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Success'] = this.success;
    data['Status_Code'] = this.statusCode;
    data['Internel_Status_Code'] = this.internelStatusCode;
    data['Message'] = this.message;
    data['Method_Name'] = this.methodName;
    if (this.data != null) {
      data['Data'] = this.data!.toJson();
    }
    data['Model_State'] = this.modelState;
    return data;
  }
}

class Data {
  List<MerchantDetails>? merchantDetails;
  List<MerchantCustomerMappedDetails>? merchantCustomerMappedDetails;

  Data({this.merchantDetails, this.merchantCustomerMappedDetails});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['MerchantDetails'] != null) {
      merchantDetails = <MerchantDetails>[];
      json['MerchantDetails'].forEach((v) {
        merchantDetails!.add(new MerchantDetails.fromJson(v));
      });
    }
    if (json['MerchantCustomerMappedDetails'] != null) {
      merchantCustomerMappedDetails = <MerchantCustomerMappedDetails>[];
      json['MerchantCustomerMappedDetails'].forEach((v) {
        merchantCustomerMappedDetails!
            .add(new MerchantCustomerMappedDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.merchantDetails != null) {
      data['MerchantDetails'] =
          this.merchantDetails!.map((v) => v.toJson()).toList();
    }
    if (this.merchantCustomerMappedDetails != null) {
      data['MerchantCustomerMappedDetails'] =
          this.merchantCustomerMappedDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MerchantDetails {
  String? merchantId;
  String? retailOutletName;
  String? regionalOfficeName;
  String? zonalOfficeName;
  int? status;
  String? reason;

  MerchantDetails(
      {this.merchantId,
      this.retailOutletName,
      this.regionalOfficeName,
      this.zonalOfficeName,
      this.status,
      this.reason});

  MerchantDetails.fromJson(Map<String, dynamic> json) {
    merchantId = json['MerchantId'];
    retailOutletName = json['RetailOutletName'];
    regionalOfficeName = json['RegionalOfficeName'];
    zonalOfficeName = json['ZonalOfficeName'];
    status = json['Status'];
    reason = json['Reason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['MerchantId'] = this.merchantId;
    data['RetailOutletName'] = this.retailOutletName;
    data['RegionalOfficeName'] = this.regionalOfficeName;
    data['ZonalOfficeName'] = this.zonalOfficeName;
    data['Status'] = this.status;
    data['Reason'] = this.reason;
    return data;
  }
}

class MerchantCustomerMappedDetails {
  String? customerId;
  String? individualOrgName;
  String? outstanding;
  String? creditCloseLimit;
  String? limitBalance;
  String? cCMSBalanceStatus;

  MerchantCustomerMappedDetails(
      {this.customerId,
      this.individualOrgName,
      this.outstanding,
      this.creditCloseLimit,
      this.limitBalance,
      this.cCMSBalanceStatus});

  MerchantCustomerMappedDetails.fromJson(Map<String, dynamic> json) {
    customerId = json['CustomerId'];
    individualOrgName = json['IndividualOrgName'];
    outstanding = json['Outstanding'];
    creditCloseLimit = json['CreditCloseLimit'];
    limitBalance = json['LimitBalance'];
    cCMSBalanceStatus = json['CCMSBalanceStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CustomerId'] = this.customerId;
    data['IndividualOrgName'] = this.individualOrgName;
    data['Outstanding'] = this.outstanding;
    data['CreditCloseLimit'] = this.creditCloseLimit;
    data['LimitBalance'] = this.limitBalance;
    data['CCMSBalanceStatus'] = this.cCMSBalanceStatus;
    return data;
  }
}
