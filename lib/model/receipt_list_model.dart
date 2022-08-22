import 'dart:convert';
/// status : true
/// data :
/// [
///        {
///            "id":"3820",
///            "receipt_number":"193134",
///            "receipt_date":"04-04-2019",
///            "start_date":"2019-01-01",
///            "finish_date":"2019-12-31",
///            "month_period":"12",
///            "total_amount":"8250.00",
///            "status":"UNPAID",
///            "member_id":"2",
///            "membership_number":"A00014",
///            "member_name":"Mr.Md.Abdus Sattar (M.A.Sattar)",
///            "member_mobile_number":"7163667,  01819-128496"
///       },
/// {"id":"17435","receipt_number":"202356","receipt_date":"23-03-2020",
/// "start_date":"2020-01-01","finish_date":"2020-12-31",
/// "month_period":"12","total_amount":"8250.00","status":"UNPAID",
/// "member_id":"2","membership_number":"A00014",
/// "member_name":"Mr.Md.Abdus Sattar (M.A.Sattar)",
/// "member_mobile_number":"7163667,  01819-128496"},
/// {"id":"28422","receipt_number":"215323","receipt_date":"28-06-2021",
/// "start_date":"2021-01-01","finish_date":"2021-12-31","month_period":"12",
/// "total_amount":"8450.00","status":"UNPAID","member_id":"2",
/// "membership_number":"A00014","member_name":"Mr.Md.Abdus Sattar (M.A.Sattar)",
/// "member_mobile_number":"7163667,  01819-128496"},
/// {"id":"28442","receipt_number":"215334","receipt_date":"28-06-2021",
/// "start_date":"2022-01-01","finish_date":"2022-12-31",
/// "month_period":"12","total_amount":"8450.00","status":"UNPAID",
/// "member_id":"2","membership_number":"A00014",
/// "member_name":"Mr.Md.Abdus Sattar (M.A.Sattar)",
/// "member_mobile_number":"7163667,  01819-128496"}
/// ]

ReceiptListModel receiptListModelFromJson(String str) => ReceiptListModel.fromJson(json.decode(str));
String receiptListModelToJson(ReceiptListModel data) => json.encode(data.toJson());
class ReceiptListModel {
  ReceiptListModel({
      bool? status, 
      List<DataList>? data,}){
    _status = status;
    _data = data;
}

  ReceiptListModel.fromJson(dynamic json) {
    _status = json['status'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(DataList.fromJson(v));
      });
    }
  }
  bool? _status;
  List<DataList>? _data;

  bool? get status => _status;
  List<DataList>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "3820"
/// receipt_number : "193134"
/// receipt_date : "04-04-2019"
/// start_date : "2019-01-01"
/// finish_date : "2019-12-31"
/// month_period : "12"
/// total_amount : "8250.00"
/// status : "UNPAID"
/// member_id : "2"
/// membership_number : "A00014"
/// member_name : "Mr.Md.Abdus Sattar (M.A.Sattar)"
/// member_mobile_number : "7163667,  01819-128496"

DataList dataFromJson(String str) => DataList.fromJson(json.decode(str));
String dataToJson(DataList data) => json.encode(data.toJson());
class DataList {
  DataList({
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

  DataList.fromJson(dynamic json) {
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