import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:hrms_app/controller/employee_profile_controller.dart';
import 'package:hrms_app/utils/app_variables/api_links.dart';
import 'package:hrms_app/utils/app_variables/user_credential.dart';
import 'package:provider/provider.dart';
import '../../../utils/app_colors/app_colors.dart';
import '../../../utils/app_variables/app_vars.dart';
import '../../../utils/app_variables/image_paths.dart';
import 'app_drawer_tile.dart';

class CustomAppDrawer extends StatelessWidget {
  const CustomAppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    // String iconPath = "assets/images/dhakaprokash_icon.png";

    return Drawer(
        width: AppVars.screenSize.width * 0.7,
        backgroundColor: Appcolors.appdrawerBgColor, //AppColors.logoColorDeep
        child: Container(
          //height: GenericVars.scSize.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              /// Header of the Drawer
              InkWell(
                onTap: () {},
                child: Container(
                  height: AppVars.screenSize.height * 0.15,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      //  Image.asset("assets/images/dhakaprokash_logo.png"),
                      FittedBox(
                        child: (UserCredential.userid == null)
                            ? CircleAvatar(
                                radius: 20,
                                backgroundImage:
                                    AssetImage(ImagePath.proPicPlaceholderPath),
                                /* child: Icon(
                              CupertinoIcons.profile_circled,
                              size: 40,
                            ), */
                              )
                            : FutureBuilder(
                                future: Provider.of<EmployeeProfileController>(
                                        context,
                                        listen: false)
                                    .getEmployeeProfile(
                                        ApiLinks.employeeProfileLink,
                                        UserCredential.userid!),
                                builder: (ctx, snap) => (!snap.hasData)
                                    ? CircleAvatar(
                                        radius: 20,
                                        backgroundImage: AssetImage(
                                            ImagePath.proPicPlaceholderPath),
                                      )
                                    : CircleAvatar(
                                        radius: 20,
                                        backgroundImage: NetworkImage(
                                            "https://hrms.szamantech.com/storage/employee/${snap.data!.image}"),
                                      ),
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
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          ),
                          Text(
                            'admin@gmail.com',
                            style: TextStyle(fontSize: 12, color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  //  height: AppVars.screenSize.height * 0.75,
                  color: Appcolors.appdrawerListBgColor,
                  child: ListView.builder(
                      padding: const EdgeInsets.all(0),
                      itemCount: AppVars.appdrawerListData.length,
                      itemBuilder: (ctx, i) => AppDrawerListTile(
                            itemIndex: i,
                          )),
                ),
              ),
              /* const FittedBox(
                child: Text(
                  "Footer",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ) */
            ],
          ),
        ));
  }
}
