import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../../utils/app_variables/app_vars.dart';

import '../../../utils/app_colors/app_colors.dart';

class DashboardMenuTile extends StatelessWidget {
  final String imagePath, menuname;
  //final List<Map<String, dynamic>> onTap;
  final dynamic route;
  const DashboardMenuTile(
      {super.key,
      required this.imagePath,
      required this.menuname,
      this.route}); //this.onTap,

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (route != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => route),
          );
        } else {}
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            color: Appcolors.searchbarBgColor,
            borderRadius: BorderRadius.circular(15)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(20),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Text(
              menuname,
              style: Theme.of(context).textTheme.labelMedium,
            )
          ],
        ),
      ),
    );
  }
}
