// ignore_for_file: prefer_void_to_null

class SettlementModel {
  bool? success;
  int? statusCode;
  int? internelStatusCode;
  String? message;
  String? methodName;
  Data? data;
  Null modelState;

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
    data = json['Data'] != null ? Data.fromJson(json['Data']) : null;
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
      data['Data'] = this.data!.toJson();
    }
    data['Model_State'] = modelState;
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
        settleMentDetails!.add(SettleMentDetails.fromJson(v));
      });
    }
    if (json['SettleTransactionDetails'] != null) {
      settleTransactionDetails = <SettleTransactionDetails>[];
      json['SettleTransactionDetails'].forEach((v) {
        settleTransactionDetails!.add(SettleTransactionDetails.fromJson(v));
      });
    }
    successDetails = json['SuccessDetails'] != null
        ? SuccessDetails.fromJson(json['SuccessDetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (settleMentDetails != null) {
      data['SettleMentDetails'] =
          settleMentDetails!.map((v) => v.toJson()).toList();
    }
    if (settleTransactionDetails != null) {
      data['SettleTransactionDetails'] =
          settleTransactionDetails!.map((v) => v.toJson()).toList();
    }
    if (successDetails != null) {
      data['SuccessDetails'] = successDetails!.toJson();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['NoOfSettlement'] = noOfSettlement;
    data['TotalAmout'] = totalAmout;
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
  String ? batchStatus;
  String?acknowledgementStatus;
  double? amount;

  SettleTransactionDetails(
      {this.merchantId,
      this.batchId,
      this.invoiceNo,
      this.terminalId,
      this.transactionDate,
      this.acknowledgementStatus,
      this.batchStatus,
      this.transactionType,
      this.amount});

  SettleTransactionDetails.fromJson(Map<String, dynamic> json) {
    merchantId = json['MerchantId'];
    batchId = json['BatchId'];
    invoiceNo = json['InvoiceNo'];
    terminalId = json['TerminalId'];
    transactionDate = json['TransactionDate'];
    transactionType = json['TransactionType'];
    batchStatus = json['BatchStatus'];
    acknowledgementStatus = json['AcknowledgementStatus'];
    amount = json['Amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['MerchantId'] = merchantId;
    data['BatchId'] = batchId;
    data['InvoiceNo'] = invoiceNo;
    data['TerminalId'] = terminalId;
    data['TransactionDate'] = transactionDate;
    data['TransactionType'] = transactionType;
    data['Amount'] = amount;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Status'] = status;
    data['Reason'] = reason;
    return data;
  }
}

class GroupedSettlementData {
  int? batchId;
  List<SettleTransactionDetails>? settlementList;

  GroupedSettlementData({
    this.batchId,
    this.settlementList,
  });
}
