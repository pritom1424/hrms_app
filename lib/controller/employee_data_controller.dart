import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hrms_app/model/hrms_employee_post_model.dart';
import '../model/hrms_departments_model.dart';
import '../model/hrms_employee_model.dart';
import '../model/hrms_idtypes_model.dart';
import '../model/hrms_nationality_model.dart';
import '../model/hrms_shifttypes_model.dart';
import 'package:http/http.dart' as http;

import 'package:dio/dio.dart';

class EmployeeDataController with ChangeNotifier {
  List<EmployeeDatum> _userData = [];
  List<EmployeeDatum> _filterData = [];

  Future<HrmsEmployeeModel> loadEmployeeList(String apiLink) async {
    final url = Uri.parse(apiLink);
    final response = await http.get(url);
    HrmsEmployeeModel jsonResponse = hrmsEmployeeModelFromJson(response.body);

    _userData = jsonResponse.data;
    _filterData = _userData;

    print("fetch userdata ${userData.length}");
    return jsonResponse;
  }

  Future<void> deleteEmployee(String apiLink, int employeeId) async {
    final url = Uri.parse(apiLink + employeeId.toString());
    final response = await http.get(url);

    if (response.statusCode == 200) {
      print("Employee deleted successfully");
    } else {
      print("Employee deletion failed");
    }
    notifyListeners();
  }

  Future<void> createEmployee(
      String apiLink, HrmsEmployeePostModel hrmsEmployeePostModel) async {
    final url = Uri.parse(apiLink);
    final bodyData = hrmsEmployeePostModelToJson(hrmsEmployeePostModel);
    print("create employee: $bodyData");
    final response = await http.post(url,
        body: bodyData, headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      print("post created successfully");
    } else {
      print("post creation failed");
    }
    notifyListeners();
  }

  Future<void> updateEmployee(String apiLink, int employeeId,
      HrmsEmployeePostModel hrmsEmployeePostModel) async {
    final url = Uri.parse(apiLink + employeeId.toString());
    print("image path control ${hrmsEmployeePostModel.image}");
    final bodyData = hrmsEmployeePostModelToJson(hrmsEmployeePostModel);
    print("image path $bodyData");
    final response = await http.post(url,
        body: bodyData, headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      print("post created successfully");
    } else {
      print("post creation failed");
    }
    notifyListeners();
  }

  Future<void> uploadImage(String apiLink, int employeeId,
      HrmsEmployeePostModel hrmsEmployeePostModel, File? image) async {
/*     final url = Uri.parse(apiLink + employeeId.toString());
    final bodyData = hrmsEmployeePostModelToJson(hrmsEmployeePostModel);
    print(bodyData);
    final response = await http.post(url,
        body: bodyData, headers: {'Content-Type': 'application/json'}); */

    /*  if (response.statusCode == 200) {
      print("post created successfully");
    } else {
      print("post creation failed");
    } */

    if (image == null) return;
    final request = http.MultipartRequest(
        'POST', Uri.parse(apiLink + employeeId.toString()));
    // Add the image file to the request
    request.files.add(await http.MultipartFile.fromPath(
      'image',
      image.path,
    ));
    hrmsEmployeePostModel.toJson().forEach((key, value) {
      request.fields[key] = value.toString();
    });

    // Add other fields to the request
    //request.fields;
    /*'punch_id': punchIdController.text,
      'employee_name': employeeNameController.text,
      'employee_father': employeeFatherController.text,
      'employee_mother': employeeMotherController.text,
      'gender': genderController.text,
      'date_of_birth': dateOfBirthController.text,
      'nationality': nationalityController.text,
      'id_type': idTypeController.text,
      'id_number': idNumberController.text,
      'permanent_address': permanentAddressController.text,
      'present_address': presentAddressController.text,
      'user_id': userIdController.text,
      'email_address': emailAddressController.text,
      'password': passwordController.text,
      'shift_date': shiftDateController.text,
      'shift_id': shiftIdController.text,
      'joining_date': joiningDateController.text,
      'confirmation_date': confirmationDateController.text,
      'designation': designationController.text,
      'department_id': departmentIdController.text, */
    try {
      final response = await request.send();
      if (response.statusCode == 200) {
        print('Image and data uploaded successfully');
      } else {
        print('Upload failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error uploading image and data: $e');
    }
    notifyListeners();
  }

  Future<void> uploadImageDio(String apiLink, int employeeId,
      HrmsEmployeePostModel hrmsEmployeePostModel, File? image) async {
    Dio dio = Dio();
    final url = apiLink + employeeId.toString();
    print("image path dio: ${image!.path}");
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
    });
    try {
      Response response = await dio.post(url, data: formData);
      if (response.statusCode == 200) {
        print('Image uploaded successfully.');
      } else {
        print('Image upload failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  Future<void> CreateImageDio(String apiLink,
      HrmsEmployeePostModel hrmsEmployeePostModel, File? image) async {
    Dio dio = Dio();
    final url = apiLink;

    FormData formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(image!.path,
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
    });
    try {
      Response response = await dio.post(url, data: formData);
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
    final url = Uri.parse(apiLink);
    final response = await http.get(url);
    HrmsDepartmentListModel jsonResponse =
        hrmsDepartmentListModelFromJson(utf8.decode(response.bodyBytes));
    return jsonResponse;
  }

  Future<HrmsShifttypesModel> getShiftList(String apiLink) async {
    final url = Uri.parse(apiLink);
    final response = await http.get(url);
    HrmsShifttypesModel jsonResponse =
        hrmsShifttypesModelFromJson(utf8.decode(response.bodyBytes));
    return jsonResponse;
  }

  Future<HrmsNationalityListModel> getNationalityList(String apiLink) async {
    final url = Uri.parse(apiLink);
    final response = await http.get(url);
    HrmsNationalityListModel jsonResponse =
        hrmsNationalityListModelFromJson(utf8.decode(response.bodyBytes));

    return jsonResponse;
  }

  Future<HrmsIdtypeListModel> getIdTypeList(String apiLink) async {
    final url = Uri.parse(apiLink);
    final response = await http.get(url);
    HrmsIdtypeListModel jsonResponse =
        hrmsIdtypeListModelFromJson(utf8.decode(response.bodyBytes));

    return jsonResponse;
  }

  List<EmployeeDatum> get userData {
    return _filterData;
  }
}
