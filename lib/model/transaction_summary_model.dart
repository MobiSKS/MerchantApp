// ignore_for_file: prefer_void_to_null

class TransactionSummaryModel {
  bool? success;
  int? statusCode;
  int? internelStatusCode;
  String? message;
  String? methodName;
  Data? data;
  Null modelState;

  TransactionSummaryModel(
      {this.success,
      this.statusCode,
      this.internelStatusCode,
      this.message,
      this.methodName,
      this.data,
      this.modelState});

  TransactionSummaryModel.fromJson(Map<String, dynamic> json) {
    success = json['Success'];
    statusCode = json['Status_Code'];
    internelStatusCode = json['Internel_Status_Code'];
    message = json['Message'];
    methodName = json['Method_Name'];
    data = json['Data'] != null ?  Data.fromJson(json['Data']) : null;
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
  List<GetTransactionsSaleSummary>? getTransactionsSaleSummary;
  List<GetTransactionsDetailSummary>? getTransactionsDetailSummary;

  Data({this.getTransactionsSaleSummary, this.getTransactionsDetailSummary});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['GetTransactionsSaleSummary'] != null) {
      getTransactionsSaleSummary = <GetTransactionsSaleSummary>[];
      json['GetTransactionsSaleSummary'].forEach((v) {
        getTransactionsSaleSummary!
            .add( GetTransactionsSaleSummary.fromJson(v));
      });
    }
    if (json['GetTransactionsDetailSummary'] != null) {
      getTransactionsDetailSummary = <GetTransactionsDetailSummary>[];
      json['GetTransactionsDetailSummary'].forEach((v) {
        getTransactionsDetailSummary!
            .add( GetTransactionsDetailSummary.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (getTransactionsSaleSummary != null) {
      data['GetTransactionsSaleSummary'] =
          getTransactionsSaleSummary!.map((v) => v.toJson()).toList();
    }
    if (getTransactionsDetailSummary != null) {
      data['GetTransactionsDetailSummary'] =
          getTransactionsDetailSummary!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetTransactionsSaleSummary {
  String? accountNumber;
  String? customerName;
  String? customerId;
  int? sale;
  int? reloadCcmsCash;
  int? ccmsRecharge;

  GetTransactionsSaleSummary(
      {this.accountNumber,
      this.customerName,
      this.customerId,
      this.sale,
      this.reloadCcmsCash,
      this.ccmsRecharge});

  GetTransactionsSaleSummary.fromJson(Map<String, dynamic> json) {
    accountNumber = json['AccountNumber'];
    customerName = json['CustomerName'];
    customerId = json['CustomerId'];
    sale = json['Sale'];
    reloadCcmsCash = json['ReloadCcmsCash'];
    ccmsRecharge = json['CcmsRecharge'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['AccountNumber'] = accountNumber;
    data['CustomerName'] = customerName;
    data['CustomerId'] = customerId;
    data['Sale'] = sale;
    data['ReloadCcmsCash'] = reloadCcmsCash;
    data['CcmsRecharge'] = ccmsRecharge;
    return data;
  }
}

class GetTransactionsDetailSummary {
  int? srNumber;
  String? terminalId;
  String? merchantId;
  String? retailOutletName;
  String? accountNumber;
  String? batchIdandROC;
  String? vechileNo;
  String? txnDate;
  String? txnType;
  String? productName;
  String? price;
  String? volume;
  String? currency;
  String? serviceCharge;
  double? amount;
  String? discount;
  String? odometerReading;
  String? status;
  String? mobileNo;

  GetTransactionsDetailSummary(
      {this.srNumber,
      this.terminalId,
      this.merchantId,
      this.retailOutletName,
      this.accountNumber,
      this.batchIdandROC,
      this.vechileNo,
      this.txnDate,
      this.txnType,
      this.productName,
      this.price,
      this.volume,
      this.currency,
      this.serviceCharge,
      this.amount,
      this.discount,
      this.odometerReading,
      this.status,
      this.mobileNo});

  GetTransactionsDetailSummary.fromJson(Map<String, dynamic> json) {
    srNumber = json['SrNumber'];
    terminalId = json['TerminalId'];
    merchantId = json['MerchantId'];
    retailOutletName = json['RetailOutletName'];
    accountNumber = json['AccountNumber'];
    batchIdandROC = json['BatchIdandROC'];
    vechileNo = json['VechileNo'];
    txnDate = json['TxnDate'];
    txnType = json['TxnType'];
    productName = json['ProductName'];
    price = json['Price'];
    volume = json['Volume'];
    currency = json['Currency'];
    serviceCharge = json['ServiceCharge'];
    amount = json['Amount'];
    discount = json['Discount'];
    odometerReading = json['OdometerReading'];
    status = json['Status'];
    mobileNo = json['MobileNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['SrNumber'] = srNumber;
    data['TerminalId'] = terminalId;
    data['MerchantId'] = merchantId;
    data['RetailOutletName'] = retailOutletName;
    data['AccountNumber'] = accountNumber;
    data['BatchIdandROC'] = batchIdandROC;
    data['VechileNo'] = vechileNo;
    data['TxnDate'] = txnDate;
    data['TxnType'] = txnType;
    data['ProductName'] = productName;
    data['Price'] = price;
    data['Volume'] = volume;
    data['Currency'] = currency;
    data['ServiceCharge'] = serviceCharge;
    data['Amount'] = amount;
    data['Discount'] = discount;
    data['OdometerReading'] = odometerReading;
    data['Status'] = status;
    data['MobileNo'] = mobileNo;
    return data;
  }
}
