// To parse this JSON data, do
//
//     final hrmsShiftModel = hrmsShiftModelFromJson(jsonString);

import 'dart:convert';

HrmsShiftModel hrmsShiftModelFromJson(String str) =>
    HrmsShiftModel.fromJson(json.decode(str));

String hrmsShiftModelToJson(HrmsShiftModel data) => json.encode(data.toJson());

class HrmsShiftModel {
  int? id;
  int? shiftId;
  String? shiftStartTime;
  String? shiftEndTime;
  dynamic defaultShift;
  String? gracePeriod;
  String? breakStartTime;
  String? breakEndTime;
  String? totalWorkingHour;
  int? userId;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;
  Shift shift;

  HrmsShiftModel({
    required this.id,
    required this.shiftId,
    required this.shiftStartTime,
    required this.shiftEndTime,
    required this.defaultShift,
    required this.gracePeriod,
    required this.breakStartTime,
    required this.breakEndTime,
    required this.totalWorkingHour,
    required this.userId,
    required this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.shift,
  });

  factory HrmsShiftModel.fromJson(Map<String, dynamic> json) => HrmsShiftModel(
        id: json["id"],
        shiftId: json["shift_id"],
        shiftStartTime: json["shift_start_time"],
        shiftEndTime: json["shift_end_time"],
        defaultShift: json["default_shift"],
        gracePeriod: json["grace_period"],
        breakStartTime: json["break_start_time"],
        breakEndTime: json["break_end_time"],
        totalWorkingHour: json["total_working_hour"],
        userId: json["user_id"],
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        shift: Shift.fromJson(json["shift"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "shift_id": shiftId,
        "shift_start_time": shiftStartTime,
        "shift_end_time": shiftEndTime,
        "default_shift": defaultShift,
        "grace_period": gracePeriod,
        "break_start_time": breakStartTime,
        "break_end_time": breakEndTime,
        "total_working_hour": totalWorkingHour,
        "user_id": userId,
        "deleted_at": deletedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "shift": shift.toJson(),
      };
}

class Shift {
  int? id;
  String? shiftName;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;

  Shift({
    required this.id,
    required this.shiftName,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  factory Shift.fromJson(Map<String, dynamic> json) => Shift(
        id: json["id"],
        shiftName: json["shift_name"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "shift_name": shiftName,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
      };
}
