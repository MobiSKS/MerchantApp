class TransactionDetailModel {
  bool? success;
  int? statusCode;
  int? internelStatusCode;
  String? message;
  String? methodName;
  List<Data>? data;
  Null? modelState;

  TransactionDetailModel(
      {this.success,
      this.statusCode,
      this.internelStatusCode,
      this.message,
      this.methodName,
      this.data,
      this.modelState});

  TransactionDetailModel.fromJson(Map<String, dynamic> json) {
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
  int? batchId;
  int? invoiceNo;
  String? toDate;
  String? retailOutletName;
  String? terminalId;
  String? cardNo;
  String? nameOnCard;
  String? transactionDate;
  String? transactionType;
  String? product;
  String? price;
  String? volume;
  String? currency;
  double? amount;
  String? serviceCharge;
  String? driveStars;
  String? voidedByRoc;
  String? voidedRoc;
  String? fSMName;
  String? mobileNo;
  String? status;

  Data(
      {this.batchId,
      this.invoiceNo,
      this.toDate,
      this.retailOutletName,
      this.terminalId,
      this.cardNo,
      this.nameOnCard,
      this.transactionDate,
      this.transactionType,
      this.product,
      this.price,
      this.volume,
      this.currency,
      this.amount,
      this.serviceCharge,
      this.driveStars,
      this.voidedByRoc,
      this.voidedRoc,
      this.fSMName,
      this.mobileNo,
      this.status});

  Data.fromJson(Map<String, dynamic> json) {
    batchId = json['BatchId'];
    invoiceNo = json['InvoiceNo'];
    toDate = json['ToDate'];
    retailOutletName = json['RetailOutletName'];
    terminalId = json['TerminalId'];
    cardNo = json['CardNo'];
    nameOnCard = json['NameOnCard'];
    transactionDate = json['TransactionDate'];
    transactionType = json['TransactionType'];
    product = json['Product'];
    price = json['Price'];
    volume = json['Volume'];
    currency = json['Currency'];
    amount = json['Amount'];
    serviceCharge = json['ServiceCharge'];
    driveStars = json['DriveStars'];
    voidedByRoc = json['VoidedByRoc'];
    voidedRoc = json['VoidedRoc'];
    fSMName = json['FSMName'];
    mobileNo = json['MobileNo'];
    status = json['Status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['BatchId'] = this.batchId;
    data['InvoiceNo'] = this.invoiceNo;
    data['ToDate'] = this.toDate;
    data['RetailOutletName'] = this.retailOutletName;
    data['TerminalId'] = this.terminalId;
    data['CardNo'] = this.cardNo;
    data['NameOnCard'] = this.nameOnCard;
    data['TransactionDate'] = this.transactionDate;
    data['TransactionType'] = this.transactionType;
    data['Product'] = this.product;
    data['Price'] = this.price;
    data['Volume'] = this.volume;
    data['Currency'] = this.currency;
    data['Amount'] = this.amount;
    data['ServiceCharge'] = this.serviceCharge;
    data['DriveStars'] = this.driveStars;
    data['VoidedByRoc'] = this.voidedByRoc;
    data['VoidedRoc'] = this.voidedRoc;
    data['FSMName'] = this.fSMName;
    data['MobileNo'] = this.mobileNo;
    data['Status'] = this.status;
    return data;
  }
}
