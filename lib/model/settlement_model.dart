class SettlementModel {
  bool? success;
  int? statusCode;
  int? internelStatusCode;
  String? message;
  String? methodName;
  Data? data;
  Null? modelState;

  SettlementModel(
      {this.success,
      this.statusCode,
      this.internelStatusCode,
      this.message,
      this.methodName,
      this.data,
      this.modelState});

  SettlementModel.fromJson(Map<String, dynamic> json) {
    success = json['Success'];
    statusCode = json['Status_Code'];
    internelStatusCode = json['Internel_Status_Code'];
    message = json['Message'];
    methodName = json['Method_Name'];
    data = json['Data'] != null ? new Data.fromJson(json['Data']) : null;
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
      data['Data'] = this.data!.toJson();
    }
    data['Model_State'] = this.modelState;
    return data;
  }
}

class Data {
  List<SettleMentDetails>? settleMentDetails;
  List<SettleTransactionDetails>? settleTransactionDetails;
  SuccessDetails? successDetails;

  Data(
      {this.settleMentDetails,
      this.settleTransactionDetails,
      this.successDetails});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['SettleMentDetails'] != null) {
      settleMentDetails = <SettleMentDetails>[];
      json['SettleMentDetails'].forEach((v) {
        settleMentDetails!.add(new SettleMentDetails.fromJson(v));
      });
    }
    if (json['SettleTransactionDetails'] != null) {
      settleTransactionDetails = <SettleTransactionDetails>[];
      json['SettleTransactionDetails'].forEach((v) {
        settleTransactionDetails!.add(new SettleTransactionDetails.fromJson(v));
      });
    }
    successDetails = json['SuccessDetails'] != null
        ? new SuccessDetails.fromJson(json['SuccessDetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.settleMentDetails != null) {
      data['SettleMentDetails'] =
          this.settleMentDetails!.map((v) => v.toJson()).toList();
    }
    if (this.settleTransactionDetails != null) {
      data['SettleTransactionDetails'] =
          this.settleTransactionDetails!.map((v) => v.toJson()).toList();
    }
    if (this.successDetails != null) {
      data['SuccessDetails'] = this.successDetails!.toJson();
    }
    return data;
  }
}

class SettleMentDetails {
  int? noOfSettlement;
  double? totalAmout;

  SettleMentDetails({this.noOfSettlement, this.totalAmout});

  SettleMentDetails.fromJson(Map<String, dynamic> json) {
    noOfSettlement = json['NoOfSettlement'];
    totalAmout = json['TotalAmout'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['NoOfSettlement'] = this.noOfSettlement;
    data['TotalAmout'] = this.totalAmout;
    return data;
  }
}

class SettleTransactionDetails {
  String? merchantId;
  int? batchId;
  int? invoiceNo;
  String? terminalId;
  String? transactionDate;
  String? transactionType;
  double? amount;

  SettleTransactionDetails(
      {this.merchantId,
      this.batchId,
      this.invoiceNo,
      this.terminalId,
      this.transactionDate,
      this.transactionType,
      this.amount});

  SettleTransactionDetails.fromJson(Map<String, dynamic> json) {
    merchantId = json['MerchantId'];
    batchId = json['BatchId'];
    invoiceNo = json['InvoiceNo'];
    terminalId = json['TerminalId'];
    transactionDate = json['TransactionDate'];
    transactionType = json['TransactionType'];
    amount = json['Amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['MerchantId'] = this.merchantId;
    data['BatchId'] = this.batchId;
    data['InvoiceNo'] = this.invoiceNo;
    data['TerminalId'] = this.terminalId;
    data['TransactionDate'] = this.transactionDate;
    data['TransactionType'] = this.transactionType;
    data['Amount'] = this.amount;
    return data;
  }
}

class SuccessDetails {
  int? status;
  String? reason;

  SuccessDetails({this.status, this.reason});

  SuccessDetails.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    reason = json['Reason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Status'] = this.status;
    data['Reason'] = this.reason;
    return data;
  }
}
