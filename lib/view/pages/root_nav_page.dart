import 'package:flutter/material.dart';
import 'package:hrms_app/utils/app_variables/app_vars.dart';
import 'package:hrms_app/view/pages/login_page.dart';
import 'package:hrms_app/view/pages/navigation_pages/dashboard_page.dart';
import 'package:hrms_app/view/pages/navigation_pages/employee_page.dart';
import 'package:hrms_app/view/pages/navigation_pages/logout_page.dart';
import 'package:hrms_app/view/pages/navigation_pages/settings_page.dart';
import 'package:hrms_app/view/pages/navigation_pages/users_page.dart';
import 'package:hrms_app/view/widgets/app_drawer/custom_app_drawer.dart';
import 'package:hrms_app/view/widgets/app_drawer/drawer_with_menu.dart';
import 'package:hrms_app/view/widgets/appbar_default_widget.dart';
import 'package:hrms_app/view/widgets/navbar_widget.dart';

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
        DashboardPage(),
        //employee list
        EmployeePage(),
        // users
        UsersPage(),
        // settings
        SettingsPage(),
        //logout
        LogoutPage(),
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
        bottomNavigationBar: NavBarWidget(
          currentIndex: _selectedNavIndex,
          onTap: onNavigationTap,
        ),
        body: navViews()[_selectedNavIndex],
      ),
    );
  }
}
