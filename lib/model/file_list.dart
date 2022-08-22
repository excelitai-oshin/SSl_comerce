// To parse this JSON data, do
//
//     final fileListModel = fileListModelFromJson(jsonString);

import 'dart:convert';

FileListModel fileListModelFromJson(String str) => FileListModel.fromJson(json.decode(str));

String fileListModelToJson(FileListModel data) => json.encode(data.toJson());

class FileListModel {
    FileListModel({
        this.status,
        this.data,
    });

    bool? status;
    List<Datum> ?data;

    factory FileListModel.fromJson(Map<String, dynamic> json) => FileListModel(
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    Datum({
        this.id,
        this.memberId,
        this.certificate,
        this.createdBy,
        this.createdAt,
    });

    String ?id;
    String? memberId;
    String? certificate;
    String ?createdBy;
    DateTime? createdAt;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        memberId: json["member_id"],
        certificate: json["certificate"],
        createdBy: json["created_by"],
        createdAt: DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "member_id": memberId,
        "certificate": certificate,
        "created_by": createdBy,
        "created_at": createdAt!.toIso8601String(),
    };
}
