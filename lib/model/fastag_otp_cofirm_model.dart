class FastTagOtpConfirmModel {
  bool? success;
  int? statusCode;
  int? internelStatusCode;
  String? message;
  String? methodName;
  Data? data;

  FastTagOtpConfirmModel(
      {this.success,
      this.statusCode,
      this.internelStatusCode,
      this.message,
      this.methodName,
      this.data,
      });

  FastTagOtpConfirmModel.fromJson(Map<String, dynamic> json) {
    success = json['Success'];
    statusCode = json['Status_Code'];
    internelStatusCode = json['Internel_Status_Code'];
    message = json['Message'];
    methodName = json['Method_Name'];
    data = json['Data'] != null ? Data.fromJson(json['Data']) : null;
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
  String? resCode;
  String? resCd;
  String? resMsg;
  String? txnId;
  String? txnTime;
  String? tagId;
  String? mobileNo;
  String? vRN;
  String? txnNo;
  String? invoiceid;
  int? batchid;
  String? rSP;
  String? volume;
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
      this.invoiceid,
      this.batchid,
      this.rSP,
      this.volume,
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
    invoiceid = json['Invoiceid'];
    batchid = json['Batchid'];
    rSP = json['RSP'];
    volume = json['Volume'];
    status = json['Status'];
    reason = json['Reason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ResCode'] = resCode;
    data['ResCd'] = resCd;
    data['ResMsg'] = resMsg;
    data['TxnId'] = txnId;
    data['txnTime'] = txnTime;
    data['TagId'] = tagId;
    data['MobileNo'] = mobileNo;
    data['VRN'] = vRN;
    data['TxnNo'] = txnNo;
    data['Invoiceid'] = invoiceid;
    data['Batchid'] = batchid;
    data['RSP'] = rSP;
    data['Volume'] = volume;
    data['Status'] = status;
    data['Reason'] = reason;
    return data;
  }
}
