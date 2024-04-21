import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hrms_app/utils/app_colors/app_colors.dart';
import 'package:hrms_app/utils/app_variables/app_vars.dart';

class AppbarDefault extends StatelessWidget implements PreferredSize {
  final double? widthSize;
  const AppbarDefault({this.widthSize, super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Container(
          width: AppVars.screenSize.width * (widthSize ?? 0.45),
          child: Text("Hrms")),

      /* Image.asset(
          "assets/images/dhakaprokash_logo.png",
          fit: BoxFit.fill,
        ),
      ), */
      /* bottom: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight * 0.1),
          child: DigitalClockWidget()), */
      actions: [
        // Notification Icon
        Badge(
          largeSize: 13,
          label: const Text(
            "0",
            style: TextStyle(fontSize: 10),
          ),
          offset: const Offset(-12, 6),
          child: IconButton(
            icon: const Icon(
              size: 23,
              CupertinoIcons.bell,
            ),
            onPressed: () {
              // Handle notification icon tap
            },
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget get child => throw UnimplementedError();
}
