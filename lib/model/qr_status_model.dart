// ignore_for_file: prefer_void_to_null, prefer_collection_literals

class QRStatusModel {
  bool? success;
  int? statusCode;
  int? internelStatusCode;
  String? message;
  String? methodName;
  List<Data>? data;
  Null modelState;

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
        data!.add(Data.fromJson(v));
      });
    }
    modelState = json['Model_State'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['QRRequestId'] = qRRequestId;
    data['Amount'] = amount;
    data['InvoiceDateTime'] = invoiceDateTime;
    data['TerminalId'] = terminalId;
    data['BatchNo'] = batchNo;
    data['ROCNo'] = rOCNo;
    data['MobileNo'] = mobileNo;
    data['CardNo'] = cardNo;
    data['Product'] = product;
    data['RSP'] = rSP;
    data['Volume'] = volume;
    data['Balance'] = balance;
    data['TxnId'] = txnId;
    data['Status'] = status;
    data['Reason'] = reason;
    return data;
  }
}
