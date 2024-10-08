import 'package:flutter/material.dart';
import 'package:hrms_app/controller/dashboard_controller.dart';
import 'package:hrms_app/controller/employee_attendance_controller.dart';
import 'package:hrms_app/controller/employee_edit_data_controller.dart';
import 'package:hrms_app/controller/employee_profile_controller.dart';
import 'package:hrms_app/controller/employee_shift_controller.dart';
import 'package:hrms_app/controller/employee_user_controller.dart';
import 'package:hrms_app/controller/hrms_auth_controller.dart';
import 'package:hrms_app/controller/leave_controller.dart';
import 'utils/app_variables/app_strings.dart';
import 'controller/employee_data_controller.dart';
import 'view/pages/splash_page.dart';
import 'package:provider/provider.dart';

import 'utils/app_colors/app_colors.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<HrmsAuthController>(
        create: (_) => HrmsAuthController(),
      ),
      ChangeNotifierProvider<EmployeeDataController>(
        create: (_) => EmployeeDataController(),
      ),
      ChangeNotifierProvider<EmployeeEditDataController>(
        create: (_) => EmployeeEditDataController(),
      ),
      ChangeNotifierProvider<EmployeeUserController>(
        create: (_) => EmployeeUserController(),
      ),
      ChangeNotifierProvider<EmployeeShiftController>(
        create: (_) => EmployeeShiftController(),
      ),
      ChangeNotifierProvider<EmployeeAttendanceController>(
        create: (_) => EmployeeAttendanceController(),
      ),
      ChangeNotifierProvider<EmployeeProfileController>(
        create: (_) => EmployeeProfileController(),
      ),
      ChangeNotifierProvider<LeaveController>(
        create: (_) => LeaveController(),
      ),
      ChangeNotifierProvider<DashboardController>(
        create: (_) => DashboardController(),
      )
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            scaffoldBackgroundColor: Appcolors.appBgColor,
            appBarTheme: AppBarTheme(
              backgroundColor: Appcolors.appBarColor,
              titleTextStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 20),
            ),
            textTheme: const TextTheme(
                //menu item
                labelSmall: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    fontFamily: AppStrings.currentFontFamily),
                labelMedium: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                    fontFamily: AppStrings.currentFontFamily),
                headlineLarge: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    fontFamily: AppStrings.currentFontFamily),
                headlineMedium: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: AppStrings.currentFontFamily),
                headlineSmall: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: AppStrings.currentFontFamily),
                titleLarge: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: AppStrings.currentFontFamily),
                titleMedium: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    fontFamily: AppStrings.currentFontFamily),
                /*   bodyLarge:
                      TextStyle(fontSize: 25, fontWeight: FontWeight.normal), */
                /*   bodyMedium:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.normal), */
                bodySmall: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    fontFamily: AppStrings.currentFontFamily))),
        home: SplashPage());
  }
}
