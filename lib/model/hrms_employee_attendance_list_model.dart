// To parse this JSON data, do
//
//     final hrmsEmployeeAttendanceModel = hrmsEmployeeAttendanceModelFromJson(jsonString);

import 'dart:convert';

import 'package:hrms_app/utils/app_methods/app_methods.dart';

HrmsEmployeeAttendanceListModel hrmsEmployeeAttendanceListModelFromJson(
        String str) =>
    HrmsEmployeeAttendanceListModel.fromJson(json.decode(str));

String hrmsEmployeeAttendanceListModelToJson(
        HrmsEmployeeAttendanceListModel data) =>
    json.encode(data.toJson());

class HrmsEmployeeAttendanceListModel {
  int draw;
  int recordsTotal;
  int recordsFiltered;
  List<AttendanceDatum> data;
  List<dynamic> input;

  HrmsEmployeeAttendanceListModel({
    required this.draw,
    required this.recordsTotal,
    required this.recordsFiltered,
    required this.data,
    required this.input,
  });

  factory HrmsEmployeeAttendanceListModel.fromJson(Map<String, dynamic> json) =>
      HrmsEmployeeAttendanceListModel(
        draw: json["draw"],
        recordsTotal: json["recordsTotal"],
        recordsFiltered: json["recordsFiltered"],
        data: List<AttendanceDatum>.from(
            json["data"].map((x) => AttendanceDatum.fromJson(x))),
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

class AttendanceDatum {
  int? id;
  DateTime? attendanceDate;
  int? employeeId;
  String? inTime;
  String? outTime;
  String? shiftDuration;
  String? lateTime;
  String? overTime;
  String? totalWorkingHour;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? employeeName;
  String? action;
  int? dtRowIndex;

  AttendanceDatum({
    required this.id,
    required this.attendanceDate,
    required this.employeeId,
    required this.inTime,
    required this.outTime,
    required this.shiftDuration,
    required this.lateTime,
    required this.overTime,
    required this.totalWorkingHour,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.employeeName,
    required this.action,
    required this.dtRowIndex,
  });

  factory AttendanceDatum.fromJson(Map<String, dynamic> json) =>
      AttendanceDatum(
        id: json["id"],
        attendanceDate:
            DateTime.tryParse(json["attendance_date"]) ?? DateTime.now(),
        employeeId: json["employee_id"],
        inTime: json["in_time"],
        outTime: json["out_time"],
        shiftDuration: json["shift_duration"],
        lateTime: json["late_time"],
        overTime: json["over_time"],
        totalWorkingHour: json["total_working_hour"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        employeeName: json["employee_name"],
        action: json["action"],
        dtRowIndex: json["DT_RowIndex"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "attendance_date": (attendanceDate == null)
            ? AppMethods().dateOfBirthFormat(DateTime.now())
            : "${attendanceDate!.year.toString().padLeft(4, '0')}-${attendanceDate!.month.toString().padLeft(2, '0')}-${attendanceDate!.day.toString().padLeft(2, '0')}",
        "employee_id": employeeId,
        "in_time": inTime,
        "out_time": outTime,
        "shift_duration": shiftDuration,
        "late_time": lateTime,
        "over_time": overTime,
        "total_working_hour": totalWorkingHour,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "employee_name": employeeName,
        "action": action,
        "DT_RowIndex": dtRowIndex,
      };
}
