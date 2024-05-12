import 'dart:math';

import 'package:flutter/material.dart';
import '../../utils/app_variables/app_vars.dart';
import '../../utils/app_variables/image_paths.dart';
import '../widgets/appbar_default_widget.dart';

class EmployeeManagement extends StatelessWidget {
  final String? title;
  const EmployeeManagement({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    List<Color> bgColors = [
      Color(0xFFFFF1DB),
      Color(0xFFDCFFE2),
      Color(0xFFDAE8FF),
      Color(0xFFDCFFE2),
      Color(0xFFECE8FF),
      Color(0xFFFFDBE8),
      Color(0xFFFFF1DB),
      Color(0xFFDCFFE2),
      Color(0xFFDAE8FF),
      Color(0xFFDCFFE2),
      Color(0xFFECE8FF),
      Color(0xFFFFDBE8),
    ];
    List<String> imagePaths = [
      ImagePath.splashLogoPath,
      ImagePath.proPicPath,
      ImagePath.splashLogoPath,
      ImagePath.proPicPath,
      ImagePath.splashLogoPath,
      ImagePath.proPicPath,
      ImagePath.splashLogoPath,
      ImagePath.proPicPath,
      ImagePath.splashLogoPath,
      ImagePath.proPicPath,
      ImagePath.splashLogoPath,
      ImagePath.proPicPath
    ];
    MaterialStateColor getRandomColor() {
      // Generate random RGB values
      final random = Random();
      final int minBrightness = 200; // Minimum brightness value
      final int maxBrightness = 255; // Maximum brightness value
      final int r =
          minBrightness + random.nextInt(maxBrightness - minBrightness);
      final int g =
          minBrightness + random.nextInt(maxBrightness - minBrightness);
      final int b =
          minBrightness + random.nextInt(maxBrightness - minBrightness);

      return MaterialStateColor.resolveWith(
          (states) => Color.fromRGBO(r, g, b, 1.0));
    }

    return Scaffold(
      appBar: (title == null)
          ? null
          : AppbarDefault(
              appbarName: title,
            ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /* Row(
              children: [
                Text("Your Service",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Spacer(),
                TextButton(
                    onPressed: () {},
                    child: Text(
                      "view more",
                      style: TextStyle(color: Colors.orange),
                    ))
              ],
            ), */
            Container(
              height: AppVars.screenSize.height * 1,
              child: GridView.count(
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 3,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 2.2 / 3,
                children: List.generate(
                    imagePaths.length,
                    (index) => Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: getRandomColor(),
                          ),
                          // Colors.white,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: bgColors[index],
                                child: Image.asset(
                                  imagePaths[index],
                                  fit: BoxFit.fill,
                                  // ImagePath.splashLogoPath,
                                  width: 35,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Employee Management",
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
