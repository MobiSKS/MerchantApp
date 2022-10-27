class SettlementModel {
  bool? success;
  int? statusCode;
  int? internelStatusCode;
  String? message;
  String? methodName;
  List<Data>? data;
  Null? modelState;

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
  int? srNumber;
  String? terminalId;
  int? batchId;
  String? settlementDate;
  double? sale;
  double? reload;
  double? earning;
  String? jDEStatus;

  Data(
      {this.srNumber,
      this.terminalId,
      this.batchId,
      this.settlementDate,
      this.sale,
      this.reload,
      this.earning,
      this.jDEStatus});

  Data.fromJson(Map<String, dynamic> json) {
    srNumber = json['SrNumber'];
    terminalId = json['TerminalId'];
    batchId = json['BatchId'];
    settlementDate = json['SettlementDate'];
    sale = json['Sale'];
    reload = json['Reload'];
    earning = json['Earning'];
    jDEStatus = json['JDEStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SrNumber'] = this.srNumber;
    data['TerminalId'] = this.terminalId;
    data['BatchId'] = this.batchId;
    data['SettlementDate'] = this.settlementDate;
    data['Sale'] = this.sale;
    data['Reload'] = this.reload;
    data['Earning'] = this.earning;
    data['JDEStatus'] = this.jDEStatus;
    return data;
  }
}
