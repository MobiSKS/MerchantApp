// ignore_for_file: prefer_void_to_null

class PaymentModel {
  bool? success;
  int? statusCode;
  int? internelStatusCode;
  String? message;
  String? methodName;
  Data? data;
  Null modelState;

  PaymentModel(
      {this.success,
      this.statusCode,
      this.internelStatusCode,
      this.message,
      this.methodName,
      this.data,
      this.modelState});

  PaymentModel.fromJson(Map<String, dynamic> json) {
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
  List<PaymentDetails>? paymentDetails;
  List<TransactionDetails>? transactionDetails;
  SuccessDetail? successDetail;

  Data({this.paymentDetails, this.transactionDetails, this.successDetail});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['PaymentDetails'] != null) {
      paymentDetails = <PaymentDetails>[];
      json['PaymentDetails'].forEach((v) {
        paymentDetails!.add(PaymentDetails.fromJson(v));
      });
    }
    if (json['TransactionDetails'] != null) {
      transactionDetails = <TransactionDetails>[];
      json['TransactionDetails'].forEach((v) {
        transactionDetails!.add(TransactionDetails.fromJson(v));
      });
    }
    successDetail = json['SuccessDetail'] != null
        ? SuccessDetail.fromJson(json['SuccessDetail'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (paymentDetails != null) {
      data['PaymentDetails'] = paymentDetails!.map((v) => v.toJson()).toList();
    }
    if (transactionDetails != null) {
      data['TransactionDetails'] =
          transactionDetails!.map((v) => v.toJson()).toList();
    }
    if (successDetail != null) {
      data['SuccessDetail'] = successDetail!.toJson();
    }
    return data;
  }
}

class PaymentDetails {
  int? noOfPayments;
  double? totalAmout;

  PaymentDetails({this.noOfPayments, this.totalAmout});

  PaymentDetails.fromJson(Map<String, dynamic> json) {
    noOfPayments = json['NoOfPayments'];
    totalAmout = json['TotalAmout'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['NoOfPayments'] = noOfPayments;
    data['TotalAmout'] = totalAmout;
    return data;
  }
}

class TransactionDetails {
  String? merchantId;
  int? batchId;
  int? invoiceNo;
  String? terminalId;
  String? transactionDate;
  String? transactionType;
  double? amount;
  String? batchStatus;
  String?acknowledgementStatus ;

  TransactionDetails(
      {this.merchantId,
      this.batchId,
      this.invoiceNo,
      this.terminalId,
      this.transactionDate,
      this.transactionType,
      this.batchStatus,
      this.acknowledgementStatus,
      this.amount});

  TransactionDetails.fromJson(Map<String, dynamic> json) {
    merchantId = json['MerchantId'];
    batchId = json['BatchId'];
    invoiceNo = json['InvoiceNo'];
    terminalId = json['TerminalId'];
    transactionDate = json['TransactionDate'];
    transactionType = json['TransactionType'];
    amount = json['Amount'];
    batchStatus = json['BatchStatus'];
    acknowledgementStatus = json['AcknowledgementStatus'];
  }

  Map<String, dynamic> toJson() {
    // ignore: prefer_collection_literals
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['MerchantId'] = merchantId;
    data['BatchId'] = batchId;
    data['InvoiceNo'] = invoiceNo;
    data['TerminalId'] = terminalId;
    data['TransactionDate'] = transactionDate;
    data['TransactionType'] = transactionType;
    data['Amount'] = amount;
    data['BatchStatus '] = batchStatus;
    data['acknowledgementStatus'] =acknowledgementStatus;
    return data;
  }
}

class SuccessDetail {
  int? status;
  String? reason;

  SuccessDetail({this.status, this.reason});

  SuccessDetail.fromJson(Map<String, dynamic> json) {
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

class GroupedTransactionSlip {
  int? batchId;
  List<TransactionDetails>? transSlipList;

  GroupedTransactionSlip({this.batchId, this.transSlipList});
}
