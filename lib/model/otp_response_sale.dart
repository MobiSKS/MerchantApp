class OtpResponseSale {
  bool? success;
  int? statusCode;
  int? internelStatusCode;
  String? message;
  String? methodName;
  List<Data>? data;

  OtpResponseSale(
      {this.success,
      this.statusCode,
      this.internelStatusCode,
      this.message,
      this.methodName,
      this.data,
      });

  OtpResponseSale.fromJson(Map<String, dynamic> json) {
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
  String? oTP;
  String? retailOutletName;
  String? vechileNo;
  String? address;
  String? mobileNo;
  int? status;
  String? reason;

  Data(
      {this.oTP,
      this.retailOutletName,
      this.vechileNo,
      this.address,
      this.mobileNo,
      this.status,
      this.reason});

  Data.fromJson(Map<String, dynamic> json) {
    oTP = json['OTP'];
    retailOutletName = json['RetailOutletName'];
    vechileNo = json['VechileNo'];
    address = json['Address'];
    mobileNo = json['MobileNo'];
    status = json['Status'];
    reason = json['Reason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['OTP'] = oTP;
    data['RetailOutletName'] = retailOutletName;
    data['VechileNo'] = vechileNo;
    data['Address'] = address;
    data['MobileNo'] = mobileNo;
    data['Status'] = status;
    data['Reason'] = reason;
    return data;
  }
}