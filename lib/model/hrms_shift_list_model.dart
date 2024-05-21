// To parse this JSON data, do
//
//     final hrmsShiftListModel = hrmsShiftListModelFromJson(jsonString);

import 'dart:convert';

HrmsShiftListModel hrmsShiftListModelFromJson(String str) =>
    HrmsShiftListModel.fromJson(json.decode(str));

String hrmsShiftListModelToJson(HrmsShiftListModel data) =>
    json.encode(data.toJson());

class HrmsShiftListModel {
  int? recordsTotal;
  int? recordsFiltered;
  List<Datum> data;
  List<dynamic> input;

  HrmsShiftListModel({
    required this.recordsTotal,
    required this.recordsFiltered,
    required this.data,
    required this.input,
  });

  factory HrmsShiftListModel.fromJson(Map<String, dynamic> json) =>
      HrmsShiftListModel(
        recordsTotal: json["recordsTotal"],
        recordsFiltered: json["recordsFiltered"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        input: List<dynamic>.from(json["input"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "recordsTotal": recordsTotal,
        "recordsFiltered": recordsFiltered,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "input": List<dynamic>.from(input.map((x) => x)),
      };
}

class Datum {
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
  String? shiftName;

  Datum({
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
    required this.shiftName,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
        shiftName: json["shift_name"],
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
        "shift_name": shiftName,
      };
}

class Shift {
  int id;
  String shiftName;
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
