// To parse this JSON data, do
//
//     final hrmsNationalityListModel = hrmsNationalityListModelFromJson(jsonString);

import 'dart:convert';

HrmsNationalityListModel hrmsNationalityListModelFromJson(String str) =>
    HrmsNationalityListModel.fromJson(json.decode(str));

String hrmsNationalityListModelToJson(HrmsNationalityListModel data) =>
    json.encode(data.toJson());

class HrmsNationalityListModel {
  int? draw;
  int? recordsTotal;
  int? recordsFiltered;
  List<Datum> data;
  List<dynamic> input;

  HrmsNationalityListModel({
    required this.draw,
    required this.recordsTotal,
    required this.recordsFiltered,
    required this.data,
    required this.input,
  });

  factory HrmsNationalityListModel.fromJson(Map<String, dynamic> json) =>
      HrmsNationalityListModel(
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
  int? id;
  String? countryName;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  String? action;
  int? dtRowIndex;

  Datum({
    required this.id,
    required this.countryName,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.action,
    required this.dtRowIndex,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        countryName: json["country_name"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        action: json["action"],
        dtRowIndex: json["DT_RowIndex"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "country_name": countryName,
        "created_at":
            createdAt?.toIso8601String() ?? DateTime.now().toIso8601String(),
        "updated_at":
            updatedAt?.toIso8601String() ?? DateTime.now().toIso8601String(),
        "deleted_at": deletedAt,
        "action": action,
        "DT_RowIndex": dtRowIndex,
      };
}
