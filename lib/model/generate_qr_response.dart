class GenerateQrResponse {
  bool? success;
  int? statusCode;
  int? internelStatusCode;
  String? message;
  String? methodName;
  List<Data>? data;

  GenerateQrResponse(

      {this.success,
      this.statusCode,
      this.internelStatusCode,
      this.message,
      this.methodName,
      this.data,
      }

      );

  GenerateQrResponse.fromJson(Map<String, dynamic> json) {
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
    }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Success'] = success;
    data['Status_Code'] = statusCode;
    data['Internel_Status_Code'] = internelStatusCode;
    data['Message'] = message;
    data['Method_Name'] = methodName;
    if (this.data != null) {
      data['Data'] = this.data!.map((v) => v.toJson()).toList();
    }
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['QRString'] = qRString;
    data['RequestId'] = requestId;
    data['OutletName'] = outletName;
    data['Amount'] = amount;
    data['Status'] = status;
    data['Reason'] = reason;
    return data;
  }
}