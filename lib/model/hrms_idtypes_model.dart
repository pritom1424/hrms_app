// To parse this JSON data, do
//
//     final hrmsIdtypeListModel = hrmsIdtypeListModelFromJson(jsonString);

import 'dart:convert';

HrmsIdtypeListModel hrmsIdtypeListModelFromJson(String str) =>
    HrmsIdtypeListModel.fromJson(json.decode(str));

String hrmsIdtypeListModelToJson(HrmsIdtypeListModel data) =>
    json.encode(data.toJson());

class HrmsIdtypeListModel {
  int draw;
  int recordsTotal;
  int recordsFiltered;
  List<Datum> data;
  List<dynamic> input;

  HrmsIdtypeListModel({
    required this.draw,
    required this.recordsTotal,
    required this.recordsFiltered,
    required this.data,
    required this.input,
  });

  factory HrmsIdtypeListModel.fromJson(Map<String, dynamic> json) =>
      HrmsIdtypeListModel(
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
  String idType;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  String action;
  int dtRowIndex;

  Datum({
    required this.id,
    required this.idType,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.action,
    required this.dtRowIndex,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        idType: json["id_type"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        action: json["action"],
        dtRowIndex: json["DT_RowIndex"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_type": idType,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
        "action": action,
        "DT_RowIndex": dtRowIndex,
      };
}
