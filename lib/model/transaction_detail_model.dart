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
  int? srNumber;
  String? rOCNo;
  String? transTypeId;
  String? terminalId;
  String? merchantId;
  String? cardNo;
  String? retailOutletName;
  String? txnDate;
  String? productName;
  String? rSP;
  String? volume;
  String? nameOnCard;
  double? invoiceAmount;
  String? discount;
  String? mobileNo;
  String? txnID;
  String? batchId;
  String? retailOutletCity;
  String? retailOutletLocation;
  String? retailOutletAddress;
  Null? retailOutletDistrict;
  String? retailOutletState;
  double? financeChargesValue;
  String? odometerReading;
  int? recordTypeId;
  String? recordTypeName;
  int? noOfCards;
  String? transTypeName;
  int? status;
  String? reason;

  Data(
      {this.srNumber,
      this.rOCNo,
      this.transTypeId,
      this.terminalId,
      this.merchantId,
      this.cardNo,
      this.retailOutletName,
      this.txnDate,
      this.productName,
      this.rSP,
      this.volume,
      this.nameOnCard,
      this.invoiceAmount,
      this.discount,
      this.mobileNo,
      this.txnID,
      this.batchId,
      this.retailOutletCity,
      this.retailOutletLocation,
      this.retailOutletAddress,
      this.retailOutletDistrict,
      this.retailOutletState,
      this.financeChargesValue,
      this.odometerReading,
      this.recordTypeId,
      this.recordTypeName,
      this.noOfCards,
      this.transTypeName,
      this.status,
      this.reason});

  Data.fromJson(Map<String, dynamic> json) {
    srNumber = json['SrNumber'];
    rOCNo = json['ROCNo'];
    transTypeId = json['TransTypeId'];
    terminalId = json['TerminalId'];
    merchantId = json['MerchantId'];
    cardNo = json['CardNo'];
    retailOutletName = json['RetailOutletName'];
    txnDate = json['TxnDate'];
    productName = json['ProductName'];
    rSP = json['RSP'];
    volume = json['Volume'];
    nameOnCard = json['NameOnCard'];
    invoiceAmount = json['InvoiceAmount'];
    discount = json['Discount'];
    mobileNo = json['MobileNo'];
    txnID = json['TxnID'];
    batchId = json['BatchId'];
    retailOutletCity = json['RetailOutletCity'];
    retailOutletLocation = json['RetailOutletLocation'];
    retailOutletAddress = json['RetailOutletAddress'];
    retailOutletDistrict = json['RetailOutletDistrict'];
    retailOutletState = json['RetailOutletState'];
    financeChargesValue = json['FinanceChargesValue'];
    odometerReading = json['OdometerReading'];
    recordTypeId = json['RecordTypeId'];
    recordTypeName = json['RecordTypeName'];
    noOfCards = json['NoOfCards'];
    transTypeName = json['TransTypeName'];
    status = json['Status'];
    reason = json['Reason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['SrNumber'] = srNumber;
    data['ROCNo'] = rOCNo;
    data['TransTypeId'] = transTypeId;
    data['TerminalId'] = terminalId;
    data['MerchantId'] = merchantId;
    data['CardNo'] = cardNo;
    data['RetailOutletName'] = retailOutletName;
    data['TxnDate'] = txnDate;
    data['ProductName'] = productName;
    data['RSP'] = rSP;
    data['Volume'] = volume;
    data['NameOnCard'] = nameOnCard;
    data['InvoiceAmount'] = invoiceAmount;
    data['Discount'] = discount;
    data['MobileNo'] = mobileNo;
    data['TxnID'] = txnID;
    data['BatchId'] = batchId;
    data['RetailOutletCity'] = retailOutletCity;
    data['RetailOutletLocation'] = retailOutletLocation;
    data['RetailOutletAddress'] = retailOutletAddress;
    data['RetailOutletDistrict'] = retailOutletDistrict;
    data['RetailOutletState'] = retailOutletState;
    data['FinanceChargesValue'] = financeChargesValue;
    data['OdometerReading'] = odometerReading;
    data['RecordTypeId'] = recordTypeId;
    data['RecordTypeName'] = recordTypeName;
    data['NoOfCards'] = noOfCards;
    data['TransTypeName'] = transTypeName;
    data['Status'] = status;
    data['Reason'] = reason;
    return data;
  }
}
