import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:hrms_app/utils/app_variables/user_credential.dart';
import 'package:hrms_app/view/pages/navigation_pages/leave/leave_page.dart';
import 'package:hrms_app/view/pages/splash_page.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'drawer_pages/employee/add_new_application.dart';
import 'navigation_pages/leave/leave_application.dart';
import 'navigation_pages/attendance_page.dart';
import 'navigation_pages/dashboard_page.dart';

import '../../utils/app_variables/app_vars.dart';
import 'navigation_pages/employee_profile_page.dart';

import '../widgets/app_drawer/custom_app_drawer.dart';

import '../widgets/appbar_default_widget.dart';
import '../widgets/navbar_widget.dart';

class RootNavPage extends StatefulWidget {
  const RootNavPage({super.key});

  @override
  State<RootNavPage> createState() => _RootNavPageState();
}

class _RootNavPageState extends State<RootNavPage> {
  int _selectedNavIndex = 0;

  @override
  void initState() {
    TimeExpire();

    super.initState();
  }

  void TimeExpire() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey("userData")) {
      return;
    }
    final extractedData =
        json.decode(prefs.getString('userData')!) as Map<String, dynamic>;
    final expiryDate = DateTime.parse(extractedData['expiryDate'] as String);
    final timeToExpiry = expiryDate.difference(DateTime.now()).inSeconds;

    print("expire:${timeToExpiry}");

    Timer(Duration(seconds: timeToExpiry), () {
      if (mounted) {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (ctx) => SplashPage()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    AppVars.screenSize = MediaQuery.of(context).size;
    List<Widget?> navViews() {
      return [
        DashboardPage(),
        (UserCredential.userid == 1) ? LeaveCards() : LeaveFormPage(),
        AttendancePage(),
        EmployeeProfilePage(id: ""),
      ];
    }

    void onNavigationTap(int index) {
      setState(() {
        _selectedNavIndex = index;
      });
    }

    return SafeArea(
        child: Scaffold(
            appBar: AppbarDefault(
              appbarName:
                  AppVars.navBarData[_selectedNavIndex].entries.toList()[0].key,
            ),
            drawer: const CustomAppDrawer(),
            bottomNavigationBar: BottomAppBar(
              height: kToolbarHeight,
              padding: EdgeInsets.all(0),
              shape: CircularNotchedRectangle(),
              clipBehavior: Clip.antiAlias,
              child: NavBarWidget(
                currentIndex: _selectedNavIndex,
                onTap: onNavigationTap,
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: (_selectedNavIndex == 0)
                ? FloatingActionButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => AddNewApplicationForm(
                                title: "Add Employee",
                              )));
                    },
                    foregroundColor: Colors.greenAccent,
                    backgroundColor: Colors.deepPurple,
                    child: const Icon(
                      Icons.add,
                      size: 24,
                    ),
                  )
                : null,
            body: navViews()[_selectedNavIndex]!));
  }
}
