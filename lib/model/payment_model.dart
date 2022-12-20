class PaymentModel {
  bool? success;
  int? statusCode;
  int? internelStatusCode;
  String? message;
  String? methodName;
  Data? data;
  Null? modelState;

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
  List<PaymentDetails>? paymentDetails;
  List<TransactionDetails>? transactionDetails;
  SuccessDetail? successDetail;

  Data({this.paymentDetails, this.transactionDetails, this.successDetail});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['PaymentDetails'] != null) {
      paymentDetails = <PaymentDetails>[];
      json['PaymentDetails'].forEach((v) {
        paymentDetails!.add(new PaymentDetails.fromJson(v));
      });
    }
    if (json['TransactionDetails'] != null) {
      transactionDetails = <TransactionDetails>[];
      json['TransactionDetails'].forEach((v) {
        transactionDetails!.add(new TransactionDetails.fromJson(v));
      });
    }
    successDetail = json['SuccessDetail'] != null
        ? new SuccessDetail.fromJson(json['SuccessDetail'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.paymentDetails != null) {
      data['PaymentDetails'] =
          this.paymentDetails!.map((v) => v.toJson()).toList();
    }
    if (this.transactionDetails != null) {
      data['TransactionDetails'] =
          this.transactionDetails!.map((v) => v.toJson()).toList();
    }
    if (this.successDetail != null) {
      data['SuccessDetail'] = this.successDetail!.toJson();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['NoOfPayments'] = this.noOfPayments;
    data['TotalAmout'] = this.totalAmout;
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

  TransactionDetails(
      {this.merchantId,
      this.batchId,
      this.invoiceNo,
      this.terminalId,
      this.transactionDate,
      this.transactionType,
      this.amount});

  TransactionDetails.fromJson(Map<String, dynamic> json) {
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

class SuccessDetail {
  int? status;
  String? reason;

  SuccessDetail({this.status, this.reason});

  SuccessDetail.fromJson(Map<String, dynamic> json) {
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
