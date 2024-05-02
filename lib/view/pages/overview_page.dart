import 'package:flutter/material.dart';
import 'package:hrms_app/utils/app_variables/app_vars.dart';
import 'package:hrms_app/utils/app_variables/image_paths.dart';
import 'package:hrms_app/view/widgets/appbar_default_widget.dart';

class OverviewPage extends StatelessWidget {
  final String? title;
  const OverviewPage({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    List<Color> bgColors = [
      Color(0xFFFFF1DB),
      Color(0xFFDCFFE2),
      Color(0xFFDAE8FF),
      Color(0xFFDCFFE2),
      Color(0xFFECE8FF),
      Color(0xFFFFDBE8),
    ];
    List<Color> cardColors = [
      Color(0xFFD8FFD4),
      Color(0xFFFFCFDA),
      Color(0xFFCFEFFF),
      Color(0xFFFFF5CF)
    ];
    List<String> imagePaths = [
      ImagePath.splashLogoPath,
      ImagePath.proPicPath,
      ImagePath.splashLogoPath,
      ImagePath.proPicPath,
      ImagePath.splashLogoPath,
      ImagePath.proPicPath
    ];
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
            Text(
              "Overview",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Container(
              height: AppVars.screenSize.height * 0.22,
              padding: EdgeInsets.symmetric(vertical: 5),
              child: GridView.count(
                childAspectRatio: 5 / 2,
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                physics: NeverScrollableScrollPhysics(),
                children: List.generate(
                  4,
                  (index) => ListTile(
                    tileColor: cardColors[index],
                    titleTextStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                    subtitleTextStyle: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        color: Colors.black),
                    title: Text(
                      "670",
                      textAlign: TextAlign.center,
                    ),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Total Employee",
                          // textAlign: TextAlign.center,
                        ),
                        /*  SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.arrow_upward,
                          size: 12,
                        ),
                        Text(
                          "5.2%",
                          style: TextStyle(fontSize: 12),
                        ) */
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Row(
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
            ),
            Container(
              height: AppVars.screenSize.height * 0.5,
              child: GridView.count(
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 3,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                childAspectRatio: 2 / 3,
                children: List.generate(
                    6,
                    (index) => Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                          ),
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
