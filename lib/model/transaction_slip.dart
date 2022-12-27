class TransactionSlip {
  bool? success;
  int? statusCode;
  int? internelStatusCode;
  String? message;
  String? methodName;
  List<Data>? data;
  Null? modelState;

  TransactionSlip(
      {this.success,
      this.statusCode,
      this.internelStatusCode,
      this.message,
      this.methodName,
      this.data,
      this.modelState});

  TransactionSlip.fromJson(Map<String, dynamic> json) {
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
  String? merchantId;
  String? terminalId;
  String? cardNo;
  double? amount;
  String? referenceNo;
  String? invoiceDate;
  int? invoiceNo;
  int? status;
  Null? reason;

  Data(
      {this.merchantId,
      this.terminalId,
      this.cardNo,
      this.amount,
      this.referenceNo,
      this.invoiceDate,
      this.invoiceNo,
      this.status,
      this.reason});

  Data.fromJson(Map<String, dynamic> json) {
    merchantId = json['MerchantId'];
    terminalId = json['TerminalId'];
    cardNo = json['CardNo'];
    amount = json['Amount'];
    referenceNo = json['ReferenceNo'];
    invoiceDate = json['InvoiceDate'];
    invoiceNo = json['InvoiceNo'];
    status = json['Status'];
    reason = json['Reason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['MerchantId'] = merchantId;
    data['TerminalId'] = terminalId;
    data['CardNo'] = cardNo;
    data['Amount'] = amount;
    data['ReferenceNo'] = referenceNo;
    data['InvoiceDate'] = invoiceDate;
    data['InvoiceNo'] = invoiceNo;
    data['Status'] = status;
    data['Reason'] = reason;
    return data;
  }
}
