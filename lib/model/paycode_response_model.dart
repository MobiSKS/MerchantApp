// ignore_for_file: unnecessary_new

class PaycodeResponseModel {
  bool? success;
  int? statusCode;
  int? internelStatusCode;
  String? message;
  String? methodName;
  List<Data>? data;

  PaycodeResponseModel(
      {this.success,
      this.statusCode,
      this.internelStatusCode,
      this.message,
      this.methodName,
      this.data,
      });

  PaycodeResponseModel.fromJson(Map<String, dynamic> json) {
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
  String? balance;
  String? rSP;
  String? invAmt;
  String? volume;
  String? refNo;
  String? cardNoOutput;
  String? productName;
  String? retailOutletName;
  String? vechileNo;
  String? address;
  String? limitType;
  String? cCMSLimit;
  String? currentCardBalance;
  String? currentCCMSBalance;
  String? aPIReferenceNo;
  String? getMultipleMobileNo;
  int? status;
  String ?rocNo;
  String? reason;

  Data(
      {this.balance,
      this.rSP,
      this.invAmt,
      this.volume,
      this.refNo,
      this.cardNoOutput,
      this.productName,
      this.retailOutletName,
      this.vechileNo,
      this.address,
      this.limitType,
      this.cCMSLimit,
      this.currentCardBalance,
      this.currentCCMSBalance,
      this.aPIReferenceNo,
      this.getMultipleMobileNo,
      this.status,
      this.rocNo,
      this.reason});

  Data.fromJson(Map<String, dynamic> json) {
    balance = json['Balance'];
    rSP = json['RSP'];
    invAmt = json['InvAmt'];
    volume = json['Volume'];
    refNo = json['RefNo'];
    cardNoOutput = json['CardNoOutput'];
    productName = json['ProductName'];
    retailOutletName = json['RetailOutletName'];
    vechileNo = json['VechileNo'];
    address = json['Address'];
    limitType = json['LimitType'];
    cCMSLimit = json['CCMSLimit'];
    rocNo = json['ROCNo'];
    currentCardBalance = json['CurrentCardBalance'];
    currentCCMSBalance = json['CurrentCCMSBalance'];
    aPIReferenceNo = json['APIReferenceNo'];
    getMultipleMobileNo = json['GetMultipleMobileNo'];
    status = json['Status'];
    reason = json['Reason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['Balance'] = balance;
    data['RSP'] = rSP;
    data['InvAmt'] = invAmt;
    data['Volume'] = volume;
    data['RefNo'] = refNo;
    data['CardNoOutput'] = cardNoOutput;
    data['ProductName'] = productName;
    data['RetailOutletName'] = retailOutletName;
    data['VechileNo'] = vechileNo;
    data['Address'] = address;
    data['LimitType'] = limitType;
    data['CCMSLimit'] = cCMSLimit;
    data['CurrentCardBalance'] = currentCardBalance;
    data['CurrentCCMSBalance'] = currentCCMSBalance;
    data['APIReferenceNo'] = aPIReferenceNo;
    data['GetMultipleMobileNo'] = getMultipleMobileNo;
    data['Status'] = status;
    data['Reason'] = reason;
    return data;
  }
}
