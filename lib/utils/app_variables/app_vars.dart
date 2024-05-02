import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
      "first list": CupertinoIcons.add_circled,
      "second lis": CupertinoIcons.app_badge
    },
    {"Users": CupertinoIcons.person},
    {
      "Settings": CupertinoIcons.gear,
      "top list": CupertinoIcons.today,
      "bottom list": CupertinoIcons.thermometer
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
    "Settings": [
      NoticeListPage(title: "Notifications"),
      NoticePage(
        title: "Notice",
      )
    ]
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
