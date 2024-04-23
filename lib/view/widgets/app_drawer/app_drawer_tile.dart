import 'package:flutter/material.dart';
import 'package:hrms_app/utils/app_colors/app_colors.dart';
import 'package:hrms_app/utils/app_variables/app_vars.dart';

class AppDrawerListTile extends StatelessWidget {
  final int itemIndex;
  final dynamic route;
  const AppDrawerListTile({super.key, required this.itemIndex, this.route});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(width: 0.3, color: Colors.grey))),
      child: ListTile(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => route),
        ),
        leading: Icon(
          AppVars.appdrawerListData[itemIndex].entries.toList()[0].value,
          color: Appcolors.appdrawerItemIconColor,
        ),
        title: Text(
          AppVars.appdrawerListData[itemIndex].entries.toList()[0].key,
          style: TextStyle(
              color: Appcolors.appdrawerItemTextColor,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
