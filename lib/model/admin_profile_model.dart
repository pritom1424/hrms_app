// To parse this JSON data, do
//
//     final hrmsAdminProfileModel = hrmsAdminProfileModelFromJson(jsonString);

import 'dart:convert';

HrmsAdminProfileModel hrmsAdminProfileModelFromJson(String str) =>
    HrmsAdminProfileModel.fromJson(json.decode(str));

String hrmsAdminProfileModelToJson(HrmsAdminProfileModel data) =>
    json.encode(data.toJson());

class HrmsAdminProfileModel {
  int id;
  String? name;
  String? email;
  dynamic emailVerifiedAt;
  dynamic employeeCode;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  HrmsAdminProfileModel({
    required this.id,
    required this.name,
    required this.email,
    required this.emailVerifiedAt,
    required this.employeeCode,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory HrmsAdminProfileModel.fromJson(Map<String, dynamic> json) =>
      HrmsAdminProfileModel(
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
        "created_at":
            createdAt?.toIso8601String() ?? DateTime.now().toIso8601String(),
        "updated_at":
            updatedAt?.toIso8601String() ?? DateTime.now().toIso8601String(),
      };
}
