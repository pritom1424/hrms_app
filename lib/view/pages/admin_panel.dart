import 'dart:ffi';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../utils/app_variables/image_paths.dart';

import '../../utils/app_variables/app_vars.dart';
import '../widgets/appbar_default_widget.dart';

class AdminPanel extends StatefulWidget {
  final String? title;
  const AdminPanel({super.key, this.title});

  @override
  State<AdminPanel> createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Color> cardColors = [
      Color(0xFFD8FFD4),
      Color(0xFFFFCFDA),
      Color(0xFFCFEFFF),
      Color(0xFFFFF5CF)
    ];
    final employeeData = {
      'total employee': 670,
      'total present': 600,
      'total absent': 70,
      'present ratio': "${(600 / 670 * 100).toStringAsFixed(2)} %"
    };

    var ratio = (employeeData['total present'] as int) /
        (employeeData['total employee'] as int);
    List<Color> pieColors = [
      Color(0xFF4F14DE),
      Colors.red //Color(0xFFB378FF),
      //Color(0xFFF9BEFF)
    ];
    List<PieChartSectionData> showingSections() {
      return List.generate(2, (i) {
        // final isTouched = i == touchedIndex;
        const double fontSize = 16; //isTouched ? 25.0 : 16.0;
        const double radius = 40; //isTouched ? 60.0 : 50.0;
        const Color titleTextColor = Colors.white;
        const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
        switch (i) {
          case 0:
            return PieChartSectionData(
              color: pieColors[0], //AppColors.contentColorBlue,
              value: (ratio * 100), //employeeData['present ratio'] as double,
              title:
                  "${(ratio * 100).toStringAsFixed(0)} %", //"${employeeData['present ratio'] as double}%", //'40%',
              radius: radius,
              titleStyle: const TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: titleTextColor, //AppColors.mainTextColor1,
                shadows: shadows,
              ),
            );
          case 1:
            return PieChartSectionData(
              color: pieColors[1], //AppColors.contentColorYellow,
              value: 100 - ratio * 100,
              title: "${(100 - ratio * 100).toStringAsFixed(0)} %",
              radius: radius,
              titleStyle: const TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: titleTextColor, //AppColors.mainTextColor1,
                shadows: shadows,
              ),
            );
          /*   case 2:
            return PieChartSectionData(
              color: pieColors[2], //AppColors.contentColorPurple,
              value: 100-ratio*100,
              title: "${100-ratio*100} %",
              radius: radius,
              titleStyle: const TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: titleTextColor, //AppColors.mainTextColor1,
                shadows: shadows,
              ),
            ); */
          /* case 3:
            return PieChartSectionData(
              color: AppColors.contentColorGreen,
              value: 15,
              title: '15%',
              radius: radius,
              titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: AppColors.mainTextColor1,
                shadows: shadows,
              ),
            ); */
          default:
            throw Error();
        }
      });
    }

    Widget getListTile(String title, String subtitle) {
      return Container(
        height: AppVars.screenSize.height * 0.15,
        width: AppVars.screenSize.width * 0.9,
        margin: EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(66, 173, 163, 163),
                /*  offset: Offset(
                  4.0,
                  4.0,
                ), */
                blurRadius: 5,
                spreadRadius: 1,
              ),
            ],
            color: Color.fromARGB(255, 240, 228, 172), //Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 0.5, color: Colors.white)),
        padding: EdgeInsets.all(5),
        child: ListTile(
          onTap: () => () {},
          leading: CircleAvatar(
            radius: 25,
            backgroundImage: AssetImage(ImagePath.splashLogoPath),
          ),
          title: Text(
            title,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          subtitle: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Divider(
                thickness: 2.2,
                color: Colors.black12,
              ),
              Text(
                subtitle,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
              ),
            ],
          ),
          titleTextStyle: Theme.of(context).textTheme.headlineMedium,
        ),
      );
    }

    return Scaffold(
      appBar: (widget.title == null)
          ? null
          : AppbarDefault(
              appbarName: widget.title,
            ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                "Recent News",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              height: AppVars.screenSize.height * 0.15,
              width: AppVars.screenSize.width,
              child: RawScrollbar(
                padding: EdgeInsets.symmetric(horizontal: 5),
                controller: _scrollController,
                thumbColor: Colors.black, //Colors.blueAccent,
                trackColor: Colors.black, //Colors.blueAccent,
                radius: Radius.circular(10),
                thickness: 4,
                thumbVisibility: true,
                child: ListView.builder(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  itemCount: AppVars.noticeData.length,
                  itemBuilder: (ctx, index) => getListTile(
                      AppVars.noticeData[index].entries.toList()[0].value,
                      AppVars.noticeData[index].entries.toList()[1].value),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                "Statistics",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              height: AppVars.screenSize.height * 0.22,
              child: GridView.count(
                childAspectRatio: 5 / 2,
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                physics: NeverScrollableScrollPhysics(),
                children: List.generate(
                  employeeData.length,
                  (index) => ListTile(
                    tileColor: cardColors[index], //Colors.white,
                    titleTextStyle: TextStyle(color: Colors.grey, fontSize: 12),
                    subtitleTextStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    title: Text(employeeData.entries
                            .toList()[index]
                            .key //"Total Employee",
                        ),
                    subtitle: Row(
                      children: [
                        Text(employeeData.entries
                            .toList()[index]
                            .value
                            .toString()), //"670"
                        /* SizedBox(
                          width: 10,
                        ), */
                        /*  Icon(Icons.arrow_upward, size: 12, color: Colors.green),
                        Text(
                          "5.2%",
                          style: TextStyle(fontSize: 12, color: Colors.green),
                        ) */
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Employee Status",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      IconButton(onPressed: () {}, icon: Icon(Icons.more_horiz))
                    ],
                  ),
                  Container(
                    height: AppVars.screenSize.height * 0.25,
                    child: PieChart(
                      PieChartData(
                        /*  pieTouchData: PieTouchData(
                          touchCallback: (FlTouchEvent event, pieTouchResponse) {
                             setState(() {
                          if (!event.isInterestedForInteractions ||
                              pieTouchResponse == null ||
                              pieTouchResponse.touchedSection == null) {
                            touchedIndex = -1;
                            return;
                          }
                          touchedIndex = pieTouchResponse
                              .touchedSection!.touchedSectionIndex;
                        });
                          },
                        ), */
                        borderData: FlBorderData(
                          show: false,
                        ),
                        sectionsSpace: 0,
                        centerSpaceRadius: 45,
                        sections: showingSections(),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        /*  Icon(
                          Icons.square,
                          size: 12,
                          color: pieColors[0],
                        ),
                        Text(
                          "Total Employee",
                          style: TextStyle(fontSize: 12),
                        ), */
                        Icon(
                          Icons.square,
                          size: 12,
                          color: pieColors[0],
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Total present",
                          style: TextStyle(fontSize: 12),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Icon(
                          Icons.square,
                          size: 12,
                          color: pieColors[1],
                        ),
                        Text(
                          "Total Absent",
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Employees",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  TextButton(onPressed: () {}, child: Text("View all"))
                ],
              ),
            ),
            Container(
              height: AppVars.screenSize.height * 0.2,
              color: Colors.white,
              child: ListView.builder(
                  itemCount: 7,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (ctx, i) => Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 40,
                              backgroundColor: Colors.black,
                              backgroundImage: AssetImage(ImagePath.proPicPath),
                              /* child: Image.asset(
                                ImagePath.proPicPath,
                                height: 50,
                                fit: BoxFit.cover,
                              ), */
                              // backgroundImage: AssetImage(ImagePath.proPicPath),
                            ),
                            Text(
                              'Mark',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'UX Designer',
                              style: TextStyle(fontSize: 15),
                            )
                          ],
                        ),
                      )),
            )
          ],
        ),
      ),
    );
  }
}
