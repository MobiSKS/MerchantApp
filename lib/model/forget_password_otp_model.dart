// ignore_for_file: prefer_collection_literals, prefer_void_to_null

class ForgetPasswordOTPModel {
  bool? success;
  int? statusCode;
  int? internelStatusCode;
  String? message;
  String? methodName;
  List<Data>? data;
  Null  modelState;

  ForgetPasswordOTPModel(
      {this.success,
      this.statusCode,
      this.internelStatusCode,
      this.message,
      this.methodName,
      this.data,
      this.modelState});

  ForgetPasswordOTPModel.fromJson(Map<String, dynamic> json) {
    success = json['Success'];
    statusCode = json['Status_Code'];
    internelStatusCode = json['Internel_Status_Code'];
    message = json['Message'];
    methodName = json['Method_Name'];
    if (json['Data'] != null) {
      data = <Data>[];
      json['Data'].forEach((v) {
        data!.add( Data.fromJson(v));
      });
    }
    modelState = json['Model_State'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['Success'] = success;
    data['Status_Code'] = statusCode;
    data['Internel_Status_Code'] = internelStatusCode;
    data['Message'] = message;
    data['Method_Name'] = methodName;
    if (this.data != null) {
      data['Data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['Model_State'] = modelState;
    return data;
  }
}

class Data {
  String? oTP;
  Null email;
  Null name;
  Null mobileNo;
  int? status;
  String? reason;

  Data(
      {this.oTP,
      this.email,
      this.name,
      this.mobileNo,
      this.status,
      this.reason});

  Data.fromJson(Map<String, dynamic> json) {
    oTP = json['OTP'];
    email = json['Email'];
    name = json['Name'];
    mobileNo = json['MobileNo'];
    status = json['Status'];
    reason = json['Reason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['OTP'] = oTP;
    data['Email'] = email;
    data['Name'] = name;
    data['MobileNo'] = mobileNo;
    data['Status'] = status;
    data['Reason'] = reason;
    return data;
  }
}
