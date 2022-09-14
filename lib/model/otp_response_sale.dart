class OtpResponseSale {
  bool? success;
  int? statusCode;
  int? internelStatusCode;
  String? message;
  String? methodName;
  List<Data>? data;
  Null? modelState;

  OtpResponseSale(
      {this.success,
      this.statusCode,
      this.internelStatusCode,
      this.message,
      this.methodName,
      this.data,
      this.modelState});

  OtpResponseSale.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['OTP'] = this.oTP;
    data['RetailOutletName'] = this.retailOutletName;
    data['VechileNo'] = this.vechileNo;
    data['Address'] = this.address;
    data['MobileNo'] = this.mobileNo;
    data['Status'] = this.status;
    data['Reason'] = this.reason;
    return data;
  }
}