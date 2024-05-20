import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hrms_app/model/hrms_employee_post_model.dart';
import '../model/hrms_departments_model.dart';
import '../model/hrms_employee_model.dart';
import '../model/hrms_idtypes_model.dart';
import '../model/hrms_nationality_model.dart';
import '../model/hrms_shifttypes_model.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

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
    final bodyData = hrmsEmployeePostModelToJson(hrmsEmployeePostModel);
    print(bodyData);
    final response = await http.post(url,
        body: bodyData, headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      print("post created successfully");
    } else {
      print("post creation failed");
    }
    notifyListeners();
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
