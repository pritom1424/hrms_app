import 'package:flutter/cupertino.dart';
import 'package:dio/dio.dart';
import 'package:hrms_app/utils/app_variables/api_links.dart';
import 'package:hrms_app/utils/app_variables/user_credential.dart';

class DashboardController with ChangeNotifier {
  Future<int> totalEmployee() async {
    Dio dio = Dio();
    // final url = Uri.parse(apiLink + employeeCode.toString());
    final urlString = ApiLinks.dashboardtotalEmployeeLink;
    final response = await dio.get(urlString,
        options: Options(
            headers: {'Authorization': 'Bearer ${UserCredential.usertoken}'}));

    return response.data;
  }

  Future<int> totalUser() async {
    Dio dio = Dio();
    // final url = Uri.parse(apiLink + employeeCode.toString());
    final urlString = ApiLinks.dashboardTotalUserLink;
    final response = await dio.get(urlString,
        options: Options(
            headers: {'Authorization': 'Bearer ${UserCredential.usertoken}'}));

    return response.data;
  }

  Future<int> totalAttendance() async {
    Dio dio = Dio();
    // final url = Uri.parse(apiLink + employeeCode.toString());
    final urlString = ApiLinks.dashboardtodayTotalAttendance;
    final response = await dio.get(urlString,
        options: Options(
            headers: {'Authorization': 'Bearer ${UserCredential.usertoken}'}));

    return response.data;
  }
}
