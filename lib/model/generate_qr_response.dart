class GenerateQrResponse {
  bool? success;
  int? statusCode;
  int? internelStatusCode;
  String? message;
  String? methodName;
  List<Data>? data;
  Null? modelState;

  GenerateQrResponse(
      {this.success,
      this.statusCode,
      this.internelStatusCode,
      this.message,
      this.methodName,
      this.data,
      this.modelState});

  GenerateQrResponse.fromJson(Map<String, dynamic> json) {
    success = json['Success'];
    statusCode = json['Status_Code'];
    internelStatusCode = json['Internel_Status_Code'];
    message = json['Message'];
    methodName = json['Method_Name'];
    if (json['Data'] != null) {
      data = <Data>[];
      json['Data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
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
      data['Data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['Model_State'] = this.modelState;
    return data;
  }
}

class Data {
  String? qRString;
  String? requestId;
  String? outletName;
  String? amount;
  int? status;
  String? reason;

  Data(
      {this.qRString,
      this.requestId,
      this.outletName,
      this.amount,
      this.status,
      this.reason});

  Data.fromJson(Map<String, dynamic> json) {
    qRString = json['QRString'];
    requestId = json['RequestId'];
    outletName = json['OutletName'];
    amount = json['Amount'];
    status = json['Status'];
    reason = json['Reason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['QRString'] = this.qRString;
    data['RequestId'] = this.requestId;
    data['OutletName'] = this.outletName;
    data['Amount'] = this.amount;
    data['Status'] = this.status;
    data['Reason'] = this.reason;
    return data;
  }
}