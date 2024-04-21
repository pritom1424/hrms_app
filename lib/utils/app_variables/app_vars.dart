import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppVars {
  static Size screenSize = Size(600, 800);

  static List<Map<String, IconData>> navBarData = [
    {"Dashboard": Icons.grid_view},
    {"Employee": CupertinoIcons.person_2},
    {"Users": CupertinoIcons.profile_circled},
    {"Settings": CupertinoIcons.gear},
    {"Logout": Icons.logout},
  ];
}
