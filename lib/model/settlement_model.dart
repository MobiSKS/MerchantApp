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
  int? batchId;
  String? terminalId;
  String? status;
  String? noofTransactions;
  String? settlementDate;

  Data(
      {this.batchId,
      this.terminalId,
      this.status,
      this.noofTransactions,
      this.settlementDate});

  Data.fromJson(Map<String, dynamic> json) {
    batchId = json['BatchId'];
    terminalId = json['TerminalId'];
    status = json['Status'];
    noofTransactions = json['NoofTransactions'];
    settlementDate = json['SettlementDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['BatchId'] = this.batchId;
    data['TerminalId'] = this.terminalId;
    data['Status'] = this.status;
    data['NoofTransactions'] = this.noofTransactions;
    data['SettlementDate'] = this.settlementDate;
    return data;
  }
}
