// To parse this JSON data, do
//
//     final hrmsLeaveListModel = hrmsLeaveListModelFromJson(jsonString);

import 'dart:convert';

HrmsLeaveListModel hrmsLeaveListModelFromJson(String str) =>
    HrmsLeaveListModel.fromJson(json.decode(str));

String hrmsLeaveListModelToJson(HrmsLeaveListModel data) =>
    json.encode(data.toJson());

class HrmsLeaveListModel {
  int draw;
  int recordsTotal;
  int recordsFiltered;
  List<LeaveListDatum> data;
  List<dynamic> input;

  HrmsLeaveListModel({
    required this.draw,
    required this.recordsTotal,
    required this.recordsFiltered,
    required this.data,
    required this.input,
  });

  factory HrmsLeaveListModel.fromJson(Map<String, dynamic> json) =>
      HrmsLeaveListModel(
        draw: json["draw"],
        recordsTotal: json["recordsTotal"],
        recordsFiltered: json["recordsFiltered"],
        data: List<LeaveListDatum>.from(
            json["data"].map((x) => LeaveListDatum.fromJson(x))),
        input: List<dynamic>.from(json["input"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "draw": draw,
        "recordsTotal": recordsTotal,
        "recordsFiltered": recordsFiltered,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "input": List<dynamic>.from(input.map((x) => x)),
      };
}

class LeaveListDatum {
  int? id;
  int? userId;
  int? leaveTypeId;
  String? fromDate;
  String? toDate;
  String? numberOfDays;
  String? leaveReason;
  String? status;
  DateTime createdAt;
  DateTime updatedAt;
  String? leaveType;
  User? user;
  String? employeeName;
  String? action;
  int dtRowIndex;

  LeaveListDatum({
    required this.id,
    required this.userId,
    required this.leaveTypeId,
    required this.fromDate,
    required this.toDate,
    required this.numberOfDays,
    required this.leaveReason,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.leaveType,
    required this.user,
    required this.employeeName,
    required this.action,
    required this.dtRowIndex,
  });

  factory LeaveListDatum.fromJson(Map<String, dynamic> json) => LeaveListDatum(
        id: json["id"],
        userId: json["user_id"],
        leaveTypeId: json["leave_type_id"],
        fromDate: json["from_date"],
        toDate: json["to_date"],
        numberOfDays: json["number_of_days"],
        leaveReason: json["leave_reason"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        leaveType: json["leave_type"],
        user: User.fromJson(json["user"]),
        employeeName: json["employee_name"],
        action: json["action"],
        dtRowIndex: json["DT_RowIndex"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "leave_type_id": leaveTypeId,
        "from_date": fromDate,
        "to_date": toDate,
        "number_of_days": numberOfDays,
        "leave_reason": leaveReason,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "leave_type": leaveType,
        "user": user?.toJson() ?? "",
        "employee_name": employeeName,
        "action": action,
        "DT_RowIndex": dtRowIndex,
      };
}

class User {
  String? name;
  int? id;

  User({
    required this.name,
    required this.id,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["name"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
      };
}
