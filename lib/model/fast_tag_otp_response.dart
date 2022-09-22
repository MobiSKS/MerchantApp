class FastTagOTPResponse {
  bool? success;
  int? statusCode;
  int? internelStatusCode;
  String? message;
  String? methodName;
  Data? data;

  FastTagOTPResponse(
      {this.success,
      this.statusCode,
      this.internelStatusCode,
      this.message,
      this.methodName,
      this.data,
      });

  FastTagOTPResponse.fromJson(Map<dynamic, dynamic> json) {
    success = json['Success'];
    statusCode = json['Status_Code'];
    internelStatusCode = json['Internel_Status_Code'];
    message = json['Message'];
    methodName = json['Method_Name'];
    data = json['Data'] != null ? new Data.fromJson(json['Data']) : null;
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
    return data;
  }
}

class Data {
  String? resCode;
  String? resCd;
  String? resMsg;
  String? txnId;
  String? txnTime;
  String? tagId;
  String? mobileNo;
  String? vRN;
  String? txnNo;
  int? status;
  String? reason;

  Data(
      {this.resCode,
      this.resCd,
      this.resMsg,
      this.txnId,
      this.txnTime,
      this.tagId,
      this.mobileNo,
      this.vRN,
      this.txnNo,
      this.status,
      this.reason});

  Data.fromJson(Map<String, dynamic> json) {
    resCode = json['ResCode'];
    resCd = json['ResCd'];
    resMsg = json['ResMsg'];
    txnId = json['TxnId'];
    txnTime = json['txnTime'];
    tagId = json['TagId'];
    mobileNo = json['MobileNo'];
    vRN = json['VRN'];
    txnNo = json['TxnNo'];
    status = json['Status'];
    reason = json['Reason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ResCode'] = this.resCode;
    data['ResCd'] = this.resCd;
    data['ResMsg'] = this.resMsg;
    data['TxnId'] = this.txnId;
    data['txnTime'] = this.txnTime;
    data['TagId'] = this.tagId;
    data['MobileNo'] = this.mobileNo;
    data['VRN'] = this.vRN;
    data['TxnNo'] = this.txnNo;
    data['Status'] = this.status;
    data['Reason'] = this.reason;
    return data;
  }
}
