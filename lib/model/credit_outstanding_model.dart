class CreditOutstandingModel {
  bool? success;
  int? statusCode;
  int? internelStatusCode;
  String? message;
  String? methodName;
  Data? data;

  CreditOutstandingModel(
      {this.success,
      this.statusCode,
      this.internelStatusCode,
      this.message,
      this.methodName,
      this.data,
   });

  CreditOutstandingModel.fromJson(Map<String, dynamic> json) {
    success = json['Success'];
    statusCode = json['Status_Code'];
    internelStatusCode = json['Internel_Status_Code'];
    message = json['Message'];
    methodName = json['Method_Name'];
    data = json['Data'] != null ?  Data.fromJson(json['Data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Success'] = success;
    data['Status_Code'] = statusCode;
    data['Internel_Status_Code'] = internelStatusCode;
    data['Message'] = message;
    data['Method_Name'] = methodName;
    if (this.data != null) {
      data['Data'] = this.data!.toJson();
    }
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
        merchantDetails!.add(MerchantDetails.fromJson(v));
      });
    }
    if (json['MerchantCustomerMappedDetails'] != null) {
      merchantCustomerMappedDetails = <MerchantCustomerMappedDetails>[];
      json['MerchantCustomerMappedDetails'].forEach((v) {
        merchantCustomerMappedDetails!
            .add( MerchantCustomerMappedDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    if (merchantDetails != null) {
      data['MerchantDetails'] =
          merchantDetails!.map((v) => v.toJson()).toList();
    }
    if (merchantCustomerMappedDetails != null) {
      data['MerchantCustomerMappedDetails'] =
          merchantCustomerMappedDetails!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['MerchantId'] = merchantId;
    data['RetailOutletName'] = retailOutletName;
    data['RegionalOfficeName'] = regionalOfficeName;
    data['ZonalOfficeName'] = zonalOfficeName;
    data['Status'] = status;
    data['Reason'] = reason;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['CustomerId'] = customerId;
    data['IndividualOrgName'] = individualOrgName;
    data['Outstanding'] = outstanding;
    data['CreditCloseLimit'] = creditCloseLimit;
    data['LimitBalance'] = limitBalance;
    data['CCMSBalanceStatus'] = cCMSBalanceStatus;
    return data;
  }
}
