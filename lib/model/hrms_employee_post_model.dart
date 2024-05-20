import 'dart:convert';
import 'dart:io';

HrmsEmployeePostModel hrmsEmployeePostModelFromJson(String str) =>
    HrmsEmployeePostModel.fromJson(json.decode(str));

String hrmsEmployeePostModelToJson(HrmsEmployeePostModel data) =>
    json.encode(data.toJson());

class HrmsEmployeePostModel {
  int? id;
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
  File? image;
  int? userId;

  String? email;
  String? password;
  String? shiftDate;
  String? shiftId;
  String? joiningDate;
  String? confirmDate;
  String? designation;
  int? departmentId;
  String? selfAccess;
  HrmsEmployeePostModel(
      {required this.id,
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
      required this.email,
      required this.password,
      required this.shiftDate,
      required this.shiftId,
      required this.joiningDate,
      required this.confirmDate,
      required this.designation,
      required this.departmentId,
      required this.selfAccess});
  factory HrmsEmployeePostModel.fromJson(Map<String, dynamic> json) =>
      HrmsEmployeePostModel(
          id: json["id"],
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
          email: json["email_address"],
          password: json["password"],
          shiftDate: json["shift_date"],
          shiftId: json["shift_id"],
          joiningDate: json["joining_date"],
          confirmDate: json["confirmation_date"],
          designation: json["designation"],
          departmentId: json["department_id"],
          selfAccess: json["self_access"]);

  Map<String, dynamic> toJson() => {
        "id": id,
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
        "email_address": email,
        "password": password,
        "shift_date": shiftDate,
        "shift_id": shiftId,
        "joining_date": joiningDate,
        "confirmation_date": confirmDate,
        "designation": designation,
        "department_id": departmentId,
        "self_access": selfAccess
      };
}

/*
punch_id
employee_name
employee_father
employee_mother
gender
date_of_birth
nationality
id_type
id_number
permanent_address
present_address
user_id
image
email_address
password
shift_date
shift_id
joining_date
confirmation_date
designation
department_id






 */