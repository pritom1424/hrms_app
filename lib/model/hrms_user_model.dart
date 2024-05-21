// To parse this JSON data, do
//
//     final hrmsEmployeeUserModel = hrmsEmployeeUserModelFromJson(jsonString);

import 'dart:convert';

HrmsEmployeeUserModel hrmsEmployeeUserModelFromJson(String str) =>
    HrmsEmployeeUserModel.fromJson(json.decode(str));

String hrmsEmployeeUserModelToJson(HrmsEmployeeUserModel data) =>
    json.encode(data.toJson());

class HrmsEmployeeUserModel {
  int? draw;
  int? recordsTotal;
  int? recordsFiltered;
  List<UserDatum> data;
  List<dynamic> input;

  HrmsEmployeeUserModel({
    required this.draw,
    required this.recordsTotal,
    required this.recordsFiltered,
    required this.data,
    required this.input,
  });

  factory HrmsEmployeeUserModel.fromJson(Map<String, dynamic> json) =>
      HrmsEmployeeUserModel(
        draw: json["draw"],
        recordsTotal: json["recordsTotal"],
        recordsFiltered: json["recordsFiltered"],
        data: List<UserDatum>.from(
            json["data"].map((x) => UserDatum.fromJson(x))),
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

class UserDatum {
  int id;
  String? name;
  String? email;
  dynamic emailVerifiedAt;
  String? employeeCode;
  int? status;
  DateTime createdAt;
  DateTime updatedAt;
  String? action;
  int dtRowIndex;

  UserDatum({
    required this.id,
    required this.name,
    required this.email,
    required this.emailVerifiedAt,
    required this.employeeCode,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.action,
    required this.dtRowIndex,
  });

  factory UserDatum.fromJson(Map<String, dynamic> json) => UserDatum(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        employeeCode: json["employee_code"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        action: json["action"],
        dtRowIndex: json["DT_RowIndex"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "employee_code": employeeCode,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "action": action,
        "DT_RowIndex": dtRowIndex,
      };
}
