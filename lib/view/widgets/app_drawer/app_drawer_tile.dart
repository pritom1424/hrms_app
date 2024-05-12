import 'package:flutter/material.dart';
import '../../../utils/app_colors/app_colors.dart';
import '../../../utils/app_variables/app_vars.dart';

class AppDrawerListTile extends StatelessWidget {
  final int itemIndex;

  final bool? isReplacement;

  const AppDrawerListTile(
      {super.key, required this.itemIndex, this.isReplacement});

  @override
  Widget build(BuildContext context) {
    // AppVars.appsubDrawerListData[AppVars.appdrawerListData[itemIndex].entries.toList()[0].key]
    return Container(
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(width: 0.3, color: Colors.grey))),
      child: (AppVars.appdrawerListData[itemIndex].entries.toList().length > 1)
          ? ExpansionTile(
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
              iconColor: Appcolors.appdrawerItemIconColor,
              collapsedIconColor: Appcolors.appdrawerItemIconColor,
              children: List.generate(
                AppVars.appdrawerListData[itemIndex].entries.toList().length -
                    1,
                (index) => ListTile(
                  onTap: () {
                    AppVars.appsubDrawerListData[AppVars
                                .appdrawerListData[itemIndex].entries
                                .toList()[0]
                                .key] !=
                            null
                        ? (isReplacement == null || isReplacement == false)
                            ? Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        AppVars.appsubDrawerListData[AppVars
                                            .appdrawerListData[itemIndex]
                                            .entries
                                            .toList()[0]
                                            .key]![index]),
                              )
                            : Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        AppVars.appsubDrawerListData[AppVars
                                            .appdrawerListData[itemIndex]
                                            .entries
                                            .toList()[0]
                                            .key]![index]),
                              )
                        : null;
                  } /* (
                    AppVars.appsubDrawerListData[AppVars
                                .appdrawerListData[itemIndex].entries
                                .toList()[0]
                                .key] !=
                            null
                        ? Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    AppVars.appsubDrawerListData[AppVars
                                        .appdrawerListData[itemIndex].entries
                                        .toList()[0]
                                        .key]![index]),
                          )
                        : null */
                  ,
                  leading: Icon(
                    AppVars.appdrawerListData[itemIndex].entries
                        .toList()[index + 1]
                        .value,
                    color: Appcolors.appdrawerItemIconColor,
                  ),
                  title: Text(
                    AppVars.appdrawerListData[itemIndex].entries
                        .toList()[index + 1]
                        .key,
                    style: TextStyle(
                        color: Appcolors.appdrawerItemTextColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            )
          : ListTile(
              onTap: (AppVars.appdrawerRoutes[AppVars
                          .appdrawerListData[itemIndex].entries
                          .toList()[0]
                          .key] !=
                      null)
                  ? () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AppVars.appdrawerRoutes[
                                AppVars.appdrawerListData[itemIndex].entries
                                    .toList()[0]
                                    .key]),
                      )
                  : null,
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
