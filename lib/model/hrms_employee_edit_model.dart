// To parse this JSON data, do
//
//     final hrmsEmployeeEditModel = hrmsEmployeeEditModelFromJson(jsonString);

import 'dart:convert';

HrmsEmployeeEditModel hrmsEmployeeEditModelFromJson(String str) =>
    HrmsEmployeeEditModel.fromJson(json.decode(str));

String hrmsEmployeeEditModelToJson(HrmsEmployeeEditModel data) =>
    json.encode(data.toJson());

class HrmsEmployeeEditModel {
  int? id;
  String? employeeCode;
  String? punchId;
  String? employeeName;
  String? employeeFather;
  String? employeeMother;
  String? employeePhoneNumber;
  String? gender;
  String? dateOfBirth;
  String? nationality;
  String? idType;
  String? idNumber;
  String? permanentAddress;
  String? presentAddress;
  dynamic image;
  dynamic userId;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  OfficeInformation? officeInformation;
  List<dynamic> education;
  List<dynamic> experience;

  HrmsEmployeeEditModel({
    required this.id,
    required this.employeeCode,
    required this.punchId,
    required this.employeeName,
    required this.employeeFather,
    required this.employeeMother,
    required this.employeePhoneNumber,
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
    required this.officeInformation,
    required this.education,
    required this.experience,
  });

  factory HrmsEmployeeEditModel.fromJson(Map<String, dynamic> json) {
    print("office info: ${json["office_information"]}");
    print("office info new${OfficeInformation.fromJson({
          "id": null,
          "employee_id": null,
          "shift_date": null,
          "shift_id": null,
          "joining_date": null,
          "confirmation_date": null,
          "designation": null,
          "department_id": null,
          "created_at": DateTime.now().toIso8601String(),
          "updated_at": DateTime.now().toIso8601String(),
          "deleted_at": null
        })}");
    return HrmsEmployeeEditModel(
      id: json["id"],
      employeeCode: json["employee_code"],
      punchId: json["punch_id"],
      employeeName: json["employee_name"],
      employeeFather: json["employee_father"],
      employeeMother: json["employee_mother"],
      employeePhoneNumber: json["phone_number"],
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
      officeInformation:
          OfficeInformation?.fromJson((json["office_information"] == null)
              ? {
                  "id": null,
                  "employee_id": null,
                  "shift_date": null,
                  "shift_id": null,
                  "joining_date": null,
                  "confirmation_date": null,
                  "designation": null,
                  "department_id": null,
                  "created_at": DateTime.now().toIso8601String(),
                  "updated_at": DateTime.now().toIso8601String(),
                  "deleted_at": null
                }
              : json["office_information"]),
      education: List<dynamic>.from(json["education"].map((x) => x)),
      experience: List<dynamic>.from(json["experience"].map((x) => x)),
    );
  }
  Map<String, dynamic> toJson() => {
        "id": id,
        "employee_code": employeeCode,
        "punch_id": punchId,
        "employee_name": employeeName,
        "employee_father": employeeFather,
        "employee_mother": employeeMother,
        "phone_number": employeePhoneNumber,
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
        "office_information": officeInformation?.toJson(),
        "education": List<dynamic>.from(education.map((x) => x)),
        "experience": List<dynamic>.from(experience.map((x) => x)),
      };
}

class OfficeInformation {
  int? id;
  String? employeeId;
  dynamic shiftDate;
  dynamic shiftId;
  dynamic joiningDate;
  dynamic confirmationDate;
  dynamic designation;
  dynamic departmentId;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  OfficeInformation({
    required this.id,
    required this.employeeId,
    required this.shiftDate,
    required this.shiftId,
    required this.joiningDate,
    required this.confirmationDate,
    required this.designation,
    required this.departmentId,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  factory OfficeInformation.fromJson(Map<String, dynamic> json) =>
      OfficeInformation(
        id: json["id"],
        employeeId: json["employee_id"],
        shiftDate: json["shift_date"],
        shiftId: json["shift_id"],
        joiningDate: json["joining_date"],
        confirmationDate: json["confirmation_date"],
        designation: json["designation"],
        departmentId: json["department_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "employee_id": employeeId,
        "shift_date": shiftDate,
        "shift_id": shiftId,
        "joining_date": joiningDate,
        "confirmation_date": confirmationDate,
        "designation": designation,
        "department_id": departmentId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
      };
}











/* // To parse this JSON data, do
//
//     final hrmsEmployeeEditModel = hrmsEmployeeEditModelFromJson(jsonString);

import 'dart:convert';

HrmsEmployeeEditModel hrmsEmployeeEditModelFromJson(String str) =>
    HrmsEmployeeEditModel.fromJson(json.decode(str));

String hrmsEmployeeEditModelToJson(HrmsEmployeeEditModel data) =>
    json.encode(data.toJson());

class HrmsEmployeeEditModel {
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
  dynamic image;
  dynamic userId;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  OfficeInformation? officeInformation;
  List<dynamic> education;
  List<dynamic> experience;

  HrmsEmployeeEditModel({
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
    required this.officeInformation,
    required this.education,
    required this.experience,
  });

  factory HrmsEmployeeEditModel.fromJson(Map<String, dynamic> json) =>
      HrmsEmployeeEditModel(
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
        officeInformation:
            OfficeInformation.fromJson(json["office_information"]),
        education: List<dynamic>.from(json["education"].map((x) => x)),
        experience: List<dynamic>.from(json["experience"].map((x) => x)),
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
        "office_information": officeInformation?.toJson(),
        "education": List<dynamic>.from(education.map((x) => x)),
        "experience": List<dynamic>.from(experience.map((x) => x)),
      };
}

class OfficeInformation {
  int id;
  String employeeId;
  dynamic shiftDate;
  dynamic shiftId;
  dynamic joiningDate;
  dynamic confirmationDate;
  dynamic designation;
  dynamic departmentId;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;

  OfficeInformation({
    required this.id,
    required this.employeeId,
    required this.shiftDate,
    required this.shiftId,
    required this.joiningDate,
    required this.confirmationDate,
    required this.designation,
    required this.departmentId,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  factory OfficeInformation.fromJson(Map<String, dynamic> json) =>
      OfficeInformation(
        id: json["id"],
        employeeId: json["employee_id"],
        shiftDate: json["shift_date"],
        shiftId: json["shift_id"],
        joiningDate: json["joining_date"],
        confirmationDate: json["confirmation_date"],
        designation: json["designation"],
        departmentId: json["department_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "employee_id": employeeId,
        "shift_date": shiftDate,
        "shift_id": shiftId,
        "joining_date": joiningDate,
        "confirmation_date": confirmationDate,
        "designation": designation,
        "department_id": departmentId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
      };
}


 */











/* // To parse this JSON data, do
//
//     final hrmsEmployeeEditModel = hrmsEmployeeEditModelFromJson(jsonString);

import 'dart:convert';

HrmsEmployeeEditModel hrmsEmployeeEditModelFromJson(String str) =>
    HrmsEmployeeEditModel.fromJson(json.decode(str));

String hrmsEmployeeEditModelToJson(HrmsEmployeeEditModel data) =>
    json.encode(data.toJson());

class HrmsEmployeeEditModel {
  int? id;
  String? employeeCode;
  String? punchId;
  String? employeeName;
  String? employeeFather;
  String? employeeMother;
  String? gender;
  DateTime? dateOfBirth;
  String? nationality;
  String? idType;
  String? idNumber;
  String? permanentAddress;
  String? presentAddress;
  dynamic image;
  int? userId;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  OfficeInformation? officeInformation;
  List<dynamic> education;
  List<dynamic> experience;

  HrmsEmployeeEditModel({
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
    required this.officeInformation,
    required this.education,
    required this.experience,
  });

  factory HrmsEmployeeEditModel.fromJson(Map<String, dynamic> json) =>
      HrmsEmployeeEditModel(
        id: json["id"] ?? '',
        employeeCode: json["employee_code"] ?? "",
        punchId: json["punch_id"] ?? "",
        employeeName: json["employee_name"] ?? "",
        employeeFather: json["employee_father"] ?? "",
        employeeMother: json["employee_mother"] ?? "",
        gender: json["gender"] ?? "",
        dateOfBirth: DateTime.parse(json["date_of_birth"]),
        nationality: json["nationality"] ?? "",
        idType: json["id_type"] ?? "",
        idNumber: json["id_number"] ?? "",
        permanentAddress: json["permanent_address"] ?? "",
        presentAddress: json["present_address"] ?? "",
        image: json["image"] ?? "",
        userId: json["user_id"] ?? "",
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        officeInformation:
            OfficeInformation.fromJson(json["office_information"]),
        education: List<dynamic>.from(json["education"].map((x) => x)),
        experience: List<dynamic>.from(json["experience"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "employee_code": employeeCode,
        "punch_id": punchId,
        "employee_name": employeeName,
        "employee_father": employeeFather,
        "employee_mother": employeeMother,
        "gender": gender,
        "date_of_birth":
            "${dateOfBirth?.year.toString().padLeft(4, '0')}-${dateOfBirth?.month.toString().padLeft(2, '0')}-${dateOfBirth?.day.toString().padLeft(2, '0')}",
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
        "office_information": officeInformation?.toJson(),
        "education": List<dynamic>.from(education.map((x) => x)),
        "experience": List<dynamic>.from(experience.map((x) => x)),
      };
}

class OfficeInformation {
  int? id;
  String? employeeId;
  DateTime? shiftDate;
  String? shiftId;
  DateTime? joiningDate;
  DateTime? confirmationDate;
  String? designation;
  int? departmentId;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  OfficeInformation({
    required this.id,
    required this.employeeId,
    required this.shiftDate,
    required this.shiftId,
    required this.joiningDate,
    required this.confirmationDate,
    required this.designation,
    required this.departmentId,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  factory OfficeInformation.fromJson(Map<String, dynamic> json) =>
      OfficeInformation(
        id: json["id"],
        employeeId: json["employee_id"],
        shiftDate: DateTime.parse(json["shift_date"]),
        shiftId: json["shift_id"],
        joiningDate: DateTime.parse(json["joining_date"]),
        confirmationDate: DateTime.parse(json["confirmation_date"]),
        designation: json["designation"],
        departmentId: json["department_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "employee_id": employeeId,
        "shift_date":
            "${shiftDate?.year.toString().padLeft(4, '0')}-${shiftDate?.month.toString().padLeft(2, '0')}-${shiftDate?.day.toString().padLeft(2, '0')}",
        "shift_id": shiftId,
        "joining_date":
            "${joiningDate?.year.toString().padLeft(4, '0')}-${joiningDate?.month.toString().padLeft(2, '0')}-${joiningDate?.day.toString().padLeft(2, '0')}",
        "confirmation_date":
            "${confirmationDate?.year.toString().padLeft(4, '0')}-${confirmationDate?.month.toString().padLeft(2, '0')}-${confirmationDate?.day.toString().padLeft(2, '0')}",
        "designation": designation,
        "department_id": departmentId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
      };
}
 */