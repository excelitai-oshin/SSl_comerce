import 'dart:convert';
/// status : true
/// data : {"id":"1","receipt_number":"180001","receipt_date":"19-12-2018","start_date":"2018-01-01","finish_date":"2018-06-30","month_period":"6","total_amount":"3240.00","status":"PAID"}

MemberReceiptModel memberReceiptModelFromJson(String str) => MemberReceiptModel.fromJson(json.decode(str));
String memberReceiptModelToJson(MemberReceiptModel data) => json.encode(data.toJson());
class MemberReceiptModel {
  MemberReceiptModel({
      bool? status, 
      Data? data,}){
    _status = status;
    _data = data;
}

  MemberReceiptModel.fromJson(dynamic json) {
    _status = json['status'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? _status;
  Data? _data;

  bool? get status => _status;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

/// id : "1"
/// receipt_number : "180001"
/// receipt_date : "19-12-2018"
/// start_date : "2018-01-01"
/// finish_date : "2018-06-30"
/// month_period : "6"
/// total_amount : "3240.00"
/// status : "PAID"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? id, 
      String? receiptNumber, 
      String? receiptDate, 
      String? startDate, 
      String? finishDate, 
      String? monthPeriod, 
      String? totalAmount, 
      String? status,}){
    _id = id;
    _receiptNumber = receiptNumber;
    _receiptDate = receiptDate;
    _startDate = startDate;
    _finishDate = finishDate;
    _monthPeriod = monthPeriod;
    _totalAmount = totalAmount;
    _status = status;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _receiptNumber = json['receipt_number'];
    _receiptDate = json['receipt_date'];
    _startDate = json['start_date'];
    _finishDate = json['finish_date'];
    _monthPeriod = json['month_period'];
    _totalAmount = json['total_amount'];
    _status = json['status'];
  }
  String? _id;
  String? _receiptNumber;
  String? _receiptDate;
  String? _startDate;
  String? _finishDate;
  String? _monthPeriod;
  String? _totalAmount;
  String? _status;

  String? get id => _id;
  String? get receiptNumber => _receiptNumber;
  String? get receiptDate => _receiptDate;
  String? get startDate => _startDate;
  String? get finishDate => _finishDate;
  String? get monthPeriod => _monthPeriod;
  String? get totalAmount => _totalAmount;
  String? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['receipt_number'] = _receiptNumber;
    map['receipt_date'] = _receiptDate;
    map['start_date'] = _startDate;
    map['finish_date'] = _finishDate;
    map['month_period'] = _monthPeriod;
    map['total_amount'] = _totalAmount;
    map['status'] = _status;
    return map;
  }

}