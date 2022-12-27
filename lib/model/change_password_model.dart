class ChangePasswordModel {
  bool? success;
  int? statusCode;
  int? internelStatusCode;
  String? message;
  String? methodName;
  List<Data>? data;
  Null? modelState;

  ChangePasswordModel(
      {this.success,
      this.statusCode,
      this.internelStatusCode,
      this.message,
      this.methodName,
      this.data,
      this.modelState});

  ChangePasswordModel.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = <String, dynamic>{};
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
  String? email;
  String ? name;
  String? mobileNo;
  int? status;
  String? reason;

  Data({this.email, this.name, this.mobileNo, this.status, this.reason});

  Data.fromJson(Map<String, dynamic> json) {
    email = json['Email'];
    name = json['Name'];
    mobileNo = json['MobileNo'];
    status = json['Status'];
    reason = json['Reason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['Email'] = email;
    data['Name'] = name;
    data['MobileNo'] = mobileNo;
    data['Status'] = status;
    data['Reason'] = reason;
    return data;
  }
}
