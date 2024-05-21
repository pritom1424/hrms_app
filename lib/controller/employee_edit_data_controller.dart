import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hrms_app/model/hrms_employee_edit_model.dart';

class EmployeeEditDataController with ChangeNotifier {
  Future<HrmsEmployeeEditModel?> getEmployeeCurrentInfo(
      String apiLink, int employeeID) async {
    Dio dio = Dio();
    String urlString = apiLink + employeeID.toString();
    // final url = Uri.parse(apiLink + employeeID.toString());
    final response = await dio.get(urlString);
    final data = jsonEncode(response.data);

    HrmsEmployeeEditModel jsonResponse = hrmsEmployeeEditModelFromJson(data);

    notifyListeners();
    return jsonResponse;
  }
}
