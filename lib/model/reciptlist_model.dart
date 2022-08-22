class ReciptlistModel {
  bool? status;
  List<Data>? data;

  ReciptlistModel({this.status, this.data});

  ReciptlistModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
  String? receiptNumber;
  String? receiptDate;
  String? startDate;
  String? finishDate;
  String? monthPeriod;
  String? totalAmount;
  String? status;
  String? memberId;
  String? membershipNumber;
  String? memberName;
  String? memberMobileNumber;

  Data(
      {this.id,
        this.receiptNumber,
        this.receiptDate,
        this.startDate,
        this.finishDate,
        this.monthPeriod,
        this.totalAmount,
        this.status,
        this.memberId,
        this.membershipNumber,
        this.memberName,
        this.memberMobileNumber});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    receiptNumber = json['receipt_number'];
    receiptDate = json['receipt_date'];
    startDate = json['start_date'];
    finishDate = json['finish_date'];
    monthPeriod = json['month_period'];
    totalAmount = json['total_amount'];
    status = json['status'];
    memberId = json['member_id'];
    membershipNumber = json['membership_number'];
    memberName = json['member_name'];
    memberMobileNumber = json['member_mobile_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['receipt_number'] = this.receiptNumber;
    data['receipt_date'] = this.receiptDate;
    data['start_date'] = this.startDate;
    data['finish_date'] = this.finishDate;
    data['month_period'] = this.monthPeriod;
    data['total_amount'] = this.totalAmount;
    data['status'] = this.status;
    data['member_id'] = this.memberId;
    data['membership_number'] = this.membershipNumber;
    data['member_name'] = this.memberName;
    data['member_mobile_number'] = this.memberMobileNumber;
    return data;
  }
}
