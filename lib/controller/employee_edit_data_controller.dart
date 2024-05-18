import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hrms_app/model/hrms_employee_edit_model.dart';
import 'package:http/http.dart' as http;

class EmployeeEditDataController with ChangeNotifier {
  Future<HrmsEmployeeEditModel?> getEmployeeCurrentInfo(
      String apiLink, int employeeID) async {
    final url = Uri.parse(apiLink + employeeID.toString());
    final response = await http.get(url);
    final data = jsonDecode(response.body);
    print("edit data ${data}");
    HrmsEmployeeEditModel jsonResponse =
        hrmsEmployeeEditModelFromJson(response.body);
    print("edit jsonResponse ${jsonResponse.id}");
    notifyListeners();
    return jsonResponse;
  }
}
