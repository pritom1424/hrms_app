// To parse this JSON data, do
//
//     final hrmsEmployeeUserApiModel = hrmsEmployeeUserApiModelFromJson(jsonString);

import 'dart:convert';

HrmsEmployeeUserApiModel hrmsEmployeeUserApiModelFromJson(String str) =>
    HrmsEmployeeUserApiModel.fromJson(json.decode(str));

String hrmsEmployeeUserApiModelToJson(HrmsEmployeeUserApiModel data) =>
    json.encode(data.toJson());

class HrmsEmployeeUserApiModel {
  int id;
  String name;
  dynamic email;
  dynamic emailVerifiedAt;
  String employeeCode;
  dynamic status;
  DateTime createdAt;
  DateTime updatedAt;

  HrmsEmployeeUserApiModel({
    required this.id,
    required this.name,
    required this.email,
    required this.emailVerifiedAt,
    required this.employeeCode,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory HrmsEmployeeUserApiModel.fromJson(Map<String, dynamic> json) =>
      HrmsEmployeeUserApiModel(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        employeeCode: json["employee_code"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
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
      };
}
