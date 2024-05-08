import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hrms_app/view/pages/role/role_assigned_list.dart';
import 'package:hrms_app/view/pages/role/role_create.dart';
import 'package:hrms_app/view/pages/shift/shift_config.dart';
import 'image_paths.dart';
import '../../view/pages/notice_list_page.dart';
import '../../view/pages/notice_page.dart';

class AppVars {
  static Size screenSize = Size(600, 800);

//navbar
  static List<Map<String, IconData>> navBarData = [
    {"Dashboard": Icons.grid_view},
    {"Employee": CupertinoIcons.person_2},
    {"Users": CupertinoIcons.profile_circled},
    {"Settings": CupertinoIcons.gear},
    {"Logout": Icons.logout},
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
    {"Dashboard": CupertinoIcons.globe},
    {
      "Employee": CupertinoIcons.person_2,
      "Add Employee": CupertinoIcons.add_circled,
      "Employee List": CupertinoIcons.person_3
    },
    {"Users": CupertinoIcons.person},
    {"Shift": Icons.access_time, "Shift Config": Icons.sync},
    {
      "User Role": Icons.supervised_user_circle,
      "Role": Icons.supervisor_account,
      "Role Assign": Icons.person_add
    },
    {"User Permission": Icons.security},
    {
      "Settings": Icons.settings,
      "Office Shift": Icons.work,
      "Identity Type": Icons.card_membership,
      "Education": Icons.school,
      "Country": Icons.public,
      "Department": Icons.account_balance
    },
    {"Logout": Icons.logout},
  ];
  static Map<String, List<dynamic>> appsubDrawerListData = {
    "Employee": [
      NoticeListPage(title: "Notifications"),
      NoticePage(
        title: "Notice",
      )
    ],
    "Shift": [
      ShiftConfig(
        title: "Shift Config",
      )
    ],
    "User Role": [
      RoleCreate(
        title: "Role Create",
      ),
      RoleAssignedList(
        title: "Role Assign",
      )
    ]
    /* "Settings": [
      NoticeListPage(title: "Notifications"),
      NoticePage(
        title: "Notice",
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
}
