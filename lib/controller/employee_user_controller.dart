import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:hrms_app/model/hrms_employee_user_api.dart';
import 'package:hrms_app/model/hrms_user_model.dart';
import 'package:hrms_app/utils/app_variables/user_credential.dart';

class EmployeeUserController with ChangeNotifier {
  List<UserDatum> _userData = [];
  List<UserDatum> _filterData = [];

  Future<HrmsEmployeeUserApiModel> getUserLogin(
      String apiLink, String employeeCode) async {
    Dio dio = Dio();
    // final url = Uri.parse(apiLink + employeeCode.toString());
    final urlString = apiLink + employeeCode.toString();
    final response = await dio.get(urlString,
        options: Options(
            headers: {'Authorization': 'Bearer ${UserCredential.usertoken}'}));
    HrmsEmployeeUserApiModel jsonResponse =
        hrmsEmployeeUserApiModelFromJson(jsonEncode(response.data));

    return jsonResponse;
  }

  Future<void> updateUserStatus(String apiLink, int id) async {
    Dio dio = Dio();
    // final url = Uri.parse(apiLink + employeeCode.toString());

    final urlString = apiLink + id.toString();
    final response = await dio.get(urlString,
        options: Options(
            headers: {'Authorization': 'Bearer ${UserCredential.usertoken}'}));
  }

  Future<HrmsEmployeeUserModel> loadAllUser(String apiLink) async {
    Dio dio = Dio();
    // final url = Uri.parse(apiLink);
    print("user status: ${UserCredential.usertoken}");
    final response = await dio.get(apiLink,
        options: Options(
            headers: {'Authorization': 'Bearer ${UserCredential.usertoken}'}));
    HrmsEmployeeUserModel jsonResponse =
        hrmsEmployeeUserModelFromJson(jsonEncode(response.data));

    _userData = jsonResponse.data;
    _filterData = _userData;

    return jsonResponse;
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
              element.name.toString().toLowerCase().contains(query) ||
              element.employeeCode.toString().toLowerCase().contains(query) ||
              element.email.toString().toLowerCase().contains(query)))
          .toList();
    }
    //_userData.clear();

    notifyListeners();
  }

  List<UserDatum> get userData {
    return _filterData;
  }
}
