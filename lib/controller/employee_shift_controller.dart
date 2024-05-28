import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:hrms_app/model/hrms_employee_post_model.dart';
import 'package:hrms_app/model/hrms_shift_list_model.dart';
import 'package:hrms_app/model/hrms_shift_model.dart';
import 'package:hrms_app/model/hrms_shift_post_model.dart';
import 'package:hrms_app/utils/app_variables/user_credential.dart';

class EmployeeShiftController with ChangeNotifier {
  Future<HrmsShiftListModel> loadEmployeeList(String apiLink) async {
    Dio dio = Dio();
    //final url = Uri.parse(apiLink);
    final response = await dio.get(apiLink,
        options: Options(
            headers: {'Authorization': 'Bearer ${UserCredential.usertoken}'}));
    HrmsShiftListModel jsonResponse =
        hrmsShiftListModelFromJson(jsonEncode(response.data));

    /*    _userData = jsonResponse.data;
    _filterData = _userData; */

    return jsonResponse;
  }

  Future<HrmsShiftModel> loadShiftById(String apilink, int id) async {
    Dio dio = Dio();
    String urlString = apilink + id.toString();
    final response = await dio.get(urlString,
        options: Options(
            headers: {'Authorization': 'Bearer ${UserCredential.usertoken}'}));
    HrmsShiftModel jsonResponse =
        hrmsShiftModelFromJson(jsonEncode(response.data));

    return jsonResponse;
  }

  Future<void> updateShift(String apiLink, int employeeId,
      HrmsShiftPostModel hrmsEmployeeShiftModel) async {
    Dio dio = Dio();

    String urlString = apiLink + employeeId.toString();
    final bodyData = hrmsShiftPostModelToJson(hrmsEmployeeShiftModel);

    final response = await dio.post(urlString,
        data: bodyData,
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${UserCredential.usertoken}'
        }));

    if (response.statusCode == 200) {
      print("post update successfully");
    } else {
      print("post update failed");
    }

    notifyListeners();
  }

  Future<void> createShift(
      String apiLink, HrmsShiftPostModel hrmsEmployeeShiftModel) async {
    Dio dio = Dio();
    print("create shift");
    String urlString = apiLink;
    final bodyData = hrmsShiftPostModelToJson(hrmsEmployeeShiftModel);

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

    notifyListeners();
  }

  Future<void> deleteShiftById(String apilink, int id) async {
    Dio dio = Dio();
    String urlString = apilink + id.toString();
    final response = await dio.get(urlString,
        options: Options(
            headers: {'Authorization': 'Bearer ${UserCredential.usertoken}'}));
    if (response.statusCode == 200) {
      print("shift deleted successfully");
    } else {
      print("shift deletion failed");
    }
  }
}
