import 'dart:convert';
/// status : true
/// data : [{"id":"1","receipt_number":"180001","receipt_date":"19-12-2018",
/// "start_date":"2018-01-01","finish_date":"2018-06-30","month_period":"6",
/// "total_amount":"3240.00","status":"PAID","member_id":"7629",
/// "membership_number":"M01055","member_name":"Mr. Manotosh Roy",
/// "member_mobile_number":"01916-385440"}]

PaymentModel paymentModelFromJson(String str) => PaymentModel.fromJson(json.decode(str));
String paymentModelToJson(PaymentModel data) => json.encode(data.toJson());
class PaymentModel {
  PaymentModel({
      bool? status, 
      List<Data>? data,}){
    _status = status;
    _data = data;
}

  PaymentModel.fromJson(dynamic json) {
    _status = json['status'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  bool? _status;
  List<Data>? _data;

  bool? get status => _status;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
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
/// member_id : "7629"
/// membership_number : "M01055"
/// member_name : "Mr. Manotosh Roy"
/// member_mobile_number : "01916-385440"

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
      String? status, 
      String? memberId, 
      String? membershipNumber, 
      String? memberName, 
      String? memberMobileNumber,}){
    _id = id;
    _receiptNumber = receiptNumber;
    _receiptDate = receiptDate;
    _startDate = startDate;
    _finishDate = finishDate;
    _monthPeriod = monthPeriod;
    _totalAmount = totalAmount;
    _status = status;
    _memberId = memberId;
    _membershipNumber = membershipNumber;
    _memberName = memberName;
    _memberMobileNumber = memberMobileNumber;
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
    _memberId = json['member_id'];
    _membershipNumber = json['membership_number'];
    _memberName = json['member_name'];
    _memberMobileNumber = json['member_mobile_number'];
  }
  String? _id;
  String? _receiptNumber;
  String? _receiptDate;
  String? _startDate;
  String? _finishDate;
  String? _monthPeriod;
  String? _totalAmount;
  String? _status;
  String? _memberId;
  String? _membershipNumber;
  String? _memberName;
  String? _memberMobileNumber;

  String? get id => _id;
  String? get receiptNumber => _receiptNumber;
  String? get receiptDate => _receiptDate;
  String? get startDate => _startDate;
  String? get finishDate => _finishDate;
  String? get monthPeriod => _monthPeriod;
  String? get totalAmount => _totalAmount;
  String? get status => _status;
  String? get memberId => _memberId;
  String? get membershipNumber => _membershipNumber;
  String? get memberName => _memberName;
  String? get memberMobileNumber => _memberMobileNumber;

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
    map['member_id'] = _memberId;
    map['membership_number'] = _membershipNumber;
    map['member_name'] = _memberName;
    map['member_mobile_number'] = _memberMobileNumber;
    return map;
  }

}