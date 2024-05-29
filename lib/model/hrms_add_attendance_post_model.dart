import 'dart:convert';
import 'dart:io';

HrmsAddAttendancePostModel hrmsAddAttendancePostModelFromJson(String str) =>
    HrmsAddAttendancePostModel.fromJson(json.decode(str));

String hrmsAddAttendancePostModelToJson(HrmsAddAttendancePostModel data) =>
    json.encode(data.toJson());

class HrmsAddAttendancePostModel {
  String attendanceDate;
  List<int?> employeeId;

  List<String?> employeeInTime;
  List<String?> employeeOutTime;
  List<String?> employeeShiftDuration;
  List<String?> employeeLateTime;
  List<String?> employeeOverTime;
  List<String?> employeeTotalWorkingHour;
  List<int?> employeeStatus;

  HrmsAddAttendancePostModel({
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
  factory HrmsAddAttendancePostModel.fromJson(Map<String, dynamic> json) =>
      HrmsAddAttendancePostModel(
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
