import 'dart:convert';
/// user : {"id":390,"name":"","Member_id":"1234","agent_id":null,"customer_id":null,"email":"gunjon@gmail.com","address":null,"provider_id":null,"avatar":null,"phone":"01766609988","date_of_birth":null,"gender":null,"mobile":null,"otp":null,"last_seen":null,"email_verified_at":null,"current_team_id":null,"profile_photo_path":null,"created_at":"2022-08-02T08:28:56.000000Z","updated_at":"2022-08-02T08:28:56.000000Z","profile_photo_url":"https://ui-avatars.com/api/?name=&color=7F9CF5&background=EBF4FF"}
/// token : "300|m9forUzytdpfeDt1PEUP9HS7xF8gHZh6KJLcHBYI"

LogedInSessionModel logedInSessionModelFromJson(String str) => LogedInSessionModel.fromJson(json.decode(str));
String logedInSessionModelToJson(LogedInSessionModel data) => json.encode(data.toJson());
class LogedInSessionModel {
  LogedInSessionModel({
      User? user, 
      String? token,}){
    _user = user;
    _token = token;
}

  LogedInSessionModel.fromJson(dynamic json) {
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
    _token = json['token'];
  }
  User? _user;
  String? _token;

  User? get user => _user;
  String? get token => _token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    map['token'] = _token;
    return map;
  }

}

/// id : 390
/// name : ""
/// Member_id : "1234"
/// agent_id : null
/// customer_id : null
/// email : "gunjon@gmail.com"
/// address : null
/// provider_id : null
/// avatar : null
/// phone : "01766609988"
/// date_of_birth : null
/// gender : null
/// mobile : null
/// otp : null
/// last_seen : null
/// email_verified_at : null
/// current_team_id : null
/// profile_photo_path : null
/// created_at : "2022-08-02T08:28:56.000000Z"
/// updated_at : "2022-08-02T08:28:56.000000Z"
/// profile_photo_url : "https://ui-avatars.com/api/?name=&color=7F9CF5&background=EBF4FF"

User userFromJson(String str) => User.fromJson(json.decode(str));
String userToJson(User data) => json.encode(data.toJson());
class User {
  User({
      int? id, 
      String? name, 
      String? memberId, 
      dynamic agentId, 
      dynamic customerId, 
      String? email, 
      dynamic address, 
      dynamic providerId, 
      dynamic avatar, 
      String? phone, 
      dynamic dateOfBirth, 
      dynamic gender, 
      dynamic mobile, 
      dynamic otp, 
      dynamic lastSeen, 
      dynamic emailVerifiedAt, 
      dynamic currentTeamId, 
      dynamic profilePhotoPath, 
      String? createdAt, 
      String? updatedAt, 
      String? profilePhotoUrl,}){
    _id = id;
    _name = name;
    _memberId = memberId;
    _agentId = agentId;
    _customerId = customerId;
    _email = email;
    _address = address;
    _providerId = providerId;
    _avatar = avatar;
    _phone = phone;
    _dateOfBirth = dateOfBirth;
    _gender = gender;
    _mobile = mobile;
    _otp = otp;
    _lastSeen = lastSeen;
    _emailVerifiedAt = emailVerifiedAt;
    _currentTeamId = currentTeamId;
    _profilePhotoPath = profilePhotoPath;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _profilePhotoUrl = profilePhotoUrl;
}

  User.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _memberId = json['Member_id'];
    _agentId = json['agent_id'];
    _customerId = json['customer_id'];
    _email = json['email'];
    _address = json['address'];
    _providerId = json['provider_id'];
    _avatar = json['avatar'];
    _phone = json['phone'];
    _dateOfBirth = json['date_of_birth'];
    _gender = json['gender'];
    _mobile = json['mobile'];
    _otp = json['otp'];
    _lastSeen = json['last_seen'];
    _emailVerifiedAt = json['email_verified_at'];
    _currentTeamId = json['current_team_id'];
    _profilePhotoPath = json['profile_photo_path'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _profilePhotoUrl = json['profile_photo_url'];
  }
  int? _id;
  String? _name;
  String? _memberId;
  dynamic _agentId;
  dynamic _customerId;
  String? _email;
  dynamic _address;
  dynamic _providerId;
  dynamic _avatar;
  String? _phone;
  dynamic _dateOfBirth;
  dynamic _gender;
  dynamic _mobile;
  dynamic _otp;
  dynamic _lastSeen;
  dynamic _emailVerifiedAt;
  dynamic _currentTeamId;
  dynamic _profilePhotoPath;
  String? _createdAt;
  String? _updatedAt;
  String? _profilePhotoUrl;

  int? get id => _id;
  String? get name => _name;
  String? get memberId => _memberId;
  dynamic get agentId => _agentId;
  dynamic get customerId => _customerId;
  String? get email => _email;
  dynamic get address => _address;
  dynamic get providerId => _providerId;
  dynamic get avatar => _avatar;
  String? get phone => _phone;
  dynamic get dateOfBirth => _dateOfBirth;
  dynamic get gender => _gender;
  dynamic get mobile => _mobile;
  dynamic get otp => _otp;
  dynamic get lastSeen => _lastSeen;
  dynamic get emailVerifiedAt => _emailVerifiedAt;
  dynamic get currentTeamId => _currentTeamId;
  dynamic get profilePhotoPath => _profilePhotoPath;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get profilePhotoUrl => _profilePhotoUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['Member_id'] = _memberId;
    map['agent_id'] = _agentId;
    map['customer_id'] = _customerId;
    map['email'] = _email;
    map['address'] = _address;
    map['provider_id'] = _providerId;
    map['avatar'] = _avatar;
    map['phone'] = _phone;
    map['date_of_birth'] = _dateOfBirth;
    map['gender'] = _gender;
    map['mobile'] = _mobile;
    map['otp'] = _otp;
    map['last_seen'] = _lastSeen;
    map['email_verified_at'] = _emailVerifiedAt;
    map['current_team_id'] = _currentTeamId;
    map['profile_photo_path'] = _profilePhotoPath;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['profile_photo_url'] = _profilePhotoUrl;
    return map;
  }

}