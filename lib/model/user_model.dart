class UserModel {
  bool? success;
  int? statusCode;
  int? internelStatusCode;
  String? message;
  String? methodName;
  List<Data>? data;
  Null? modelState;

  UserModel(
      {this.success,
      this.statusCode,
      this.internelStatusCode,
      this.message,
      this.methodName,
      this.data,
      this.modelState});

  UserModel.fromJson(Map<dynamic, dynamic> json) {
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
    modelState = json['Model_State'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
  String? loginType;
  String? userId;
  String? userName;
  String? emailId;
  String? userRole;
  String? firstName;
  String? lastName;
  int? statusId;
  String? statusName;
  String? mobileNo;
  String? regionalOfficeID;
  String? regionalOfficeName;
  String? zonalOfficeID;
  String? zonalOfficeName;
  String? token;
  Null? mobileUserRole;
  String? profileImg;
  String? sBUTypeId;
  String? sBUName;
  String? userSubType;
  String? dealerCode;
  int? status;
  String? reason;

  Data(
      {this.loginType,
      this.userId,
      this.userName,
      this.emailId,
      this.userRole,
      this.firstName,
      this.lastName,
      this.statusId,
      this.statusName,
      this.mobileNo,
      this.regionalOfficeID,
      this.regionalOfficeName,
      this.zonalOfficeID,
      this.zonalOfficeName,
      this.token,
      this.mobileUserRole,
      this.profileImg,
      this.sBUTypeId,
      this.sBUName,
      this.userSubType,
      this.dealerCode,
      this.status,
      this.reason});

  Data.fromJson(Map<String, dynamic> json) {
    loginType = json['LoginType'];
    userId = json['UserId'];
    userName = json['UserName'];
    emailId = json['EmailId'];
    userRole = json['UserRole'];
    firstName = json['FirstName'];
    lastName = json['LastName'];
    statusId = json['StatusId'];
    statusName = json['StatusName'];
    mobileNo = json['MobileNo'];
    regionalOfficeID = json['RegionalOfficeID'];
    regionalOfficeName = json['RegionalOfficeName'];
    zonalOfficeID = json['ZonalOfficeID'];
    zonalOfficeName = json['ZonalOfficeName'];
    token = json['Token'];
    profileImg = json['ProfileImg'];
    sBUTypeId = json['SBUTypeId'];
    sBUName = json['SBUName'];
    userSubType = json['UserSubType'];
    dealerCode = json['DealerCode'];
    status = json['Status'];
    reason = json['Reason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['LoginType'] = this.loginType;
    data['UserId'] = this.userId;
    data['UserName'] = this.userName;
    data['EmailId'] = this.emailId;
    data['UserRole'] = this.userRole;
    data['FirstName'] = this.firstName;
    data['LastName'] = this.lastName;
    data['StatusId'] = this.statusId;
    data['StatusName'] = this.statusName;
    data['MobileNo'] = this.mobileNo;
    data['RegionalOfficeID'] = this.regionalOfficeID;
    data['RegionalOfficeName'] = this.regionalOfficeName;
    data['ZonalOfficeID'] = this.zonalOfficeID;
    data['ZonalOfficeName'] = this.zonalOfficeName;
    data['Token'] = this.token;
    data['MobileUserRole'] = this.mobileUserRole;
    data['ProfileImg'] = this.profileImg;
    data['SBUTypeId'] = this.sBUTypeId;
    data['SBUName'] = this.sBUName;
    data['UserSubType'] = this.userSubType;
    data['DealerCode'] = this.dealerCode;
    data['Status'] = this.status;
    data['Reason'] = this.reason;
    return data;
  }
}
