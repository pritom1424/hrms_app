import 'package:flutter/material.dart';

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
    return Drawer(
        width: AppVars.screenSize.width * 0.7,
        backgroundColor: Appcolors.appdrawerBgColor,
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              /// Header of the Drawer
              Container(
                height: AppVars.screenSize.height * 0.1,
                width: double.infinity,
                color: Appcolors.appdrawerListBgColor,
                padding: EdgeInsets.symmetric(horizontal: 60, vertical: 10),
                child: Image.asset(
                  "assets/images/hrms_logo.png",
                  fit: BoxFit.contain,
                ),
              ),

              InkWell(
                onTap: () {},
                child: Container(
                  height: AppVars.screenSize.height * 0.15,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: FutureBuilder(
                    future: Provider.of<EmployeeProfileController>(context,
                            listen: false)
                        .getEmployeeProfile(ApiLinks.employeeProfileLink,
                            UserCredential.userid!),
                    builder: (ctx, snap) => (!snap.hasData)
                        ? FutureBuilder(
                            future: Provider.of<EmployeeProfileController>(
                                    context,
                                    listen: false)
                                .getAdminProfile(ApiLinks.employeeProfileLink,
                                    UserCredential.userid!),
                            builder: (ctx, snapAd) => (snapAd.hasData)
                                ? Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      //  Image.asset("assets/images/dhakaprokash_logo.png"),
                                      FittedBox(
                                          child: CircleAvatar(
                                        radius: 20,
                                        backgroundImage: AssetImage(
                                            ImagePath.proPicPlaceholderPath),
                                      )), // AssetImage("assets/images/character_placeholder.png")
                                      const SizedBox(
                                        width: 12,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            snapAd.data!.name ?? "no name",
                                            style: const TextStyle(
                                                fontSize: 15,
                                                color: Colors.white),
                                          ),
                                          Text(
                                            snapAd.data!.email ?? 'Admin',
                                            style: const TextStyle(
                                                fontSize: 12,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                : const SizedBox.shrink())
                        : Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              //  Image.asset("assets/images/dhakaprokash_logo.png"),
                              FittedBox(
                                child: (UserCredential.userid == null)
                                    ? CircleAvatar(
                                        radius: 20,
                                        backgroundImage: AssetImage(
                                            ImagePath.proPicPlaceholderPath),
                                      )
                                    : (snap.data!.image == null)
                                        ? CircleAvatar(
                                            radius: 20,
                                            backgroundImage: AssetImage(
                                                ImagePath
                                                    .proPicPlaceholderPath),
                                          )
                                        : CircleAvatar(
                                            radius: 20,
                                            backgroundImage: NetworkImage(
                                                "https://hrms.szamantech.com/storage/employee/${snap.data!.image}"),
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
                                    snap.data!.employeeName ?? "no name",
                                    style: const TextStyle(
                                        fontSize: 15, color: Colors.white),
                                  ),
                                  Text(
                                    snap.data!.employeeCode ?? 'Admin',
                                    style: const TextStyle(
                                        fontSize: 12, color: Colors.white),
                                  ),
                                ],
                              ),
                            ],
                          ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: Appcolors.appdrawerListBgColor,
                  child: ListView.builder(
                      padding: const EdgeInsets.all(0),
                      itemCount: AppVars.appdrawerListData.length,
                      itemBuilder: (ctx, i) => AppDrawerListTile(
                            itemIndex: i,
                          )),
                ),
              ),
            ],
          ),
        ));
  }
}
