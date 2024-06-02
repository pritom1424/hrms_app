import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../../utils/app_colors/app_colors.dart';
import '../../../utils/app_variables/app_vars.dart';
import '../../widgets/appbar_default_widget.dart';

class DashboardPage2 extends StatelessWidget {
  final String? title;
  const DashboardPage2({super.key, this.title});

  @override
  Widget build(BuildContext context) {
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
    final Color barBackgroundColor =
        Appcolors.contentColorWhite.withOpacity(0.3);
    final Color barColor = Appcolors.contentColorWhite;
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
            Container(
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
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                        subtitleTextStyle: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.normal),
                        tileColor: Appcolors.contentColorBlue,
                        title: Text("total"),
                        subtitle: Text("100"),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        titleTextStyle: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                        subtitleTextStyle: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.normal),
                        tileColor: Appcolors.contentColorPurple,
                        title: Text("male"),
                        subtitle: Text("75"),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        titleTextStyle: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                        subtitleTextStyle: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.normal),
                        tileColor: Appcolors.contentColorPink,
                        title: Text("female"),
                        subtitle: Text("25"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            DataTable(
                dataTextStyle: TextStyle(color: Colors.black),
                headingTextStyle:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                dividerThickness: 1,
                columnSpacing: 5,
                headingRowColor: MaterialStateColor.resolveWith(
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
                            color: MaterialStateColor.resolveWith((states) =>
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
