// To parse this JSON data, do
//
//     final hrmsEmployeeAttendanceModel = hrmsEmployeeAttendanceModelFromJson(jsonString);

import 'dart:convert';

HrmsEmployeeAttendanceModel hrmsEmployeeAttendanceModelFromJson(String str) =>
    HrmsEmployeeAttendanceModel.fromJson(json.decode(str));

String hrmsEmployeeAttendanceModelToJson(HrmsEmployeeAttendanceModel data) =>
    json.encode(data.toJson());

class HrmsEmployeeAttendanceModel {
  int? id;
  DateTime? attendanceDate;
  int? employeeId;
  String? inTime;
  String? outTime;
  String? shiftDuration;
  String? lateTime;
  String? overTime;
  String? totalWorkingHour;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  Employee? employee;

  HrmsEmployeeAttendanceModel({
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
    required this.employee,
  });

  factory HrmsEmployeeAttendanceModel.fromJson(Map<String, dynamic> json) =>
      HrmsEmployeeAttendanceModel(
        id: json["id"],
        attendanceDate: DateTime.parse(json["attendance_date"]),
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
        employee: Employee.fromJson(json["employee"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "attendance_date":
            "${attendanceDate?.year.toString().padLeft(4, '0')}-${attendanceDate?.month.toString().padLeft(2, '0')}-${attendanceDate?.day.toString().padLeft(2, '0')}",
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
        "employee": employee?.toJson(),
      };
}

class Employee {
  int id;
  String employeeCode;
  String employeeName;

  Employee({
    required this.id,
    required this.employeeCode,
    required this.employeeName,
  });

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
        id: json["id"],
        employeeCode: json["employee_code"],
        employeeName: json["employee_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "employee_code": employeeCode,
        "employee_name": employeeName,
      };
}
