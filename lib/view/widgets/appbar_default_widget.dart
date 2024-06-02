import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hrms_app/controller/employee_profile_controller.dart';
import 'package:hrms_app/utils/app_variables/api_links.dart';
import 'package:hrms_app/utils/app_variables/user_credential.dart';
import 'package:provider/provider.dart';
import '../../utils/app_variables/app_vars.dart';
import '../../utils/app_variables/image_paths.dart';
import '../pages/notice_list_page.dart';

class AppbarDefault extends StatelessWidget implements PreferredSize {
  final double? widthSize;
  final String? appbarName;
  final PreferredSizeWidget? bottomAppWidget;
  final bool? isShowLeading;
  final bool? isShowNotification;
  const AppbarDefault(
      {this.widthSize,
      super.key,
      this.appbarName,
      this.bottomAppWidget,
      this.isShowLeading,
      this.isShowNotification});

  @override
  Widget build(BuildContext context) {
    return (isShowLeading != null &&
            isShowLeading == false &&
            isShowNotification != null &&
            isShowNotification == false)
        ? AppBar(
            title: Text(appbarName ?? "Home"),
          )
        : AppBar(
            automaticallyImplyLeading: true,
            //centerTitle: true,
            titleSpacing: 0,
            leadingWidth: AppVars.screenSize.width * 0.13,
            title: Container(
              width: AppVars.screenSize.width * (widthSize ?? 1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  FittedBox(
                      child: Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: (UserCredential.userid == null)
                        ? CircleAvatar(
                            backgroundImage:
                                AssetImage(ImagePath.proPicPlaceholderPath))
                        : FutureBuilder(
                            future: Provider.of<EmployeeProfileController>(
                                    context,
                                    listen: false)
                                .getEmployeeProfile(
                                    ApiLinks.employeeProfileLink,
                                    UserCredential.userid!),
                            builder: (ctx, snap) {
                              if (!snap.hasData) {
                                return CircleAvatar(
                                  backgroundImage: AssetImage(
                                      ImagePath.proPicPlaceholderPath),
                                );
                              } else {
                                if (snap.data!.image == null) {
                                  return CircleAvatar(
                                    backgroundImage: AssetImage(
                                        ImagePath.proPicPlaceholderPath),
                                  );
                                }
                                return CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      "https://hrms.szamantech.com/storage/employee/${snap.data!.image}"),
                                );
                              }
                            }),
                  )),
                  Text(
                    appbarName ?? "Home",
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    maxLines: 1,
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
            bottom: (bottomAppWidget != null) ? bottomAppWidget : null,

            /* Image.asset(
          "assets/images/dhakaprokash_logo.png",
          fit: BoxFit.fill,
        ),
      ), */
            /* bottom: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight * 0.1),
          child: DigitalClockWidget()), */
            actions: (isShowNotification != null && isShowNotification == false)
                ? null
                : [
                    // Notification Icon
                    Badge(
                      largeSize: 13,
                      label: Text(
                        AppVars.noticeData.length.toString(),
                        style: TextStyle(fontSize: 10),
                      ),
                      offset: const Offset(-12, 6),
                      child: IconButton(
                        icon: const Icon(
                          size: 23,
                          CupertinoIcons.bell,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const NoticeListPage(
                                      title: "Notifications",
                                    )),
                          );
                          // Handle notification icon tap
                        },
                      ),
                    ),
                  ],
          );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 10);

  @override
  Widget get child => throw UnimplementedError();
}
