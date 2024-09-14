// To parse this JSON data, do
//
//     final hrmsLeaveTypeModel = hrmsLeaveTypeModelFromJson(jsonString);

import 'dart:convert';

HrmsLeaveTypeModel hrmsLeaveTypeModelFromJson(String str) =>
    HrmsLeaveTypeModel.fromJson(json.decode(str));

String hrmsLeaveTypeModelToJson(HrmsLeaveTypeModel data) =>
    json.encode(data.toJson());

class HrmsLeaveTypeModel {
  int draw;
  int recordsTotal;
  int recordsFiltered;
  List<Datum> data;
  List<dynamic> input;

  HrmsLeaveTypeModel({
    required this.draw,
    required this.recordsTotal,
    required this.recordsFiltered,
    required this.data,
    required this.input,
  });

  factory HrmsLeaveTypeModel.fromJson(Map<String, dynamic> json) =>
      HrmsLeaveTypeModel(
        draw: json["draw"],
        recordsTotal: json["recordsTotal"],
        recordsFiltered: json["recordsFiltered"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
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

class Datum {
  int id;
  String leaveType;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;
  String action;
  int dtRowIndex;

  Datum({
    required this.id,
    required this.leaveType,
    required this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.action,
    required this.dtRowIndex,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        leaveType: json["leave_type"],
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        action: json["action"],
        dtRowIndex: json["DT_RowIndex"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "leave_type": leaveType,
        "deleted_at": deletedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "action": action,
        "DT_RowIndex": dtRowIndex,
      };
}
