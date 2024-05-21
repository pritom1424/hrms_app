import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:hrms_app/model/hrms_shift_list_model.dart';

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
}
