// To parse this JSON data, do
//
//     final hrmsEmployeeEditModel = hrmsEmployeeEditModelFromJson(jsonString);

import 'dart:convert';

HrmsEmployeeEditModel hrmsEmployeeEditModelFromJson(String str) =>
    HrmsEmployeeEditModel.fromJson(json.decode(str));

String hrmsEmployeeEditModelToJson(HrmsEmployeeEditModel data) =>
    json.encode(data.toJson());

class HrmsEmployeeEditModel {
  int id;
  String employeeCode;
  String punchId;
  String? employeeName;
  String? employeeFather;
  String? employeeMother;
  String? phoneNumber;
  String? gender;
  DateTime? dateOfBirth;
  String? nationality;
  String? idType;
  String? idNumber;
  String? permanentAddress;
  String? presentAddress;
  String? image;
  int? userId;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  OfficeInformation officeInformation;
  List<Education> education;
  List<Experience> experience;

  HrmsEmployeeEditModel({
    required this.id,
    required this.employeeCode,
    required this.punchId,
    required this.employeeName,
    required this.employeeFather,
    required this.employeeMother,
    required this.phoneNumber,
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
        phoneNumber: json["phone_number"],
        gender: json["gender"],
        dateOfBirth: DateTime.parse(json["date_of_birth"]),
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
        education: List<Education>.from(
            json["education"].map((x) => Education.fromJson(x))),
        experience: List<Experience>.from(
            json["experience"].map((x) => Experience.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "employee_code": employeeCode,
        "punch_id": punchId,
        "employee_name": employeeName,
        "employee_father": employeeFather,
        "employee_mother": employeeMother,
        "phone_number": phoneNumber,
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
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
        "office_information": officeInformation.toJson(),
        "education": List<dynamic>.from(education.map((x) => x.toJson())),
        "experience": List<dynamic>.from(experience.map((x) => x.toJson())),
      };
}

class Education {
  int? id;
  String? employeeId;
  String? educationType;
  String? passingYear;
  String? cgpa;
  dynamic totalCgpa;
  String? gpa;
  dynamic division;
  String? instituteName;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  Education({
    required this.id,
    required this.employeeId,
    required this.educationType,
    required this.passingYear,
    required this.cgpa,
    required this.totalCgpa,
    required this.gpa,
    required this.division,
    required this.instituteName,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  factory Education.fromJson(Map<String, dynamic> json) => Education(
        id: json["id"],
        employeeId: json["employee_id"],
        educationType: json["education_type"],
        passingYear: json["passing_year"],
        cgpa: json["cgpa"],
        totalCgpa: json["total_cgpa"],
        gpa: json["gpa"],
        division: json["division"],
        instituteName: json["institute_name"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "employee_id": employeeId,
        "education_type": educationType,
        "passing_year": passingYear,
        "cgpa": cgpa,
        "total_cgpa": totalCgpa,
        "gpa": gpa,
        "division": division,
        "institute_name": instituteName,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
      };
}

class Experience {
  int? id;
  int? employeeId;
  String? previousWorkplace;
  String? designation;
  DateTime? startDate;
  DateTime? endDate;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;

  Experience({
    required this.id,
    required this.employeeId,
    required this.previousWorkplace,
    required this.designation,
    required this.startDate,
    required this.endDate,
    required this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Experience.fromJson(Map<String, dynamic> json) => Experience(
        id: json["id"],
        employeeId: json["employee_id"],
        previousWorkplace: json["previous_workplace"],
        designation: json["designation"],
        startDate: DateTime.parse(json["start_date"]),
        endDate: DateTime.parse(json["end_date"]),
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "employee_id": employeeId,
        "previous_workplace": previousWorkplace,
        "designation": designation,
        "start_date":
            "${startDate?.year.toString().padLeft(4, '0')}-${startDate?.month.toString().padLeft(2, '0')}-${startDate?.day.toString().padLeft(2, '0')}",
        "end_date":
            "${endDate?.year.toString().padLeft(4, '0')}-${endDate?.month.toString().padLeft(2, '0')}-${endDate?.day.toString().padLeft(2, '0')}",
        "deleted_at": deletedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class OfficeInformation {
  int? id;
  String? employeeId;
  DateTime? shiftDate;
  String? shiftId;
  String? joiningDate;
  DateTime? confirmationDate;
  String? designation;
  int? departmentId;
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
        shiftDate: DateTime.parse(json["shift_date"]),
        shiftId: json["shift_id"],
        joiningDate: json["joining_date"],
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
        "joining_date": joiningDate,
        "confirmation_date":
            "${confirmationDate?.year.toString().padLeft(4, '0')}-${confirmationDate?.month.toString().padLeft(2, '0')}-${confirmationDate?.day.toString().padLeft(2, '0')}",
        "designation": designation,
        "department_id": departmentId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
      };
}
