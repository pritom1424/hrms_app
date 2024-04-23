import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:hrms_app/utils/app_colors/app_colors.dart';
import 'package:hrms_app/utils/app_variables/app_vars.dart';
import 'package:hrms_app/utils/app_variables/image_paths.dart';
import 'package:hrms_app/view/pages/navigation_pages/dashboard_page.dart';
import 'package:hrms_app/view/pages/navigation_pages/employee_page.dart';
import 'package:hrms_app/view/pages/navigation_pages/logout_page.dart';
import 'package:hrms_app/view/pages/navigation_pages/settings_page.dart';
import 'package:hrms_app/view/pages/navigation_pages/users_page.dart';
import 'package:hrms_app/view/widgets/app_drawer/app_drawer_tile.dart';

class CustomAppDrawer extends StatelessWidget {
  const CustomAppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    // String iconPath = "assets/images/dhakaprokash_icon.png";
    List<dynamic> getdrawerRoutes(int index) {
      return [
        DashboardPage(
          title: AppVars.appdrawerListData[index].entries.toList()[0].key,
        ),
        EmployeePage(
          title: AppVars.appdrawerListData[index].entries.toList()[0].key,
        ),
        UsersPage(
          title: AppVars.appdrawerListData[index].entries.toList()[0].key,
        ),
        SettingsPage(
          title: AppVars.appdrawerListData[index].entries.toList()[0].key,
        ),
        LogoutPage(
          title: AppVars.appdrawerListData[index].entries.toList()[0].key,
        ),
      ];
    }

    return Drawer(
        backgroundColor: Appcolors.appdrawerBgColor, //AppColors.logoColorDeep
        child: Container(
          //height: GenericVars.scSize.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              /// Header of the Drawer
              Expanded(
                // borderOnForeground: false,
                //color: AppColors.logoColorDeep,

                child: InkWell(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        //  Image.asset("assets/images/dhakaprokash_logo.png"),
                        FittedBox(
                          child: CircleAvatar(
                            radius: 20,
                            backgroundImage: AssetImage(ImagePath.proPicPath),
                            /* child: Icon(
                              CupertinoIcons.profile_circled,
                              size: 40,
                            ), */
                          ),
                        ), // AssetImage("assets/images/character_placeholder.png")
                        const SizedBox(
                          width: 12,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Admin',
                              style:
                                  TextStyle(fontSize: 15, color: Colors.white),
                            ),
                            Text(
                              'admin@gmail.com',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                height: AppVars.screenSize.height * 0.75,
                color: Appcolors.appdrawerListBgColor,
                child: ListView.builder(
                    padding: const EdgeInsets.all(0),
                    itemCount: 5,
                    itemBuilder: (ctx, i) => AppDrawerListTile(
                          itemIndex: i,
                          route: getdrawerRoutes(i)[i],
                        )),
              ),
              const FittedBox(
                child: Text(
                  "Footer",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              )
            ],
          ),
        ));
  }
}
