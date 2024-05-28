import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hrms_app/model/hrms_employee_edit_model.dart';
import 'package:hrms_app/utils/app_variables/user_credential.dart';

class EmployeeEditDataController with ChangeNotifier {
  Future<HrmsEmployeeEditModel?> getEmployeeCurrentInfo(
      String apiLink, int employeeID) async {
    Dio dio = Dio();
    String urlString = apiLink + employeeID.toString();
    // final url = Uri.parse(apiLink + employeeID.toString());
    final response = await dio.get(urlString,
        options: Options(
            headers: {'Authorization': 'Bearer ${UserCredential.usertoken}'}));
    final data = jsonEncode(response.data);

    HrmsEmployeeEditModel jsonResponse = hrmsEmployeeEditModelFromJson(data);

    notifyListeners();
    return jsonResponse;
  }
}
