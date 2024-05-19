// To parse this JSON data, do
//
//     final hrmsEmployeeModel = hrmsEmployeeModelFromJson(jsonString);

import 'dart:convert';

HrmsEmployeeModel hrmsEmployeeModelFromJson(String str) =>
    HrmsEmployeeModel.fromJson(json.decode(str));

String hrmsEmployeeModelToJson(HrmsEmployeeModel data) =>
    json.encode(data.toJson());

class HrmsEmployeeModel {
  int? draw;
  int? recordsTotal;
  int? recordsFiltered;
  List<EmployeeDatum> data;
  List<dynamic> input;

  HrmsEmployeeModel({
    required this.draw,
    required this.recordsTotal,
    required this.recordsFiltered,
    required this.data,
    required this.input,
  });

  factory HrmsEmployeeModel.fromJson(Map<String, dynamic> json) =>
      HrmsEmployeeModel(
        draw: json["draw"],
        recordsTotal: json["recordsTotal"],
        recordsFiltered: json["recordsFiltered"],
        data: List<EmployeeDatum>.from(
            json["data"].map((x) => EmployeeDatum.fromJson(x))),
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

class EmployeeDatum {
  int? id;
  String? employeeCode;
  String? punchId;
  String? employeeName;
  String? employeeFather;
  String? employeeMother;
  String? gender;
  String? dateOfBirth;
  String? nationality;
  String? idType;
  String? idNumber;
  String? permanentAddress;
  String? presentAddress;
  String? image;
  int? userId;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  String? action;
  int? dtRowIndex;

  EmployeeDatum({
    required this.id,
    required this.employeeCode,
    required this.punchId,
    required this.employeeName,
    required this.employeeFather,
    required this.employeeMother,
    required this.gender,
    required this.dateOfBirth,
    required this.nationality,
    required this.idType,
    required this.idNumber,
    required this.permanentAddress,
    required this.presentAddress,
    required this.image,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.action,
    required this.dtRowIndex,
  });

  factory EmployeeDatum.fromJson(Map<String, dynamic> json) => EmployeeDatum(
        id: json["id"],
        employeeCode: json["employee_code"],
        punchId: json["punch_id"],
        employeeName: json["employee_name"],
        employeeFather: json["employee_father"],
        employeeMother: json["employee_mother"],
        gender: json["gender"],
        dateOfBirth: json["date_of_birth"],
        nationality: json["nationality"],
        idType: json["id_type"],
        idNumber: json["id_number"],
        permanentAddress: json["permanent_address"],
        presentAddress: json["present_address"],
        image: json["image"],
        userId: json["user_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        action: json["action"],
        dtRowIndex: json["DT_RowIndex"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "employee_code": employeeCode,
        "punch_id": punchId,
        "employee_name": employeeName,
        "employee_father": employeeFather,
        "employee_mother": employeeMother,
        "gender": gender,
        "date_of_birth": dateOfBirth,
        "nationality": nationality,
        "id_type": idType,
        "id_number": idNumber,
        "permanent_address": permanentAddress,
        "present_address": presentAddress,
        "image": image,
        "user_id": userId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
        "action": action,
        "DT_RowIndex": dtRowIndex,
      };
}
