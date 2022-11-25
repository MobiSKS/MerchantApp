class GiftVoucherModel {
  bool? success;
  int? statusCode;
  int? internelStatusCode;
  String? message;
  String? methodName;
  List<Data>? data;
  Null? modelState;

  GiftVoucherModel(
      {this.success,
      this.statusCode,
      this.internelStatusCode,
      this.message,
      this.methodName,
      this.data,
      this.modelState});

  GiftVoucherModel.fromJson(Map<String, dynamic> json) {
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
  String? rocNo;
  Null? financeChargesValue;
  int? status;
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
      this.rocNo,
      this.limitType,
      this.cCMSLimit,
      this.currentCardBalance,
      this.currentCCMSBalance,
      this.aPIReferenceNo,
      this.getMultipleMobileNo,
      this.financeChargesValue,
      this.status,
      this.reason});

  Data.fromJson(Map<String, dynamic> json) {
    balance = json['Balance'];
    rSP = json['RSP'];
    invAmt = json['InvAmt'];
    volume = json['Volume'];
    refNo = json['RefNo'];
    rocNo = json['ROCNo'];
    cardNoOutput = json['CardNoOutput'];
    productName = json['ProductName'];
    retailOutletName = json['RetailOutletName'];
    vechileNo = json['VechileNo'];
    address = json['Address'];
    limitType = json['LimitType'];
    cCMSLimit = json['CCMSLimit'];
    currentCardBalance = json['CurrentCardBalance'];
    currentCCMSBalance = json['CurrentCCMSBalance'];
    aPIReferenceNo = json['APIReferenceNo'];
    getMultipleMobileNo = json['GetMultipleMobileNo'];
    financeChargesValue = json['FinanceChargesValue'];
    status = json['Status'];
    reason = json['Reason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Balance'] = this.balance;
    data['RSP'] = this.rSP;
    data['InvAmt'] = this.invAmt;
    data['Volume'] = this.volume;
    data['RefNo'] = this.refNo;
    data['CardNoOutput'] = this.cardNoOutput;
    data['ProductName'] = this.productName;
    data['RetailOutletName'] = this.retailOutletName;
    data['VechileNo'] = this.vechileNo;
    data['Address'] = this.address;
    data['LimitType'] = this.limitType;
    data['CCMSLimit'] = this.cCMSLimit;
    data['CurrentCardBalance'] = this.currentCardBalance;
    data['CurrentCCMSBalance'] = this.currentCCMSBalance;
    data['APIReferenceNo'] = this.aPIReferenceNo;
    data['GetMultipleMobileNo'] = this.getMultipleMobileNo;
    data['FinanceChargesValue'] = this.financeChargesValue;
    data['Status'] = this.status;
    data['Reason'] = this.reason;
    return data;
  }
}
