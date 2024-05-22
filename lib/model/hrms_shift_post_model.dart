import 'dart:convert';
import 'dart:io';

HrmsShiftPostModel hrmsShiftPostModelFromJson(String str) =>
    HrmsShiftPostModel.fromJson(json.decode(str));

String hrmsShiftPostModelToJson(HrmsShiftPostModel data) =>
    json.encode(data.toJson());

class HrmsShiftPostModel {
  int? shiftId;
  String? shiftStartTime;
  String? shiftEndTime;
  dynamic defaultShift;
  String? gracePeriod;
  String? breakStartTime;
  String? breakEndTime;
  String? totalWorkingHour;
  int? userID;

  HrmsShiftPostModel({
    required this.shiftId,
    required this.shiftStartTime,
    required this.shiftEndTime,
    required this.defaultShift,
    required this.gracePeriod,
    required this.breakStartTime,
    required this.breakEndTime,
    required this.totalWorkingHour,
    required this.userID,
  });
  factory HrmsShiftPostModel.fromJson(Map<String, dynamic> json) =>
      HrmsShiftPostModel(
        shiftId: json["shift_id"],
        shiftStartTime: json["shift_start_time"],
        shiftEndTime: json["shift_end_time"],
        defaultShift: json["default_shift"],
        gracePeriod: json["grace_period"],
        breakStartTime: json["break_start_time"],
        breakEndTime: json["break_end_time"],
        totalWorkingHour: json["total_working_hour"],
        userID: json["user_id"],
      );

  Map<String, dynamic> toJson() => {
        "shift_id": shiftId,
        "shift_start_time": shiftStartTime,
        "shift_end_time": shiftEndTime,
        "default_shift": defaultShift,
        "grace_period": gracePeriod,
        "break_start_time": breakStartTime,
        "break_end_time": breakEndTime,
        "total_working_hour": totalWorkingHour,
        "user_id": userID,
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






 */