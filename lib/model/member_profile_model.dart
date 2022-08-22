class Member_Profile {
  bool? status;
  Data? data;

  Member_Profile({this.status, this.data});

  Member_Profile.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? membershipNumber;
  String? memberName;
  String? residentialAddress;
  String? mobileNumber;
  String? gender;

  Data(
      { this.membershipNumber,
        this.memberName,
        this.residentialAddress,
        this.mobileNumber,
        this.gender
      }
      );

  Data.fromJson(Map<String, dynamic> json) {
    membershipNumber = json['membership_number'];
    memberName = json['member_name'];
    residentialAddress = json['residential_address'];
    mobileNumber = json['mobile_number'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['membership_number'] = this.membershipNumber;
    data['member_name'] = this.memberName;
    data['residential_address'] = this.residentialAddress;
    data['mobile_number'] = this.mobileNumber;
    data['gender'] = this.gender;
    return data;
  }
}
