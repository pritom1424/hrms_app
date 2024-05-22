import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:hrms_app/model/hrms_shift_list_model.dart';
import 'package:hrms_app/model/hrms_shift_model.dart';

class EmployeeShiftController with ChangeNotifier {
  Future<HrmsShiftListModel> loadEmployeeList(String apiLink) async {
    Dio dio = Dio();
    //final url = Uri.parse(apiLink);
    final response = await dio.get(apiLink);
    HrmsShiftListModel jsonResponse =
        hrmsShiftListModelFromJson(jsonEncode(response.data));

    /*    _userData = jsonResponse.data;
    _filterData = _userData; */

    return jsonResponse;
  }

  Future<HrmsShiftModel> loadShiftById(String apilink, int id) async {
    Dio dio = Dio();
    String urlString = apilink + id.toString();
    final response = await dio.get(urlString);
    HrmsShiftModel jsonResponse =
        hrmsShiftModelFromJson(jsonEncode(response.data));

    return jsonResponse;
  }

  Future<void> deleteShiftById(String apilink, int id) async {
    Dio dio = Dio();
    String urlString = apilink + id.toString();
    final response = await dio.get(urlString);
    if (response.statusCode == 200) {
      print("shift deleted successfully");
    } else {
      print("shift deletion failed");
    }
  }
}
