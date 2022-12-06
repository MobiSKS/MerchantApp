class UserModel {
  bool? success;
  int? statusCode;
  int? internelStatusCode;
  String? message;
  String? methodName;
  Data? data;

  UserModel(
      {this.success,
      this.statusCode,
      this.internelStatusCode,
      this.message,
      this.methodName,
      this.data,
      });

  UserModel.fromJson(Map<dynamic, dynamic> json) {
    success = json['Success'];
    statusCode = json['Status_Code'];
    internelStatusCode = json['Internel_Status_Code'];
    message = json['Message'];
    methodName = json['Method_Name'];
    data = json['Data'] != null ? Data.fromJson(json['Data']) : null;
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
            .add(ObjGetParentTransTypeDetail.fromJson(v));
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
        objFormFactors!.add(ObjFormFactors.fromJson(v));
      });
    }
    if (json['ObjProduct'] != null) {
      objProduct = <ObjProduct>[];
      json['ObjProduct'].forEach((v) {
        objProduct!.add(ObjProduct.fromJson(v));
      });
    }
    if (json['ObjOutletDetails'] != null) {
      objOutletDetails = <ObjOutletDetails>[];
      json['ObjOutletDetails'].forEach((v) {
        objOutletDetails!.add(ObjOutletDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (objGetMerchantDetail != null) {
      data['ObjGetMerchantDetail'] =
          objGetMerchantDetail!.map((v) => v.toJson()).toList();
    }
    if (objGetTransTypeDetail != null) {
      data['ObjGetTransTypeDetail'] =
          objGetTransTypeDetail!.map((v) => v.toJson()).toList();
    }

    if (objBanks != null) {
      data['ObjBanks'] = objBanks!.map((v) => v.toJson()).toList();
    }
    if (objFormFactors != null) {
      data['ObjFormFactors'] =
          objFormFactors!.map((v) => v.toJson()).toList();
    }
    if (objProduct != null) {
      data['ObjProduct'] = objProduct!.map((v) => v.toJson()).toList();
    }
    if (objOutletDetails != null) {
      data['ObjOutletDetails'] =
          objOutletDetails!.map((v) => v.toJson()).toList();
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
  String ?pancard;
  double? batchSaleLimit;
  double? batchReloadLimit;
  int? batchSize;
  int? settlementTime;
  String? remoteDownload;
  String? uRL;
  String? batchNo;
  String? cardFeeAmount;
  int? statusId;
  String ?contactPersonName;
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
      this.pancard,
      this.batchSaleLimit,
      this.contactPersonName,
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
    token = json['Token'] ?? '';
    merchantId = json['MerchantId'] ?? '';
    terminalId = json['TerminalId'] ?? '';
    merchantName = json['MerchantName'] ?? '';
    pancard = json["PancardNumber"]??"";
    merchantLocation = json['MerchantLocation'] ?? '';
    header1 = json['Header1'] ?? '';
    header2 = json['Header2'] ?? '';
    footer1 = json['Footer1'] ?? '';
    footer2 = json['Footer2'] ?? '';
    contactPersonName = json["ContactPersonName"];
    batchSaleLimit = json['BatchSaleLimit'] ?? '';
    batchReloadLimit = json['BatchReloadLimit'] ?? '';
    batchSize = json['BatchSize'] ?? '';
    settlementTime = json['SettlementTime'] ?? '';
    remoteDownload = json['RemoteDownload'] ?? '';
    uRL = json['URL'] ?? '';
    batchNo = json['BatchNo'] ?? '';
    cardFeeAmount = json['CardFeeAmount'] ?? '';
    statusId = json['StatusId'] ?? '';
    statusName = json['StatusName'] ?? '';
    emailId = json['EmailId'] ?? '';
    mobileNo = json['MobileNo'] ?? '';
    status = json['Status'] ?? '';
    reason = json['Reason'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Token'] = token;
    data['MerchantId'] = merchantId;
    data['TerminalId'] = terminalId;
    data['MerchantName'] = merchantName;
    data['MerchantLocation'] = merchantLocation;
    data['Header1'] = header1;
    data['Header2'] = header2;
    data['Footer1'] = footer1;
    data['Footer2'] = footer2;
    data["PancardNumber"] = pancard;
    data['BatchSaleLimit'] = batchSaleLimit;
    data['BatchReloadLimit'] = batchReloadLimit;
    data['BatchSize'] = batchSize;
    data['SettlementTime'] = settlementTime;
    data['RemoteDownload'] = remoteDownload;
    data['URL'] = uRL;
    data["ContactPersonName"] = contactPersonName;
    data['BatchNo'] = batchNo;
    data['CardFeeAmount'] = cardFeeAmount;
    data['StatusId'] = statusId;
    data['StatusName'] = statusName;
    data['EmailId'] = emailId;
    data['MobileNo'] = mobileNo;
    data['Status'] = status;
    data['Reason'] = reason;
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
    serialNo = json['SerialNo'] ?? '';
    type = json['Type'] ?? '';
    transType = json['TransType'] ?? '';
    transName = json['TransName'] ?? '';
    maxVal = json['MaxVal'] ?? '';
    minVal = json['MinVal'] ?? '';
    serviceStatus = json['ServiceStatus'] ?? '';
    carded = json['Carded'] ?? '';
    cardless = json['Cardless'] ?? '';
    nonCarded = json['NonCarded'] ?? '';
    parentId = json['ParentId'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['SerialNo'] = serialNo;
    data['Type'] = type;
    data['TransType'] = transType;
    data['TransName'] = transName;
    data['MaxVal'] = maxVal;
    data['MinVal'] = minVal;
    data['ServiceStatus'] = serviceStatus;
    data['Carded'] = carded;
    data['Cardless'] = cardless;
    data['NonCarded'] = nonCarded;
    data['ParentId'] = parentId;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['SerialNo'] = serialNo;
    data['Type'] = type;
    data['TransType'] = transType;
    data['TransName'] = transName;
    data['MaxVal'] = maxVal;
    data['MinVal'] = minVal;
    data['ServiceStatus'] = serviceStatus;
    data['Carded'] = carded;
    data['Cardless'] = cardless;
    data['NonCarded'] = nonCarded;
    data['ParentId'] = parentId;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['FastagId'] = fastagId;
    data['FastagName'] = fastagName;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['FormFactorId'] = formFactorId;
    data['FormFactorName'] = formFactorName;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ProductId'] = productId;
    data['ProductName'] = productName;
    data['ProductStatus'] = productStatus;
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
  String? gSTNumber;
  String? stateName;
  String ?districtNAme;
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
      this.districtNAme,
      this.stateName,
      this.regionalOfficeName,
      this.erpCode,
      this.salesArea});

  ObjOutletDetails.fromJson(Map<String, dynamic> json) {
    outletCategoryName = json['OutletCategoryName'] ?? '';
    merchantTypeName = json['MerchantTypeName'] ?? '';
    emailId = json['EmailId'] ?? '';
    mobileNo = json['MobileNo'] ?? '';
    retailOutletAddress1 = json['RetailOutletAddress1'] ?? '';
    retailOutletAddress2 = json['RetailOutletAddress2'] ?? '';
    retailOutletAddress3 = json['RetailOutletAddress3'] ?? '';
    retailOutletPhoneNumber = json['RetailOutletPhoneNumber'] ?? '';
    gSTNumber = json['GSTNumber'] ?? '';
    stateName = json['StateName'] ?? "";
   districtNAme = json["DistrictName"];
    retailOutletCity = json['RetailOutletCity'] ?? '';
    retailOutletDistrictId = json['RetailOutletDistrictId'] ?? '';
    retailOutletPinNumber = json['RetailOutletPinNumber'] ?? '';
    retailOutletName = json['RetailOutletName'] ?? '';
    zonalOfficeName = json['ZonalOfficeName'] ?? '';
    regionalOfficeName = json['RegionalOfficeName'] ?? '';
    erpCode = json['ErpCode'] ?? '';
    salesArea = json['SalesArea'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['OutletCategoryName'] = outletCategoryName;
    data['MerchantTypeName'] = merchantTypeName;
    data['EmailId'] = emailId;
    data["DistrictName"] =districtNAme;
    data['StateName'] = stateName;
    data['MobileNo'] = mobileNo;
    data['RetailOutletAddress1'] = retailOutletAddress1;
    data['RetailOutletAddress2'] = retailOutletAddress2;
    data['RetailOutletAddress3'] = retailOutletAddress3;
    data['RetailOutletPhoneNumber'] = retailOutletPhoneNumber;
    data['GSTNumber'] = gSTNumber;
    data['RetailOutletCity'] = retailOutletCity;
    data['RetailOutletDistrictId'] = retailOutletDistrictId;
    data['RetailOutletPinNumber'] = retailOutletPinNumber;
    data['RetailOutletName'] = retailOutletName;
    data['ZonalOfficeName'] = zonalOfficeName;
    data['RegionalOfficeName'] = regionalOfficeName;
    data['ErpCode'] = erpCode;
    data['SalesArea'] = salesArea;
    return data;
  }
}
