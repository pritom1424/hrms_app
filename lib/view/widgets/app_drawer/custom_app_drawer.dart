import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hrms_app/utils/app_colors/app_colors.dart';
import 'package:hrms_app/utils/app_variables/app_vars.dart';
import 'package:hrms_app/view/widgets/app_drawer/app_drawer_tile.dart';

class CustomAppDrawer extends StatelessWidget {
  const CustomAppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    // String iconPath = "assets/images/dhakaprokash_icon.png";
    return Drawer(
        backgroundColor: Appcolors.appdrawerBgColor, //AppColors.logoColorDeep
        child: Container(
          //height: GenericVars.scSize.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// Header of the Drawer
              /* Expanded(
                // borderOnForeground: false,
                //color: AppColors.logoColorDeep,

                child: InkWell(
                  onTap: () {},
                  child: FittedBox(
                    child: Container(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).padding.top + 5,
                          bottom: 5),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          //  Image.asset("assets/images/dhakaprokash_logo.png"),
                          CircleAvatar(
                            radius: 50,
                            // backgroundColor: Colors.transparent,
                            child: Icon(
                              CupertinoIcons.profile_circled,
                              size: 100,
                            ),
                          ), // AssetImage("assets/images/character_placeholder.png")
                          SizedBox(
                            height: 12,
                          ),
                          Text(
                            'User',
                            style: TextStyle(fontSize: 28, color: Colors.white),
                          ),
                          Text(
                            '@user.com',
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ), */
              Container(
                height: AppVars.screenSize.height * 0.9,
                color: Appcolors.appdrawerListColor,
                child: ListView.builder(
                    padding: const EdgeInsets.all(0),
                    itemCount: 5,
                    itemBuilder: (ctx, i) => AppDrawerListTile(itemIndex: i)),
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
