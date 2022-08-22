import 'dart:convert';
/// status : true
/// data : {"membership_number":"A00014","member_name":"Mr.Md.Abdus Sattar (M.A.Sattar)","residential_address":" 8/B, Diganta Apartment,\r\n 15/1-A, Hatkhola Road, Dhaka","mobile_number":"7163667,  01819-128496","gender":"Male"}

MemberProfile memberProfileFromJson(String str) => MemberProfile.fromJson(json.decode(str));
String memberProfileToJson(MemberProfile data) => json.encode(data.toJson());
class MemberProfile {
  MemberProfile({
      bool? status, 
      DataGet? data,}){
    _status = status;
    _data = data;
}

  MemberProfile.fromJson(dynamic json) {
    _status = json['status'];
    _data = json['data'] != null ? DataGet.fromJson(json['data']) : null;
  }
  bool? _status;
  DataGet? _data;

  bool? get status => _status;
  DataGet? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

/// membership_number : "A00014"
/// member_name : "Mr.Md.Abdus Sattar (M.A.Sattar)"
/// residential_address : " 8/B, Diganta Apartment,\r\n 15/1-A, Hatkhola Road, Dhaka"
/// mobile_number : "7163667,  01819-128496"
/// gender : "Male"

DataGet dataFromJson(String str) => DataGet.fromJson(json.decode(str));
String dataToJson(DataGet data) => json.encode(data.toJson());
class DataGet {
  DataGet({
      String? membershipNumber, 
      String? memberName, 
      String? residentialAddress, 
      String? mobileNumber, 
      String? gender,}){
    _membershipNumber = membershipNumber;
    _memberName = memberName;
    _residentialAddress = residentialAddress;
    _mobileNumber = mobileNumber;
    _gender = gender;
}

  DataGet.fromJson(dynamic json) {
    _membershipNumber = json['membership_number'];
    _memberName = json['member_name'];
    _residentialAddress = json['residential_address'];
    _mobileNumber = json['mobile_number'];
    _gender = json['gender'];
  }
  String? _membershipNumber;
  String? _memberName;
  String? _residentialAddress;
  String? _mobileNumber;
  String? _gender;

  String? get membershipNumber => _membershipNumber;
  String? get memberName => _memberName;
  String? get residentialAddress => _residentialAddress;
  String? get mobileNumber => _mobileNumber;
  String? get gender => _gender;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['membership_number'] = _membershipNumber;
    map['member_name'] = _memberName;
    map['residential_address'] = _residentialAddress;
    map['mobile_number'] = _mobileNumber;
    map['gender'] = _gender;
    return map;
  }

}