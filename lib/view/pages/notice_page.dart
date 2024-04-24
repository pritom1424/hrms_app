import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:hrms_app/utils/app_colors/app_colors.dart';
import 'package:hrms_app/utils/app_variables/app_vars.dart';
import 'package:hrms_app/utils/app_variables/image_paths.dart';
import 'package:hrms_app/view/widgets/appbar_default_widget.dart';

class NoticePage extends StatelessWidget {
  final String? title;
  const NoticePage({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (title == null)
          ? null
          : AppbarDefault(
              appbarName: title,
            ),
      body: SingleChildScrollView(
        child: Container(
          height: AppVars.screenSize.height,
          padding: EdgeInsets.only(left: 5, right: 5),
          child: Stack(children: [
            Positioned.fill(
              top: 50,
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  // height: AppVars.screenSize.height * 0.9,
                  decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromARGB(66, 173, 163, 163),
                        offset: Offset(
                          4.0,
                          -8.0,
                        ),
                        blurRadius: 10.0,
                        spreadRadius: 1.0,
                      ),
                    ],
                    /* border: const Border(
                        bottom: BorderSide(
                            width: 0.2,
                            //style: BorderStyle.none,
                            color: Colors.transparent)), */
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                      /*   bottomLeft: Radius.zero,
                        bottomRight: Radius.zero */
                    ),
                    color: Appcolors.appBgColor,
                  ),
                  padding: const EdgeInsets.only(
                      top: 50, left: 20, right: 20, bottom: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "Scheduled meeting with Managing Director Sir regarding website",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                      ),
                      const Text(
                        "Published by: HRD",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        "4-23-2024| 3:20 PM",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      ),
                      Divider(),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Text(
                          "In light of recent security concerns and our ongoing commitment to ensuring a safe and secure work environment for all employees, we are implementing several new security measures effective immediately.Enhanced Access Control: Access to the office premises will now require the use of security badges. All employees must ensure they have their badges with them at all times. Visitors will be required to sign in at the reception and will be escorted by authorized personnel.Increased Surveillance: We have installed additional security cameras in key areas of the office to monitor and enhance security measures. These cameras will be operational 24/7 and will assist in deterring any potential security threats.",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 94, 88, 88),
                              fontFamily: "Roboto"),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      Divider(),
                      RichText(
                          text: const TextSpan(children: [
                        TextSpan(
                          text: 'Regards,\n',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                        ),
                        TextSpan(
                            text: 'Md Abdul Based\n\n',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.black)),
                        TextSpan(
                            text: 'Sr Officer\n',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color.fromARGB(255, 94, 88, 88),
                            )),
                        TextSpan(
                            text: 'HR & Admin Department',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color.fromARGB(255, 94, 88, 88),
                            )),
                      ]))
                    ],
                  ),
                ),
              ),
            ),
            Positioned.fill(
              top: 20,
              child: Align(
                alignment: Alignment.topCenter,
                child: CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.white,
                  child: Image.asset(ImagePath.splashLogoPath),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
