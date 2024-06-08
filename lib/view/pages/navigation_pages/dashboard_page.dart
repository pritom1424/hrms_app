import 'package:fl_chart/fl_chart.dart';

import 'package:flutter/material.dart';

import 'package:hrms_app/controller/dashboard_controller.dart';
import 'package:provider/provider.dart';
import '../../../utils/app_colors/app_colors.dart';
import '../../../utils/app_variables/app_vars.dart';
import '../../widgets/appbar_default_widget.dart';

class DashboardPage extends StatelessWidget {
  final String? title;
  const DashboardPage({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<DashboardController>(context, listen: false);
    final List<Map<String, dynamic>> data = [
      {"dept": "Reporter", "total": "70", "present": "65", "absent": "5"},
      {"dept": "Editor", "total": "20", "present": "20", "absent": "0"},
      {"dept": "Designer", "total": "15", "present": "15", "absent": "0"},
      {"dept": "Developer", "total": "20", "present": "19", "absent": "1"},
      {"dept": "Admin", "total": "20", "present": "15", "absent": "5"},
      {"dept": "Network", "total": "60", "present": "55", "absent": "5"},
    ];
    List<Color> availableColors() => const <Color>[
          Appcolors.contentColorPurple,
          Appcolors.contentColorBlue,
          Appcolors.contentColorGreen
        ];

    Widget getTitles(double value, TitleMeta meta) {
      const style = TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 15,
      );
      Widget text;
      switch (value.toInt()) {
        case 0:
          text = const Text('Present', style: style);
          break;
        case 1:
          text = const Text('Absent', style: style);
          break;
        case 2:
          text = const Text('On Leave', style: style);
          break;

        default:
          text = const Text('Undefined', style: style);
          break;
      }

      return SideTitleWidget(
        axisSide: meta.axisSide,
        space: 0,
        child: text,
      );
    }

    return Scaffold(
      appBar: (title != null)
          ? AppbarDefault(
              appbarName: title,
              isShowLeading: false,
              isShowNotification: false,
            )
          : null,
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: AppVars.screenSize.height * 0.3,
              padding: const EdgeInsets.all(16.0),
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 100,
                  barTouchData: BarTouchData(enabled: false),
                  titlesData: FlTitlesData(
                      leftTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false)),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                            showTitles: true,
                            /*  getTextStyles: (value) => const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ), */

                            getTitlesWidget: getTitles),
                      )),
                  borderData: FlBorderData(show: false),
                  barGroups: [
                    BarChartGroupData(
                      x: 0,
                      barRods: [
                        BarChartRodData(
                          toY: 70,
                          color: Colors.green,
                        ),
                      ],
                    ),
                    BarChartGroupData(
                      x: 1,
                      barRods: [
                        BarChartRodData(
                          toY: 5,
                          color: Colors.red,
                        ),
                      ],
                    ),
                    BarChartGroupData(
                      x: 2,
                      barRods: [
                        BarChartRodData(
                          toY: 25,
                          color: Colors.yellow,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            FutureBuilder(
              future: prov.totalEmployee(),
              builder: (ctx, snapTotal) => (snapTotal.connectionState ==
                      ConnectionState.waiting)
                  ? SizedBox.shrink()
                  : Container(
                      height: AppVars.screenSize.height * 0.2,
                      width: AppVars.screenSize.width,
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              child: ListTile(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                titleTextStyle: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                                subtitleTextStyle: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal),
                                tileColor: Appcolors.contentColorBlue,
                                title: Text(
                                  "Employee",
                                  maxLines: 1,
                                ),
                                subtitle: Text(snapTotal.data.toString()),
                              ),
                            ),
                          ),
                          FutureBuilder(
                              future: prov.totalUser(),
                              builder: (ctx, snapUser) => (snapUser
                                          .connectionState ==
                                      ConnectionState.waiting)
                                  ? SizedBox.shrink()
                                  : Expanded(
                                      child: Padding(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 5),
                                        child: ListTile(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          titleTextStyle: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                          subtitleTextStyle: const TextStyle(
                                              fontSize: 18,
                                              color: Colors.white,
                                              fontWeight: FontWeight.normal),
                                          tileColor:
                                              Appcolors.contentColorPurple,
                                          title: Text(
                                            "User",
                                            maxLines: 1,
                                          ),
                                          subtitle:
                                              Text(snapUser.data.toString()),
                                        ),
                                      ),
                                    )),
                          FutureBuilder(
                              future: prov.totalUser(),
                              builder: (ctx, snapAttend) => (snapAttend
                                          .connectionState ==
                                      ConnectionState.waiting)
                                  ? SizedBox.shrink()
                                  : Expanded(
                                      child: Padding(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 5),
                                        child: ListTile(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          titleTextStyle: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                          subtitleTextStyle: const TextStyle(
                                              fontSize: 18,
                                              color: Colors.white,
                                              fontWeight: FontWeight.normal),
                                          tileColor: Appcolors.contentColorPink,
                                          title: Text(
                                            "Attendance",
                                            maxLines: 1,
                                          ),
                                          subtitle:
                                              Text(snapAttend.data.toString()),
                                        ),
                                      ),
                                    )),
                        ],
                      ),
                    ),
            ),
            DataTable(
                dataTextStyle: TextStyle(color: Colors.black),
                headingTextStyle:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                dividerThickness: 1,
                columnSpacing: 5,
                headingRowColor: WidgetStateColor.resolveWith(
                    (states) => Color(0xFF7A59AD)), //Colors.blue.shade400
                /*   dataRowColor:
                      MaterialStateColor.resolveWith((states) => Colors.black26), */
                sortAscending: true,
                columns: [
                  DataColumn(label: Expanded(child: Text('Department'))),
                  DataColumn(
                      label: Expanded(child: Center(child: Text('Total')))),
                  DataColumn(
                      label: Expanded(
                    child: Center(
                      child: Text(
                        'Present ',
                      ),
                    ),
                  )),
                  DataColumn(
                      label: Expanded(
                    child: Center(
                      child: Text(
                        'Absent ',
                      ),
                    ),
                  ))
                ],
                rows: List.generate(
                    data.length,
                    (index) => DataRow(
                            color: WidgetStateColor.resolveWith((states) =>
                                (index % 2 == 0)
                                    ? Color.fromARGB(223, 179, 157, 219)
                                    : Colors.deepPurple.shade100),
                            cells: [
                              DataCell(Text('${data[index]["dept"]}')),
                              DataCell(Center(
                                  child: Text('${data[index]["total"]}'))),
                              DataCell(Center(
                                  child: Text('${data[index]["present"]}'))),
                              DataCell(Center(
                                  child: Text('${data[index]["absent"]}'))),
                            ])))
          ],
        ),
      ),
    );
  }
}
