import 'dart:convert';
import 'dart:io';

HrmsAttendancePostModel hrmsAttendancePostModelFromJson(String str) =>
    HrmsAttendancePostModel.fromJson(json.decode(str));

String hrmsAttendancePostModelToJson(HrmsAttendancePostModel data) =>
    json.encode(data.toJson());

class HrmsAttendancePostModel {
  String? attendanceDate;
  int? employeeId;

  String? employeeInTime;
  String? employeeOutTime;
  String? employeeShiftDuration;
  String? employeeLateTime;
  String? employeeOverTime;
  String? employeeTotalWorkingHour;
  String? employeeStatus;

  HrmsAttendancePostModel({
    required this.attendanceDate,
    required this.employeeId,
    required this.employeeInTime,
    required this.employeeOutTime,
    required this.employeeShiftDuration,
    required this.employeeLateTime,
    required this.employeeOverTime,
    required this.employeeTotalWorkingHour,
    required this.employeeStatus,
  });
  factory HrmsAttendancePostModel.fromJson(Map<String, dynamic> json) =>
      HrmsAttendancePostModel(
        attendanceDate: json["attendance_date"],
        employeeId: json["employee_id"],
        employeeInTime: json["in_time"],
        employeeOutTime: json["out_time"],
        employeeShiftDuration: json["shift_duration"],
        employeeLateTime: json["late_time"],
        employeeOverTime: json["over_time"],
        employeeTotalWorkingHour: json["total_working_hour"],
        employeeStatus: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "attendance_date": attendanceDate,
        "employee_id": employeeId,
        "in_time": employeeInTime,
        "out_time": employeeOutTime,
        "shift_duration": employeeShiftDuration,
        "late_time": employeeLateTime,
        "over_time": employeeOverTime,
        "total_working_hour": employeeTotalWorkingHour,
        "status": employeeStatus,
      };
}

/*
punch_id
employee_name
employee_father
employee_mother
gender
date_of_birth
nationality
id_type
id_number
permanent_address
present_address
user_id
image
email_address
password
shift_date
shift_id
joining_date
confirmation_date
designation
department_id

9
key list
---------------
attendance_date
employee_id
in_time
out_time
shift_duration
late_time
over_time
total_working_hour
status





 */