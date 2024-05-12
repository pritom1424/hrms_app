import 'package:flutter/material.dart';
import 'package:hrms_app/view/pages/employee/add_new_application.dart';
import 'package:hrms_app/view/pages/leave_application.dart';
import 'package:hrms_app/view/pages/navigation_pages/attendance_page.dart';
import 'package:hrms_app/view/pages/navigation_pages/dashboard_page_2.dart';

import '../../utils/app_variables/app_vars.dart';
import 'employee_profile_page.dart';

import 'navigation_pages/employee_page.dart';
import 'navigation_pages/logout_page.dart';
import 'navigation_pages/settings_page.dart';

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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppVars.screenSize = MediaQuery.of(context).size;
    List<Widget> navViews() {
      return [
        //dashboard
        //DashboardPage(),
        DashboardPage2(),
        //employee list
        EmployeePage(),

        LeaveFormPage(),

        AttendancePage(),
        // user
        EmployeeProfilePage(id: ""), // UsersPage(),
        // settings
        //  SettingsPage(),
        //logout
        // LogoutPage(),
      ];
    }

    void onNavigationTap(int index) {
      setState(() {
        _selectedNavIndex = index;
      });
    }

    return SafeArea(
      // top: false,
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
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) => AddNewApplicationForm(
                      title: "Add Employee",
                    )));
          },
          foregroundColor: Colors.greenAccent,
          backgroundColor: Colors.deepPurple,
          // shape: customizations[index].$3,
          child: const Icon(
            Icons.add,
            size: 24,
          ),
        ),
        body: navViews()[_selectedNavIndex],
      ),
    );
  }
}
