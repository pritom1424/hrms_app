import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:hrms_app/controller/hrms_auth_controller.dart';
import 'package:hrms_app/model/hrms_attendance_post_model.dart';
import 'package:hrms_app/model/hrms_employee_attendance_list_model.dart';
import 'package:hrms_app/model/hrms_employee_attendance_model.dart';
import 'package:hrms_app/utils/app_variables/app_vars.dart';
import 'package:hrms_app/utils/app_variables/user_credential.dart';
import 'package:provider/provider.dart';

class EmployeeAttendanceController with ChangeNotifier {
  List<AttendanceDatum> _userData = [];
  List<AttendanceDatum> _filterData = [];

  Future<HrmsEmployeeAttendanceListModel> getEmployeeAttendanceList(
      String apiLink) async {
    Dio dio = Dio();
    // final url = Uri.parse(apiLink + employeeCode.toString());

    final urlString = apiLink;
    final response = await dio.get(urlString,
        options: Options(
            headers: {'Authorization': 'Bearer ${UserCredential.usertoken}'}));
    HrmsEmployeeAttendanceListModel jsonResponse =
        hrmsEmployeeAttendanceListModelFromJson(jsonEncode(response.data));
    _userData = jsonResponse.data;
    _filterData = _userData;

    return jsonResponse;
  }

  Future<HrmsEmployeeAttendanceModel> showEmployeeAttendance(
      String apiLink, int id) async {
    Dio dio = Dio();
    // final url = Uri.parse(apiLink + employeeCode.toString());
    final urlString = apiLink + id.toString();
    final response = await dio.get(urlString,
        options: Options(
            headers: {'Authorization': 'Bearer ${UserCredential.usertoken}'}));
    HrmsEmployeeAttendanceModel jsonResponse =
        hrmsEmployeeAttendanceModelFromJson(jsonEncode(response.data));

    return jsonResponse;
  }

  Future<void> updateAttendance(String apiLink, int employeeId,
      HrmsAttendancePostModel hrmsEmployeeAttendancePostModel) async {
    Dio dio = Dio();

    // final url = Uri.parse(apiLink + employeeId.toString());
    String urlString = apiLink + employeeId.toString();
    final bodyData =
        hrmsAttendancePostModelToJson(hrmsEmployeeAttendancePostModel);

    print("update attendance before post");

    final response = await dio.post(urlString,
        data: bodyData,
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${UserCredential.usertoken}'
        }));
    print("update attendance before post");
    if (response.statusCode == 200) {
      print("attendance update successfully");
    } else {
      print("attendance update failed");
    }

    notifyListeners();
  }

  /* Future<void> updateUserStatus(String apiLink, int id) async {
    Dio dio = Dio();
    // final url = Uri.parse(apiLink + employeeCode.toString());
    final urlString = apiLink + id.toString();
    final response = await dio.get(urlString);
  }

  Future<HrmsEmployeeUserModel> loadAllUser(String apiLink) async {
    Dio dio = Dio();
    // final url = Uri.parse(apiLink);
    final response = await dio.get(apiLink);
    HrmsEmployeeUserModel jsonResponse =
        hrmsEmployeeUserModelFromJson(jsonEncode(response.data));

    _userData = jsonResponse.data;
    _filterData = _userData;

    return jsonResponse;
  }*/

  void filterUserData(String query) {
    query = query.toLowerCase();

    if (query.isEmpty || query == "") {
      _filterData = _userData;
    } else {
      _filterData = _userData
          .where((element) => (element.attendanceDate
                  .toString()
                  .toLowerCase()
                  .contains(query) ||
              element.employeeId.toString().toLowerCase().contains(query) ||
              element.employeeName.toString().toLowerCase().contains(query) ||
              element.inTime.toString().toLowerCase().contains(query) ||
              element.outTime.toString().toLowerCase().contains(query) ||
              element.shiftDuration.toString().toLowerCase().contains(query) ||
              element.lateTime.toString().toLowerCase().contains(query) ||
              element.overTime.toString().toLowerCase().contains(query) ||
              element.totalWorkingHour
                  .toString()
                  .toLowerCase()
                  .contains(query) ||
              element.status.toString().toLowerCase().contains(query)))
          .toList();
    }
    //_userData.clear();

    notifyListeners();
  }

  Future<void> deleteEmployee(String apiLink, int employeeId) async {
    Dio dio = Dio();

    final urlString = apiLink + employeeId.toString();
    //final url = Uri.parse(urlString);
    final response = await dio.get(urlString,
        options: Options(
            headers: {'Authorization': 'Bearer ${UserCredential.usertoken}'}));

    if (response.statusCode == 200) {
      print("Employee deleted successfully");
    } else {
      print("Employee deletion failed");
    }
    notifyListeners();
  }

  List<AttendanceDatum> get userData {
    return _filterData;
  }
}
