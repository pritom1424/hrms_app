import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hrms_app/view/pages/admin_panel.dart';
import 'package:hrms_app/view/pages/employee/add_new_application.dart';
import 'package:hrms_app/view/pages/employee_profile_page.dart';
import 'package:hrms_app/view/pages/employee/employee_table.dart';
import 'package:hrms_app/view/pages/navigation_pages/dashboard_page_2.dart';
import 'package:hrms_app/view/pages/settings/country_sett.dart';
import 'package:hrms_app/view/pages/settings/department_sett.dart';
import 'package:hrms_app/view/pages/settings/education_sett.dart';
import 'package:hrms_app/view/pages/settings/identity_type_sett.dart';
import 'package:hrms_app/view/pages/users/users_table.dart';
import '../../view/pages/drawer_page/drawerpage_1.dart';
import '../../view/pages/drawer_page/drawerpage_2.dart';
import '../../view/pages/login_page.dart';
import '../../view/pages/role/role_assign.dart';
import '../../view/pages/role/role_assigned_list.dart';
import '../../view/pages/role/role_create.dart';
import '../../view/pages/settings/office_shift_sett.dart';
import '../../view/pages/shift/shift_config.dart';
import '../../view/pages/user_permission/user_permission.dart';
import 'image_paths.dart';
import '../../view/pages/notice_list_page.dart';
import '../../view/pages/notice_page.dart';

class AppVars {
  static Size screenSize = Size(600, 800);

  static BoxDecoration customInputboxDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(10.0),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.3),
        spreadRadius: 2,
        blurRadius: 5,
        offset: Offset(0, 3),
      ),
    ],
  );
  static TextStyle customHintTextStyle =
      TextStyle(color: Colors.grey.withOpacity(0.5), fontSize: 15);

  static EdgeInsets inputContentPadding =
      const EdgeInsets.symmetric(horizontal: 20);

//navbar
  static List<Map<String, IconData>> navBarData = [
    {"Home": Icons.grid_view},
    //  {"Employee": CupertinoIcons.person_2},
    {"Leave": Icons.flight_takeoff},
    {"Attendance": Icons.calendar_month},
    {"Me": CupertinoIcons.profile_circled},
    // {"Settings": CupertinoIcons.gear},
    // {"Logout": Icons.logout},
  ];

// dashboard menu data
  static List<Map<String, String>> dashboardData = [
    {"PERFORMANCE": ImagePath.dashmenuLogopath[0]},
    {"LEAVE": ImagePath.dashmenuLogopath[1]},
    {"ORGANIZATION": ImagePath.dashmenuLogopath[2]},
    {"TIMESHEET": ImagePath.dashmenuLogopath[3]},
    {"ATTENDANCE": ImagePath.dashmenuLogopath[4]},
    {"FILES": ImagePath.dashmenuLogopath[5]},
  ];

  static List<Map<String, dynamic>> appdrawerListData = [
    // {"Dashboard": CupertinoIcons.globe},
    {
      "Employee": CupertinoIcons.person_2,
      "Add Employee": CupertinoIcons.add_circled,
      "Employee List": CupertinoIcons.person_3
    },
    {"Users": CupertinoIcons.person},
    {"Shift": Icons.access_time, "Shift Config": Icons.sync},
    /*   {
      "User Role": Icons.supervised_user_circle,
      "Role": Icons.supervisor_account,
      "Role Assign": Icons.person_add,
      "Role Add": Icons.add
    },
    {"User Permission": Icons.security},
    {
      "Settings": Icons.settings,
      "Office Shift": Icons.work,
      "Identity Type": Icons.card_membership,
      "Education": Icons.school,
      "Country": Icons.public,
      "Department": Icons.account_balance
    }, */
    {"Logout": Icons.logout},
  ];
  static Map<String, dynamic> appdrawerRoutes = {
    /*  "Dashboard": DrawerPage1(
      title: "Dashboard",
    ) */
    /*  "Dashboard": DashboardPage2(
      title: "Dashboard",
    ), */

    /* "Users": DrawerPage2(
      title: "Users",
    ) */

    "Users": UsersList(
      title: "Users",
    ),
    /*  "User Permission": UserPermission(
      title: "User Permission",
    ), */
    "Logout": LoginForm()
  };
  static Map<String, List<dynamic>> appsubDrawerListData = {
    "Employee": [
      AddNewApplicationForm(
        title: "Add Employee",
      ),
      EmployeeList()
    ],
    "Shift": [
      ShiftConfig(
        title: "Shift Config",
      )
    ],
    /*    "User Role": [
      RoleCreate(
        title: "Role Create",
      ),
      RoleAssignedList(
        title: "Role Assign",
      ),
      RoleAssign(
        title: "Role Assign",
      )
    ], */
    /* "Settings": [
      OfficeShiftSettings(
        title: "Office Shift",
      ),
      IdentityTypeSettings(
        title: "Identity Type",
      ),
      EducationSettings(
        title: "Education",
      ),
      CountrySettings(
        title: "Country",
      ),
      DepartmentSettings(
        title: "Department",
      )
    ] */
  };
  static List<Map<String, String>> noticeData = [
    {
      'title': "Scheduled meeting with Managing Director Sir regarding website",
      'subtitle':
          "Access to the office premises will now require the use of security badges. All employees must ensure they have their badges with them at all times."
    },
    {
      'title': "Scheduled meeting with Managing Director Sir regarding website",
      'subtitle':
          "Access to the office premises will now require the use of security badges. All employees must ensure they have their badges with them at all times."
    },
    {
      'title': "Scheduled meeting with Managing Director Sir regarding website",
      'subtitle':
          "Access to the office premises will now require the use of security badges. All employees must ensure they have their badges with them at all times."
    },
    {
      'title': "Scheduled meeting with Managing Director Sir regarding website",
      'subtitle':
          "Access to the office premises will now require the use of security badges. All employees must ensure they have their badges with them at all times."
    },
    {
      'title': "Scheduled meeting with Managing Director Sir regarding website",
      'subtitle':
          "Access to the office premises will now require the use of security badges. All employees must ensure they have their badges with them at all times."
    },
    {
      'title': "Scheduled meeting with Managing Director Sir regarding website",
      'subtitle':
          "Access to the office premises will now require the use of security badges. All employees must ensure they have their badges with them at all times."
    },
    {
      'title': "Scheduled meeting with Managing Director Sir regarding website",
      'subtitle':
          "Access to the office premises will now require the use of security badges. All employees must ensure they have their badges with them at all times."
    },
    {
      'title': "Scheduled meeting with Managing Director Sir regarding website",
      'subtitle':
          "Access to the office premises will now require the use of security badges. All employees must ensure they have their badges with them at all times."
    }
  ];
  static List<Map<String, dynamic>> filteredUserData = [];
}
