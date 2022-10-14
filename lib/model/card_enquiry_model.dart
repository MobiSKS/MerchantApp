class CardEnquiryModel {
  bool? success;
  var statusCode;
  var internelStatusCode;
  String? message;
  String? methodName;
  List<Data>? data;
  Data? modelState;

  CardEnquiryModel(
      {this.success,
        this.statusCode,
        this.internelStatusCode,
        this.message,
        this.methodName,
        this.data,
        this.modelState});

  CardEnquiryModel.fromJson(Map<String, dynamic> json) {
    success = json['Success'];
    statusCode = json['Status_Code'];
    internelStatusCode = json['Internel_Status_Code'];
    message = json['Message'];
    methodName = json['Method_Name'];
    if (json['Data'] != null) {
      data = <Data>[];
      json['Data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    if(json['Model_State'] != null) {
      modelState = json['Model_State'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Success'] = this.success;
    data['Status_Code'] = this.statusCode;
    data['Internel_Status_Code'] = this.internelStatusCode;
    data['Message'] = this.message;
    data['Method_Name'] = this.methodName; 
    if (this.data != null) {
      data['Data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['Model_State'] = this.modelState;
    return data;
  }
}

class Data {
  var monthlyLimit;
  var monthlySpent;
  var monthlyLimitBal;
  var dailyLimit;
  var dailySpent;
  var dailyLimitBal;
  var cCMSLimit;
  var cCMSLimitBal;
  var cardBalance;
  var cardNoOutput;
  var status;
  String? reason;

  Data(
      {this.monthlyLimit,
        this.monthlySpent,
        this.monthlyLimitBal,
        this.dailyLimit,
        this.dailySpent,
        this.dailyLimitBal,
        this.cCMSLimit,
        this.cCMSLimitBal,
        this.cardBalance,
        this.cardNoOutput,
        this.status,
        this.reason});

  Data.fromJson(Map<String, dynamic> json) {
    monthlyLimit = json['MonthlyLimit'];
    monthlySpent = json['MonthlySpent'];
    monthlyLimitBal = json['MonthlyLimitBal'];
    dailyLimit = json['DailyLimit'];
    dailySpent = json['DailySpent'];
    dailyLimitBal = json['DailyLimitBal'];
    cCMSLimit = json['CCMSLimit'];
    cCMSLimitBal = json['CCMSLimitBal'];
    cardBalance = json['CardBalance'];
    cardNoOutput = json['CardNoOutput'];
    status = json['Status'];
    reason = json['Reason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['MonthlyLimit'] = this.monthlyLimit;
    data['MonthlySpent'] = this.monthlySpent;
    data['MonthlyLimitBal'] = this.monthlyLimitBal;
    data['DailyLimit'] = this.dailyLimit;
    data['DailySpent'] = this.dailySpent;
    data['DailyLimitBal'] = this.dailyLimitBal;
    data['CCMSLimit'] = this.cCMSLimit;
    data['CCMSLimitBal'] = this.cCMSLimitBal;
    data['CardBalance'] = this.cardBalance;
    data['CardNoOutput'] = this.cardNoOutput;
    data['Status'] = this.status;
    data['Reason'] = this.reason;
    return data;
  }
}
