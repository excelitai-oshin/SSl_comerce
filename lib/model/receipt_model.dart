import 'dart:convert';
/// status : false
/// data : null
/// message : "Could not find any receipt "

ReceiptModel receiptModelFromJson(String str) => ReceiptModel.fromJson(json.decode(str));
String receiptModelToJson(ReceiptModel data) => json.encode(data.toJson());
class ReceiptModel {
  ReceiptModel({
      bool? status, 
      dynamic data, 
      String? message,}){
    _status = status;
    _data = data;
    _message = message;
}

  ReceiptModel.fromJson(dynamic json) {
    _status = json['status'];
    _data = json['data'];
    _message = json['message'];
  }
  bool? _status;
  dynamic _data;
  String? _message;

  bool? get status => _status;
  dynamic get data => _data;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['data'] = _data;
    map['message'] = _message;
    return map;
  }

}