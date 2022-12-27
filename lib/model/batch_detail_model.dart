// ignore_for_file: prefer_void_to_null

class BatchDetailModel {
  bool? success;
  int? statusCode;
  int? internelStatusCode;
  String? message;
  String? methodName;
  List<Data>? data;
  Null  modelState;

  BatchDetailModel(
      {this.success,
      this.statusCode,
      this.internelStatusCode,
      this.message,
      this.methodName,
      this.data,
      this.modelState});

  BatchDetailModel.fromJson(Map<String, dynamic> json) {
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
  int? invoiceNo;
  String? cardNo;
  String? transactionDate;
  String? transactionType;
  double? invoiceAmount;
  String? productName;
  String? fuelPrice;
  double? serviceCharge;
  double? ccmsCashBalance;
  String? voidedRoc;
  String? voidedByRoc;
  String? volume;

  Data(
      {this.invoiceNo,
      this.cardNo,
      this.transactionDate,
      this.transactionType,
      this.invoiceAmount,
      this.productName,
      this.fuelPrice,
      this.serviceCharge,
      this.ccmsCashBalance,
      this.voidedRoc,
      this.voidedByRoc,
      this.volume});

  Data.fromJson(Map<String, dynamic> json) {
    invoiceNo = json['InvoiceNo'];
    cardNo = json['CardNo'];
    transactionDate = json['TransactionDate'];
    transactionType = json['TransactionType'];
    invoiceAmount = json['InvoiceAmount'];
    productName = json['ProductName'];
    fuelPrice = json['FuelPrice'];
    serviceCharge = json['ServiceCharge'];
    ccmsCashBalance = json['CcmsCashBalance'];
    voidedRoc = json['VoidedRoc'];
    voidedByRoc = json['VoidedByRoc'];
    volume = json['Volume'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['InvoiceNo'] = invoiceNo;
    data['CardNo'] = cardNo;
    data['TransactionDate'] = transactionDate;
    data['TransactionType'] = transactionType;
    data['InvoiceAmount'] = invoiceAmount;
    data['ProductName'] = productName;
    data['FuelPrice'] = fuelPrice;
    data['ServiceCharge'] = serviceCharge;
    data['CcmsCashBalance'] = ccmsCashBalance;
    data['VoidedRoc'] = voidedRoc;
    data['VoidedByRoc'] = voidedByRoc;
    data['Volume'] = volume;
    return data;
  }
}
