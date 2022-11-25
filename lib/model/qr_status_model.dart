class QRStatusModel {
  bool? success;
  int? statusCode;
  int? internelStatusCode;
  String? message;
  String? methodName;
  List<Data>? data;
  Null? modelState;

  QRStatusModel(
      {this.success,
      this.statusCode,
      this.internelStatusCode,
      this.message,
      this.methodName,
      this.data,
      this.modelState});

  QRStatusModel.fromJson(Map<String, dynamic> json) {
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
  String? qRRequestId;
  String? amount;
  String? invoiceDateTime;
  String? terminalId;
  String? batchNo;
  String? rOCNo;
  String? mobileNo;
  String? cardNo;
  String? product;
  String? rSP;
  String? volume;
  String? balance;
  String? txnId;
  int? status;
  String? reason;

  Data(
      {this.qRRequestId,
      this.amount,
      this.invoiceDateTime,
      this.terminalId,
      this.batchNo,
      this.rOCNo,
      this.mobileNo,
      this.cardNo,
      this.product,
      this.rSP,
      this.volume,
      this.balance,
      this.txnId,
      this.status,
      this.reason});

  Data.fromJson(Map<String, dynamic> json) {
    qRRequestId = json['QRRequestId'];
    amount = json['Amount'];
    invoiceDateTime = json['InvoiceDateTime'];
    terminalId = json['TerminalId'];
    batchNo = json['BatchNo'];
    rOCNo = json['ROCNo'];
    mobileNo = json['MobileNo'];
    cardNo = json['CardNo'];
    product = json['Product'];
    rSP = json['RSP'];
    volume = json['Volume'];
    balance = json['Balance'];
    txnId = json['TxnId'];
    status = json['Status'];
    reason = json['Reason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['QRRequestId'] = this.qRRequestId;
    data['Amount'] = this.amount;
    data['InvoiceDateTime'] = this.invoiceDateTime;
    data['TerminalId'] = this.terminalId;
    data['BatchNo'] = this.batchNo;
    data['ROCNo'] = this.rOCNo;
    data['MobileNo'] = this.mobileNo;
    data['CardNo'] = this.cardNo;
    data['Product'] = this.product;
    data['RSP'] = this.rSP;
    data['Volume'] = this.volume;
    data['Balance'] = this.balance;
    data['TxnId'] = this.txnId;
    data['Status'] = this.status;
    data['Reason'] = this.reason;
    return data;
  }
}
