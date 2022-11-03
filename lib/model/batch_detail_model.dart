class BatchDetailModel {
  bool? success;
  int? statusCode;
  int? internelStatusCode;
  String? message;
  String? methodName;
  List<Data>? data;
  Null? modelState;

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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['InvoiceNo'] = this.invoiceNo;
    data['CardNo'] = this.cardNo;
    data['TransactionDate'] = this.transactionDate;
    data['TransactionType'] = this.transactionType;
    data['InvoiceAmount'] = this.invoiceAmount;
    data['ProductName'] = this.productName;
    data['FuelPrice'] = this.fuelPrice;
    data['ServiceCharge'] = this.serviceCharge;
    data['CcmsCashBalance'] = this.ccmsCashBalance;
    data['VoidedRoc'] = this.voidedRoc;
    data['VoidedByRoc'] = this.voidedByRoc;
    data['Volume'] = this.volume;
    return data;
  }
}
