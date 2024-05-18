import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hrms_app/model/hrms_departments_model.dart';
import 'package:hrms_app/model/hrms_employee_model.dart';
import 'package:hrms_app/model/hrms_idtypes_model.dart';
import 'package:hrms_app/model/hrms_nationality_model.dart';
import 'package:hrms_app/model/hrms_shifttypes_model.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class EmployeeDataController with ChangeNotifier {
  List<EmployeeDatum> _userData = [];
  List<EmployeeDatum> _filterData = [];

  Future<HrmsEmployeeModel> loadEmployeeList(String apiLink) async {
    final url = Uri.parse(apiLink);
    final response = await http.get(url);
    HrmsEmployeeModel jsonResponse =
        hrmsEmployeeModelFromJson(utf8.decode(response.bodyBytes));

    _userData = jsonResponse.data;
    _filterData = _userData;
    print("fetch userdata ${userData.length}");
    return jsonResponse;
  }

  void filterUserData(String query) {
    query = query.toLowerCase();

    if (query.isEmpty || query == "") {
      _filterData = _userData;
      print("query value: ${Bidi.stripHtmlIfNeeded(_filterData[0].image!)}");
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

  Future<HrmsShifttypeListModel> getShiftList(String apiLink) async {
    final url = Uri.parse(apiLink);
    final response = await http.get(url);
    HrmsShifttypeListModel jsonResponse =
        hrmsShifttypeListModelFromJson(utf8.decode(response.bodyBytes));
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
