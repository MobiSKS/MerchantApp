class UserModel {
  bool? success;
  int? statusCode;
  int? internelStatusCode;
  String? message;
  String? methodName;
  Data? data;
  Null? modelState;

  UserModel(
      {this.success,
      this.statusCode,
      this.internelStatusCode,
      this.message,
      this.methodName,
      this.data,
      this.modelState});

  UserModel.fromJson(Map<dynamic, dynamic> json) {
    success = json['Success'];
    statusCode = json['Status_Code'];
    internelStatusCode = json['Internel_Status_Code'];
    message = json['Message'];
    methodName = json['Method_Name'];
    data = json['Data'] != null ? Data.fromJson(json['Data']) : null;
    modelState = json['Model_State'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
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
  List<ObjGetMerchantDetail>? objGetMerchantDetail;
  List<ObjGetTransTypeDetail>? objGetTransTypeDetail;
  List<ObjGetParentTransTypeDetail>? objGetParentTransTypeDetail;
  List<ObjBanks>? objBanks;
  List<ObjFormFactors>? objFormFactors;
  List<ObjProduct>? objProduct;
  List<ObjOutletDetails>? objOutletDetails;

  Data(
      {this.objGetMerchantDetail,
      this.objGetTransTypeDetail,
      this.objBanks,
      this.objFormFactors,
      this.objGetParentTransTypeDetail,
      this.objProduct,
      this.objOutletDetails});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['ObjGetMerchantDetail'] != null) {
      objGetMerchantDetail = <ObjGetMerchantDetail>[];
      json['ObjGetMerchantDetail'].forEach((v) {
        objGetMerchantDetail!.add(ObjGetMerchantDetail.fromJson(v));
      });
    }
    if (json['ObjGetTransTypeDetail'] != null) {
      objGetTransTypeDetail = <ObjGetTransTypeDetail>[];
      json['ObjGetTransTypeDetail'].forEach((v) {
        objGetTransTypeDetail!.add(ObjGetTransTypeDetail.fromJson(v));
      });
    }
    if (json['ObjGetParentTransTypeDetail'] != null) {
      objGetParentTransTypeDetail = <ObjGetParentTransTypeDetail>[];
      json['ObjGetParentTransTypeDetail'].forEach((v) {
        objGetParentTransTypeDetail!
            .add(new ObjGetParentTransTypeDetail.fromJson(v));
      });
    }
    if (json['ObjBanks'] != null) {
      objBanks = <ObjBanks>[];
      json['ObjBanks'].forEach((v) {
        objBanks!.add(ObjBanks.fromJson(v));
      });
    }
    if (json['ObjFormFactors'] != null) {
      objFormFactors = <ObjFormFactors>[];
      json['ObjFormFactors'].forEach((v) {
        objFormFactors!.add(new ObjFormFactors.fromJson(v));
      });
    }
    if (json['ObjProduct'] != null) {
      objProduct = <ObjProduct>[];
      json['ObjProduct'].forEach((v) {
        objProduct!.add(new ObjProduct.fromJson(v));
      });
    }
    if (json['ObjOutletDetails'] != null) {
      objOutletDetails = <ObjOutletDetails>[];
      json['ObjOutletDetails'].forEach((v) {
        objOutletDetails!.add(new ObjOutletDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.objGetMerchantDetail != null) {
      data['ObjGetMerchantDetail'] =
          this.objGetMerchantDetail!.map((v) => v.toJson()).toList();
    }
    if (this.objGetTransTypeDetail != null) {
      data['ObjGetTransTypeDetail'] =
          this.objGetTransTypeDetail!.map((v) => v.toJson()).toList();
    }

    if (this.objBanks != null) {
      data['ObjBanks'] = this.objBanks!.map((v) => v.toJson()).toList();
    }
    if (this.objFormFactors != null) {
      data['ObjFormFactors'] =
          this.objFormFactors!.map((v) => v.toJson()).toList();
    }
    if (this.objProduct != null) {
      data['ObjProduct'] = this.objProduct!.map((v) => v.toJson()).toList();
    }
    if (this.objOutletDetails != null) {
      data['ObjOutletDetails'] =
          this.objOutletDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ObjGetMerchantDetail {
  String? token;
  String? merchantId;
  String? terminalId;
  String? merchantName;
  String? merchantLocation;
  String? header1;
  String? header2;
  String? footer1;
  String? footer2;
  double? batchSaleLimit;
  double? batchReloadLimit;
  int? batchSize;
  int? settlementTime;
  String? remoteDownload;
  String? uRL;
  String? batchNo;
  String? cardFeeAmount;
  int? statusId;
  String? statusName;
  String? emailId;
  String? mobileNo;
  int? status;
  String? reason;

  ObjGetMerchantDetail(
      {this.token,
      this.merchantId,
      this.terminalId,
      this.merchantName,
      this.merchantLocation,
      this.header1,
      this.header2,
      this.footer1,
      this.footer2,
      this.batchSaleLimit,
      this.batchReloadLimit,
      this.batchSize,
      this.settlementTime,
      this.remoteDownload,
      this.uRL,
      this.batchNo,
      this.cardFeeAmount,
      this.statusId,
      this.statusName,
      this.emailId,
      this.mobileNo,
      this.status,
      this.reason});

  ObjGetMerchantDetail.fromJson(Map<String, dynamic> json) {
    token = json['Token'];
    merchantId = json['MerchantId'];
    terminalId = json['TerminalId'];
    merchantName = json['MerchantName'];
    merchantLocation = json['MerchantLocation'];
    header1 = json['Header1'];
    header2 = json['Header2'];
    footer1 = json['Footer1'];
    footer2 = json['Footer2'];
    batchSaleLimit = json['BatchSaleLimit'];
    batchReloadLimit = json['BatchReloadLimit'];
    batchSize = json['BatchSize'];
    settlementTime = json['SettlementTime'];
    remoteDownload = json['RemoteDownload'];
    uRL = json['URL'];
    batchNo = json['BatchNo'];
    cardFeeAmount = json['CardFeeAmount'];
    statusId = json['StatusId'];
    statusName = json['StatusName'];
    emailId = json['EmailId'];
    mobileNo = json['MobileNo'];
    status = json['Status'];
    reason = json['Reason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Token'] = this.token;
    data['MerchantId'] = this.merchantId;
    data['TerminalId'] = this.terminalId;
    data['MerchantName'] = this.merchantName;
    data['MerchantLocation'] = this.merchantLocation;
    data['Header1'] = this.header1;
    data['Header2'] = this.header2;
    data['Footer1'] = this.footer1;
    data['Footer2'] = this.footer2;
    data['BatchSaleLimit'] = this.batchSaleLimit;
    data['BatchReloadLimit'] = this.batchReloadLimit;
    data['BatchSize'] = this.batchSize;
    data['SettlementTime'] = this.settlementTime;
    data['RemoteDownload'] = this.remoteDownload;
    data['URL'] = this.uRL;
    data['BatchNo'] = this.batchNo;
    data['CardFeeAmount'] = this.cardFeeAmount;
    data['StatusId'] = this.statusId;
    data['StatusName'] = this.statusName;
    data['EmailId'] = this.emailId;
    data['MobileNo'] = this.mobileNo;
    data['Status'] = this.status;
    data['Reason'] = this.reason;
    return data;
  }
}

class ObjGetTransTypeDetail {
  int? serialNo;
  String? type;
  int? transType;
  String? transName;
  double? maxVal;
  double? minVal;
  int? serviceStatus;
  int? carded;
  int? cardless;
  int? nonCarded;
  int? parentId;

  ObjGetTransTypeDetail(
      {this.serialNo,
      this.type,
      this.transType,
      this.transName,
      this.maxVal,
      this.minVal,
      this.serviceStatus,
      this.carded,
      this.cardless,
      this.nonCarded,
      this.parentId});

  ObjGetTransTypeDetail.fromJson(Map<String, dynamic> json) {
    serialNo = json['SerialNo'];
    type = json['Type'];
    transType = json['TransType'];
    transName = json['TransName'];
    maxVal = json['MaxVal'];
    minVal = json['MinVal'];
    serviceStatus = json['ServiceStatus'];
    carded = json['Carded'];
    cardless = json['Cardless'];
    nonCarded = json['NonCarded'];
    parentId = json['ParentId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SerialNo'] = this.serialNo;
    data['Type'] = this.type;
    data['TransType'] = this.transType;
    data['TransName'] = this.transName;
    data['MaxVal'] = this.maxVal;
    data['MinVal'] = this.minVal;
    data['ServiceStatus'] = this.serviceStatus;
    data['Carded'] = this.carded;
    data['Cardless'] = this.cardless;
    data['NonCarded'] = this.nonCarded;
    data['ParentId'] = this.parentId;
    return data;
  }
}

class ObjGetParentTransTypeDetail {
  int? serialNo;
  String? type;
  int? transType;
  String? transName;
  double? maxVal;
  double? minVal;
  int? serviceStatus;
  int? carded;
  int? cardless;
  int? nonCarded;
  int? parentId;

  ObjGetParentTransTypeDetail(
      {this.serialNo,
      this.type,
      this.transType,
      this.transName,
      this.maxVal,
      this.minVal,
      this.serviceStatus,
      this.carded,
      this.cardless,
      this.nonCarded,
      this.parentId});

  ObjGetParentTransTypeDetail.fromJson(Map<String, dynamic> json) {
    serialNo = json['SerialNo'];
    type = json['Type'];
    transType = json['TransType'];
    transName = json['TransName'];
    maxVal = json['MaxVal'];
    minVal = json['MinVal'];
    serviceStatus = json['ServiceStatus'];
    carded = json['Carded'];
    cardless = json['Cardless'];
    nonCarded = json['NonCarded'];
    parentId = json['ParentId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['SerialNo'] = this.serialNo;
    data['Type'] = this.type;
    data['TransType'] = this.transType;
    data['TransName'] = this.transName;
    data['MaxVal'] = this.maxVal;
    data['MinVal'] = this.minVal;
    data['ServiceStatus'] = this.serviceStatus;
    data['Carded'] = this.carded;
    data['Cardless'] = this.cardless;
    data['NonCarded'] = this.nonCarded;
    data['ParentId'] = this.parentId;
    return data;
  }
}

class ObjBanks {
  int? fastagId;
  String? fastagName;

  ObjBanks({this.fastagId, this.fastagName});

  ObjBanks.fromJson(Map<String, dynamic> json) {
    fastagId = json['FastagId'];
    fastagName = json['FastagName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['FastagId'] = this.fastagId;
    data['FastagName'] = this.fastagName;
    return data;
  }
}

class ObjFormFactors {
  int? formFactorId;
  String? formFactorName;

  ObjFormFactors({this.formFactorId, this.formFactorName});

  ObjFormFactors.fromJson(Map<String, dynamic> json) {
    formFactorId = json['FormFactorId'];
    formFactorName = json['FormFactorName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['FormFactorId'] = this.formFactorId;
    data['FormFactorName'] = this.formFactorName;
    return data;
  }
}

class ObjProduct {
  int? productId;
  String? productName;
  int? productStatus;

  ObjProduct({this.productId, this.productName, this.productStatus});

  ObjProduct.fromJson(Map<String, dynamic> json) {
    productId = json['ProductId'];
    productName = json['ProductName'];
    productStatus = json['ProductStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ProductId'] = this.productId;
    data['ProductName'] = this.productName;
    data['ProductStatus'] = this.productStatus;
    return data;
  }
}

class ObjOutletDetails {
  String? outletCategoryName;
  String? merchantTypeName;
  String? emailId;
  String? mobileNo;
  String? retailOutletAddress1;
  String? retailOutletAddress2;
  String? retailOutletAddress3;
  String? retailOutletPhoneNumber;
  Null? gSTNumber;
  String? retailOutletCity;
  String? retailOutletDistrictId;
  String? retailOutletPinNumber;
  String? retailOutletName;
  String? zonalOfficeName;
  String? regionalOfficeName;
  String? erpCode;
  String? salesArea;

  ObjOutletDetails(
      {this.outletCategoryName,
      this.merchantTypeName,
      this.emailId,
      this.mobileNo,
      this.retailOutletAddress1,
      this.retailOutletAddress2,
      this.retailOutletAddress3,
      this.retailOutletPhoneNumber,
      this.gSTNumber,
      this.retailOutletCity,
      this.retailOutletDistrictId,
      this.retailOutletPinNumber,
      this.retailOutletName,
      this.zonalOfficeName,
      this.regionalOfficeName,
      this.erpCode,
      this.salesArea});

  ObjOutletDetails.fromJson(Map<String, dynamic> json) {
    outletCategoryName = json['OutletCategoryName'];
    merchantTypeName = json['MerchantTypeName'];
    emailId = json['EmailId'];
    mobileNo = json['MobileNo'];
    retailOutletAddress1 = json['RetailOutletAddress1'];
    retailOutletAddress2 = json['RetailOutletAddress2'];
    retailOutletAddress3 = json['RetailOutletAddress3'];
    retailOutletPhoneNumber = json['RetailOutletPhoneNumber'];
    gSTNumber = json['GSTNumber'];
    retailOutletCity = json['RetailOutletCity'];
    retailOutletDistrictId = json['RetailOutletDistrictId'];
    retailOutletPinNumber = json['RetailOutletPinNumber'];
    retailOutletName = json['RetailOutletName'];
    zonalOfficeName = json['ZonalOfficeName'];
    regionalOfficeName = json['RegionalOfficeName'];
    erpCode = json['ErpCode'];
    salesArea = json['SalesArea'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['OutletCategoryName'] = this.outletCategoryName;
    data['MerchantTypeName'] = this.merchantTypeName;
    data['EmailId'] = this.emailId;
    data['MobileNo'] = this.mobileNo;
    data['RetailOutletAddress1'] = this.retailOutletAddress1;
    data['RetailOutletAddress2'] = this.retailOutletAddress2;
    data['RetailOutletAddress3'] = this.retailOutletAddress3;
    data['RetailOutletPhoneNumber'] = this.retailOutletPhoneNumber;
    data['GSTNumber'] = this.gSTNumber;
    data['RetailOutletCity'] = this.retailOutletCity;
    data['RetailOutletDistrictId'] = this.retailOutletDistrictId;
    data['RetailOutletPinNumber'] = this.retailOutletPinNumber;
    data['RetailOutletName'] = this.retailOutletName;
    data['ZonalOfficeName'] = this.zonalOfficeName;
    data['RegionalOfficeName'] = this.regionalOfficeName;
    data['ErpCode'] = this.erpCode;
    data['SalesArea'] = this.salesArea;
    return data;
  }
}
