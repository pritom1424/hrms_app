import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hrms_app/model/admin_profile_model.dart';
import 'package:hrms_app/model/employee_profile_model.dart';
import 'package:hrms_app/utils/app_variables/user_credential.dart';

class EmployeeProfileController with ChangeNotifier {
  Future<HrmsEmployeeProfileModel> getEmployeeProfile(
      String apiLink, int userId) async {
    Dio dio = Dio();
    String urlString = apiLink + userId.toString();
    final response = await dio.get(urlString,
        options: Options(
            headers: {'Authorization': 'Bearer ${UserCredential.usertoken}'}));
    final HrmsEmployeeProfileModel jsonResponse =
        hrmsEmployeeProfileModelFromJson(jsonEncode(response.data));

    return jsonResponse;
  }

  Future<HrmsAdminProfileModel> getAdminProfile(
      String apiLink, int userId) async {
    Dio dio = Dio();
    String urlString = apiLink + userId.toString();
    final response = await dio.get(urlString,
        options: Options(
            headers: {'Authorization': 'Bearer ${UserCredential.usertoken}'}));
    final HrmsAdminProfileModel jsonResponse =
        hrmsAdminProfileModelFromJson(jsonEncode(response.data));

    return jsonResponse;
  }
}
