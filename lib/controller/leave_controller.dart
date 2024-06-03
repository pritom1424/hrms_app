import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hrms_app/model/hrms_leave_list_model.dart';
import 'package:hrms_app/model/hrms_leave_type.dart';
import 'package:hrms_app/utils/app_variables/api_links.dart';
import 'package:hrms_app/utils/app_variables/user_credential.dart';
import 'package:hrms_app/model/leave_apply_model.dart';

class LeaveController with ChangeNotifier {
  DateTime _fromdate = DateTime.now(), _toDate = DateTime.now();
  String? _leaveType;
  bool _isLoading = false;

  bool get isLoading {
    return _isLoading;
  }

  void setLoading(bool didLoad) {
    _isLoading = didLoad;
    notifyListeners();
  }

  DateTime get fromDate {
    return _fromdate;
  }

  void initLeaveForm() {
    _fromdate = DateTime.now();
    _toDate = DateTime.now();
    _leaveType = null;

    notifyListeners();
  }

  void setFromDate(DateTime selectDate) {
    _fromdate = selectDate;
    notifyListeners();
  }

  void setToDate(DateTime selectDate) {
    _toDate = selectDate;
    notifyListeners();
  }

  Future<String?> applyLeave(LeaveApplyModel leaveModel) async {
    Dio dio = Dio();
    print("create shift");
    final bodyData = leaveModel.toJson();
    String urlString = ApiLinks.leaveApplyLink;
    final response = await dio.post(urlString,
        data: bodyData,
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${UserCredential.usertoken}'
        }));

    if (response.statusCode == 200) {
      print("post created successfully");
      return "Leave application posted";
    } else {
      print("Leave application post failed");
    }
    return null;
  }

  Future<HrmsLeaveTypeModel> getLeaveType() async {
    Dio dio = Dio();

    // final url = Uri.parse(apiLink + employeeCode.toString());
    final urlString = ApiLinks.employeeLeaveType;
    final response = await dio.get(urlString,
        options: Options(
            headers: {'Authorization': 'Bearer ${UserCredential.usertoken}'}));
    HrmsLeaveTypeModel jsonResponse =
        hrmsLeaveTypeModelFromJson(jsonEncode(response.data));

    return jsonResponse;
  }

  int gettotalLeaveDays() {
    Duration diff = _toDate.difference(_fromdate);
    if (diff.inDays <= 0) {
      return 0;
    }

    return diff.inDays + 1;
  }

  Future<HrmsLeaveListModel> getLeaveList() async {
    Dio dio = Dio();

    String urlString = ApiLinks.leaveListLink;

    final response = await dio.get(urlString,
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${UserCredential.usertoken}'
        }));
    HrmsLeaveListModel jsonResponse =
        hrmsLeaveListModelFromJson(jsonEncode(response.data));
    return jsonResponse;
  }

  Future<String> approveLeave(int id) async {
    Dio dio = Dio();

    String urlString = ApiLinks.approveLeaveLink + id.toString();

    final response = await dio.get(urlString,
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${UserCredential.usertoken}'
        }));
    if (response.statusCode == 200) {
      return response.data["success"];
    }

    return "something went wrong!";
  }

  Future<String> cancelLeave(int id) async {
    Dio dio = Dio();

    String urlString = ApiLinks.cancelLeaveLink + id.toString();

    final response = await dio.get(urlString,
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${UserCredential.usertoken}'
        }));
    if (response.statusCode == 200) {
      return response.data["success"];
    }

    return "something went wrong!";
  }

  Future<int> getRemainLeave() async {
    Dio dio = Dio();
    final response = await dio.get(ApiLinks.employeeRemainLeaveDaysLink,
        options: Options(
            headers: {'Authorization': 'Bearer ${UserCredential.usertoken}'}));
    if (response.statusCode != 200) {
      return -1;
    }
    print('json response ${response.data['total_leave']}');

    return response.data['total_leave'];
  }

  void setLeaveType(String? type) {
    _leaveType = type;
    notifyListeners();
  }

  DateTime get toDate {
    return _toDate;
  }

  String? get leaveType {
    return _leaveType;
  }
//Future getLeaveTypes
}
