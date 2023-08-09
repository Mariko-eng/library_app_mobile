
// To parse this JSON data, do
//
//     final attendanceReportModel = attendanceReportModelFromJson(jsonString);

import 'dart:convert';

AttendanceReportModel attendanceReportModelFromJson(String str) => AttendanceReportModel.fromJson(json.decode(str));

String attendanceReportModelToJson(AttendanceReportModel data) => json.encode(data.toJson());

class AttendanceReportModel {
  int count;
  dynamic next;
  dynamic previous;
  List<Result> results;

  AttendanceReportModel({
    required this.count,
    this.next,
    this.previous,
    required this.results,
  });

  factory AttendanceReportModel.fromJson(Map<String, dynamic> json) => AttendanceReportModel(
    count: json["count"],
    next: json["next"],
    previous: json["previous"],
    results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "next": next,
    "previous": previous,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
  };
}

class Result {
  int id;
  Device device;
  String attendanceType;
  String activity;
  DateTime updatedAt;
  DateTime createdAt;
  int user;

  Result({
    required this.id,
    required this.device,
    required this.attendanceType,
    required this.activity,
    required this.updatedAt,
    required this.createdAt,
    required this.user,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    device: Device.fromJson(json["device"]),
    attendanceType: json["attendance_type"],
    activity: json["activity"],
    updatedAt: DateTime.parse(json["updated_at"]),
    createdAt: DateTime.parse(json["created_at"]),
    user: json["user"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "device": device.toJson(),
    "attendance_type": attendanceType,
    "activity": activity,
    "updated_at": updatedAt.toIso8601String(),
    "created_at": createdAt.toIso8601String(),
    "user": user,
  };
}

class Device {
  int id;
  String name;
  String address;

  Device({
    required this.id,
    required this.name,
    required this.address,
  });

  factory Device.fromJson(Map<String, dynamic> json) => Device(
    id: json["id"],
    name: json["name"],
    address: json["address"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "address": address,
  };
}
