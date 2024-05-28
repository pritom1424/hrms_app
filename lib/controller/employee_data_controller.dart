import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hrms_app/model/hrms_employee_post_model.dart';
import 'package:hrms_app/utils/app_variables/user_credential.dart';
import '../model/hrms_departments_model.dart';
import '../model/hrms_employee_model.dart';
import '../model/hrms_idtypes_model.dart';
import '../model/hrms_nationality_model.dart';
import '../model/hrms_shifttypes_model.dart';

import 'package:dio/dio.dart';

class EmployeeDataController with ChangeNotifier {
  List<EmployeeDatum> _userData = [];
  List<EmployeeDatum> _filterData = [];

  Future<HrmsEmployeeModel> loadEmployeeList(String apiLink) async {
    Dio dio = Dio();
    // final url = Uri.parse(apiLink);

    //http package
    //  final url = Uri.parse(ApiConstant.homePageSpecialContentLink);
/* 
    final response = await http.get(url);

    HrmsEmployeeModel jsonResponse = hrmsEmployeeModelFromJson(response.body); */

    //

    final response = await dio.get(apiLink,
        options: Options(
            headers: {'Authorization': 'Bearer ${UserCredential.usertoken}'}));

    HrmsEmployeeModel jsonResponse =
        hrmsEmployeeModelFromJson(json.encode(response.data));

    _userData = jsonResponse.data;
    _filterData = _userData;

    return jsonResponse;
  }

  Future<void> deleteEmployee(String apiLink, int employeeId) async {
    Dio dio = Dio();
    final urlString = apiLink + employeeId.toString();
    //final url = Uri.parse(urlString);
    final response = await dio.get(urlString,
        options: Options(
            headers: {'Authorization': 'Bearer ${UserCredential.usertoken}'}));

    if (response.statusCode == 200) {
      print("Employee deleted successfully");
    } else {
      print("Employee deletion failed");
    }
    notifyListeners();
  }

  Future<void> createEmployee(
      String apiLink, HrmsEmployeePostModel hrmsEmployeePostModel) async {
    Dio dio = Dio();
    print("into dio");
    if (hrmsEmployeePostModel.image == null) {
      print("into dio null");
      //  final url = Uri.parse(apiLink);
      final bodyData = hrmsEmployeePostModelToJson(hrmsEmployeePostModel);

      final response = await dio.post(apiLink,
          data: hrmsEmployeePostModel,
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${UserCredential.usertoken}'
          }));

      // {'Content-Type': 'application/json'});

      if (response.statusCode == 200) {
        print("post created successfully");
      } else {
        print("post creation failed");
      }
    } else {
      _createImageDio(
          apiLink, hrmsEmployeePostModel, hrmsEmployeePostModel.image!);
    }
    notifyListeners();
  }

  Future<void> updateEmployee(String apiLink, int employeeId,
      HrmsEmployeePostModel hrmsEmployeePostModel) async {
    Dio dio = Dio();

    if (hrmsEmployeePostModel.image == null) {
      // final url = Uri.parse(apiLink + employeeId.toString());
      String urlString = apiLink + employeeId.toString();
      final bodyData = hrmsEmployeePostModelToJson(hrmsEmployeePostModel);

      final response = await dio.post(urlString,
          data: bodyData,
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${UserCredential.usertoken}'
          }));

      if (response.statusCode == 200) {
        print("post created successfully");
      } else {
        print("post creation failed");
      }
    } else {
      _uploadImageDio(apiLink, employeeId, hrmsEmployeePostModel,
          hrmsEmployeePostModel.image!);
    }
    notifyListeners();
  }

  Future<void> _uploadImageDio(String apiLink, int employeeId,
      HrmsEmployeePostModel hrmsEmployeePostModel, File image) async {
    Dio dio = Dio();
    final url = apiLink + employeeId.toString();

    FormData formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(image!.path,
          filename: image.path.split("/").last),
      // Add other fields if needed
      'id': hrmsEmployeePostModel.id,
      'punch_id': hrmsEmployeePostModel.punchId,
      'employee_name': hrmsEmployeePostModel.employeeName,
      'employee_father': hrmsEmployeePostModel.employeeFather,
      'employee_mother': hrmsEmployeePostModel.employeeMother,
      'gender': hrmsEmployeePostModel.gender,
      'date_of_birth': hrmsEmployeePostModel.dateOfBirth,
      'nationality': hrmsEmployeePostModel.nationality,
      'id_type': hrmsEmployeePostModel.idType,
      'id_number': hrmsEmployeePostModel.idNumber,
      'permanent_address': hrmsEmployeePostModel.permanentAddress,
      'present_address': hrmsEmployeePostModel.presentAddress,
      'user_id': hrmsEmployeePostModel.userId,
      'email_address': hrmsEmployeePostModel.email,
      'password': hrmsEmployeePostModel.password,
      'shift_date': hrmsEmployeePostModel.shiftDate,
      'shift_id': hrmsEmployeePostModel.shiftId,
      'joining_date': hrmsEmployeePostModel.joiningDate,
      'confirmation_date': hrmsEmployeePostModel.confirmDate,
      'designation': hrmsEmployeePostModel.designation,
      'department_id': hrmsEmployeePostModel.departmentId,
      "self_access": hrmsEmployeePostModel.selfAccess
    });
    try {
      Response response = await dio.post(url,
          data: formData,
          options: Options(headers: {
            'Authorization': 'Bearer ${UserCredential.usertoken}'
          }));
      if (response.statusCode == 200) {
        print('Image uploaded successfully.');
      } else {
        print('Image upload failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  Future<void> _createImageDio(String apiLink,
      HrmsEmployeePostModel hrmsEmployeePostModel, File image) async {
    Dio dio = Dio();
    final url = apiLink;

    FormData formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(image.path,
          filename: 'profile-upload.jpg'),
      // Add other fields if needed
      'id': hrmsEmployeePostModel.id,
      'punch_id': hrmsEmployeePostModel.punchId,
      'employee_name': hrmsEmployeePostModel.employeeName,
      'employee_father': hrmsEmployeePostModel.employeeFather,
      'employee_mother': hrmsEmployeePostModel.employeeMother,
      'gender': hrmsEmployeePostModel.gender,
      'date_of_birth': hrmsEmployeePostModel.dateOfBirth,
      'nationality': hrmsEmployeePostModel.nationality,
      'id_type': hrmsEmployeePostModel.idType,
      'id_number': hrmsEmployeePostModel.idNumber,
      'permanent_address': hrmsEmployeePostModel.permanentAddress,
      'present_address': hrmsEmployeePostModel.presentAddress,
      'user_id': hrmsEmployeePostModel.userId,
      'email_address': hrmsEmployeePostModel.email,
      'password': hrmsEmployeePostModel.password,
      'shift_date': hrmsEmployeePostModel.shiftDate,
      'shift_id': hrmsEmployeePostModel.shiftId,
      'joining_date': hrmsEmployeePostModel.joiningDate,
      'confirmation_date': hrmsEmployeePostModel.confirmDate,
      'designation': hrmsEmployeePostModel.designation,
      'department_id': hrmsEmployeePostModel.departmentId,
      "self_access": hrmsEmployeePostModel.selfAccess
    });
    try {
      Response response = await dio.post(url,
          data: formData,
          options: Options(headers: {
            'Authorization': 'Bearer ${UserCredential.usertoken}'
          }));
      if (response.statusCode == 200) {
        print('Image Created successfully.');
      } else {
        print('Image Created failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  void filterUserData(String query) {
    query = query.toLowerCase();

    if (query.isEmpty || query == "") {
      _filterData = _userData;
    } else {
      _filterData = _userData
          .where((element) => (element.id
                  .toString()
                  .toLowerCase()
                  .contains(query) ||
              element.employeeName.toString().toLowerCase().contains(query) ||
              element.employeeCode.toString().toLowerCase().contains(query) ||
              element.punchId.toString().toLowerCase().contains(query) ||
              element.employeeFather.toString().toLowerCase().contains(query) ||
              element.employeeMother.toString().toLowerCase().contains(query) ||
              element.gender.toString().toLowerCase().contains(query) ||
              element.dateOfBirth.toString().toLowerCase().contains(query) ||
              element.nationality.toString().toLowerCase().contains(query)))
          .toList();
    }
    //_userData.clear();

    notifyListeners();
  }

  Future<HrmsDepartmentListModel> getDepartmentList(String apiLink) async {
    Dio dio = Dio();
    //final url = Uri.parse(apiLink);
    final response = await dio.get(apiLink,
        options: Options(
            headers: {'Authorization': 'Bearer ${UserCredential.usertoken}'}));
    HrmsDepartmentListModel jsonResponse =
        hrmsDepartmentListModelFromJson(jsonEncode(response.data));
    return jsonResponse;
  }

  Future<HrmsShifttypesModel> getShiftList(String apiLink) async {
    Dio dio = Dio();
    //final url = Uri.parse(apiLink);
    final response = await dio.get(apiLink,
        options: Options(
            headers: {'Authorization': 'Bearer ${UserCredential.usertoken}'}));
    HrmsShifttypesModel jsonResponse =
        hrmsShifttypesModelFromJson(jsonEncode(response.data));
    return jsonResponse;
  }

  Future<HrmsNationalityListModel> getNationalityList(String apiLink) async {
    Dio dio = Dio();
    //final url = Uri.parse(apiLink);
    final response = await dio.get(apiLink,
        options: Options(
            headers: {'Authorization': 'Bearer ${UserCredential.usertoken}'}));
    HrmsNationalityListModel jsonResponse =
        hrmsNationalityListModelFromJson(jsonEncode(response.data));

    return jsonResponse;
  }

  Future<HrmsIdtypeListModel> getIdTypeList(String apiLink) async {
    Dio dio = Dio();
    // final url = Uri.parse(apiLink);
    final response = await dio.get(apiLink,
        options: Options(
            headers: {'Authorization': 'Bearer ${UserCredential.usertoken}'}));
    HrmsIdtypeListModel jsonResponse =
        hrmsIdtypeListModelFromJson(jsonEncode(response.data));

    return jsonResponse;
  }

  List<EmployeeDatum> get userData {
    return _filterData;
  }
}
