// ignore_for_file: prefer_typing_uninitialized_variables

class ReceivablePayableModel {
  bool? success;
  int? statusCode;
  int? internelStatusCode;
  String? message;
  String? methodName;
  List<Data>? data;
  var modelState;

  ReceivablePayableModel(
      {this.success,
        this.statusCode,
        this.internelStatusCode,
        this.message,
        this.methodName,
        this.data,
        this.modelState});

  ReceivablePayableModel.fromJson(Map<String, dynamic> json) {
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
    if(json['Model_State'] != null) {
      modelState = json['Model_State'];
    }
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
  String? terminalId;
  int? batchId;
  String? settlementDate;
  String? receivable;
  String? payable;

  Data(
      {this.srNumber,
        this.terminalId,
        this.batchId,
        this.settlementDate,
        this.receivable,
        this.payable});

  Data.fromJson(Map<String, dynamic> json) {
    srNumber = json['SrNumber'];
    terminalId = json['TerminalId'];
    batchId = json['BatchId'];
    settlementDate = json['SettlementDate'];
    receivable = json['Receivable'];
    payable = json['Payable'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['SrNumber'] = srNumber;
    data['TerminalId'] = terminalId;
    data['BatchId'] = batchId;
    data['SettlementDate'] = settlementDate;
    data['Receivable'] = receivable;
    data['Payable'] = payable;
    return data;
  }
}
