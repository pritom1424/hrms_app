import 'dart:async';
import 'package:dio/dio.dart';
import 'package:hrms_app/utils/app_variables/api_links.dart';
import 'package:hrms_app/utils/app_variables/app_strings.dart';
import 'package:hrms_app/utils/app_variables/user_credential.dart';
import 'package:hrms_app/view/pages/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

import 'dart:convert';

class HrmsAuthController with ChangeNotifier {
  /* static const params = {
    'key': 'AIzaSyCBZMulm0QGQlpU_A2E5bTg_UBY38iS160',
  }; */
  String _token = "";
  DateTime _expiryDate = DateTime(0);
  int? _userId;
  bool _isLoading = false;

  Timer _authTimer = Timer(Duration.zero, () {});
  bool get isAuth {
    return token != "";
  }

  int? get userId {
    return _userId;
  }

  String get token {
    if (_expiryDate != DateTime(0) && _expiryDate.isAfter(DateTime.now())) {
      return _token;
    }
    return "";
  }

  DateTime get expiryDate {
    return _expiryDate;
  }

  Future<bool> Authenticate(String email, String password) async {
    Dio dio = Dio();
    final url = ApiLinks.employeeAuthLink;

    print("UUUU id : ${UserCredential.usertoken}");

    try {
      final response = await dio.post(url,
          data: json.encode(
            {
              'email': email,
              'password': password,
            },
          ),
          options: Options(headers: {'Content-Type': 'application/json'}));

      final responseData = response.data;
      if (responseData['error'] != null) {
        AppStrings.loginErrorMessage = responseData['error'];
        return false;
        // throw Exception(responseData['error']);
      }
      _token = responseData['token'];
      _userId = responseData['user']['id'];
      _expiryDate = DateTime.now().add(Duration(
          seconds: int.parse(responseData['expire_in_sec'].toString())));
      autoLogout();
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({
        'token': _token,
        'userId': userId,
        'expiryDate': _expiryDate.toIso8601String(),
      });
      prefs.remove('userData');

      prefs.setString('userData', userData);

      UserCredential.userid = userId;
      UserCredential.usertoken = _token;
      return true;
    } catch (error) {
      print("Error Auth: ${error.toString()}");
      return false;
    }
  }

  void logout() async {
    _token = "";
    _userId = null;
    _expiryDate = DateTime(0);
    if (_authTimer != Timer(Duration.zero, () {})) {
      _authTimer.cancel();
      _authTimer = Timer(Duration.zero, () {});
    }
    print("cleared before");
    //notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    print("cleared");
    prefs.remove('userData');
    prefs.clear();
    print("cleared");
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey("userData")) {
      print("Data stored");
      return false;
    }

    final extractedData =
        json.decode(prefs.getString('userData')!) as Map<String, dynamic>;
    final expiryDate = DateTime.parse(extractedData['expiryDate'] as String);
    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }
    _token = extractedData['token'].toString();
    _userId = int.tryParse(extractedData['userId'].toString());
    _expiryDate = expiryDate;
    print("token $token");
    print("user id $userId");
    UserCredential.userid = _userId;
    UserCredential.usertoken = _token;
    UserCredential.expiryDate = expiryDate;
    notifyListeners();
    autoLogout();
    return true;
  }

  void autoLogout() {
    if (_authTimer != Timer(Duration.zero, () {})) {
      _authTimer.cancel();
    }
    final timeToExpiry = _expiryDate.difference(DateTime.now()).inSeconds;

    _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
  }

  void setLoading(bool isLoad) {
    _isLoading = isLoad;
    notifyListeners();
  }

  bool get isLoading {
    return _isLoading;
  }
}
