import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import '../../../utils/app_colors/app_colors.dart';
import '../../../utils/app_variables/app_vars.dart';
import '../../../utils/app_variables/image_paths.dart';
import '../../pages/drawer_page/drawerpage_1.dart';
import '../../pages/drawer_page/drawerpage_2.dart';
import '../../pages/drawer_page/drawerpage_3.dart';
import '../../pages/drawer_page/drawerpage_4.dart';
import '../../pages/drawer_page/drawerpage_5.dart';
import '../../pages/login_page.dart';
import 'app_drawer_tile.dart';

class CustomAppDrawer extends StatelessWidget {
  const CustomAppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    // String iconPath = "assets/images/dhakaprokash_icon.png";
    List<dynamic> getdrawerRoutes(int index) {
      return [
        DrawerPage1(
          title: AppVars.appdrawerListData[index].entries.toList()[0].key,
        ),
        DrawerPage2(
          title: AppVars.appdrawerListData[index].entries.toList()[0].key,
        ),
        DrawerPage3(
          title: AppVars.appdrawerListData[index].entries.toList()[0].key,
        ),
        DrawerPage4(
          title: AppVars.appdrawerListData[index].entries.toList()[0].key,
        ),
        /* DrawerPage5(
          title: AppVars.appdrawerListData[index].entries.toList()[0].key,
        ), */
        LoginForm()
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
                    padding: const EdgeInsets.symmetric(horizontal: 10),
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
                        const Column(
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
