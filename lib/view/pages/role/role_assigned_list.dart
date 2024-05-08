import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hrms_app/utils/app_variables/app_vars.dart';
import 'package:hrms_app/view/widgets/appbar_default_widget.dart';
import '../../widgets/dashboard_page/search_widget.dart';

class RoleAssignedList extends StatelessWidget {
  final String? title;
  const RoleAssignedList({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    //font related
    double smallLabelFontSize = 12;
    double labelFontSize = 18;
    double mediumLabelFontSize = 15;
    Color labelFontColor = Colors.grey;
    EdgeInsetsGeometry contentPadding =
        const EdgeInsets.symmetric(horizontal: 20);
    BoxDecoration boxDecoration = BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.3),
          spreadRadius: 2,
          blurRadius: 5,
          offset: Offset(0, 3),
        ),
      ],
    );
    TextStyle hintTextStyle =
        TextStyle(color: Colors.grey.withOpacity(0.5), fontSize: 15);
    final List<Map<String, dynamic>> data = [
      {
        "id": 1,
        "Role name": "Admin",
        "Created At": "07-May-2024| 03:25 PM",
        "Updated At": "07-May-2024| 03:25 PM",
      },
      {
        "id": 2,
        "Role name": "Sub Admin",
        "Created At": "07-May-2024| 03:25 PM",
        "Updated At": "07-May-2024| 03:25 PM",
      },
      {
        "id": 3,
        "Role name": "Admin",
        "Created At": "07-May-2024| 03:25 PM",
        "Updated At": "07-May-2024| 03:25 PM",
      },
      {
        "id": 4,
        "Role name": "Sub Admin",
        "Created At": "07-May-2024| 03:25 PM",
        "Updated At": "07-May-2024| 03:25 PM",
      },
      {
        "id": 5,
        "Role name": "Admin",
        "Created At": "07-May-2024| 03:25 PM",
        "Updated At": "07-May-2024| 03:25 PM",
      },
      {
        "id": 6,
        "Role name": "Sub Admin",
        "Created At": "07-May-2024| 03:25 PM",
        "Updated At": "07-May-2024| 03:25 PM",
      },
    ];
    return Scaffold(
      appBar: (title != null)
          ? AppbarDefault(
              appbarName: title,
            )
          : null,
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                "Role Create",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              width: AppVars.screenSize.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      width: AppVars.screenSize.width * 0.9,
                      margin: EdgeInsets.symmetric(vertical: 10),
                      decoration: boxDecoration,
                      child: SearcWidget()),
                ],
              ),
            ),
            Container(
              height: AppVars.screenSize.height * 0.7,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DataTable(
                        dataTextStyle: TextStyle(color: Colors.black),
                        headingTextStyle: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                        dividerThickness: 1,
                        columnSpacing: 10,
                        headingRowColor: MaterialStateColor.resolveWith(
                            (states) =>
                                Color(0xFF7A59AD)), //Colors.blue.shade400
                        /*   dataRowColor:
                            MaterialStateColor.resolveWith((states) => Colors.black26), */
                        sortAscending: true,
                        columns: [
                          DataColumn(label: Text('ID')),
                          DataColumn(
                              label: Expanded(
                                  child: Center(child: Text('Role name')))),
                          DataColumn(
                              label: Expanded(
                            child: Center(
                              child: Text(
                                'Created At',
                              ),
                            ),
                          )),
                          DataColumn(
                              label: Expanded(
                            child: Center(
                              child: Text(
                                'Updated At',
                              ),
                            ),
                          )),
                          DataColumn(
                              label: Expanded(
                            child: Center(
                              child: Text(
                                'Action',
                              ),
                            ),
                          ))
                        ],
                        rows: List.generate(
                            data.length,
                            (index) => DataRow(cells: [
                                  DataCell(Text('${data[index]["id"]}')),
                                  DataCell(Text('${data[index]["Role name"]}')),
                                  DataCell(
                                      Text('${data[index]["Created At"]}')),
                                  DataCell(
                                      Text('${data[index]["Updated At"]}')),
                                  DataCell(Row(
                                    children: [
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              padding: EdgeInsets.zero,
                                              backgroundColor:
                                                  Color(0xFF1DC9B7),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5))),
                                          onPressed: () {},
                                          child: Text(
                                            'Edit',
                                            style:
                                                TextStyle(color: Colors.white),
                                          )),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            padding: EdgeInsets.all(0),
                                            backgroundColor: Color(0xFF886AB5),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                          ),
                                          onPressed: () {},
                                          child: Text(
                                            'Assign',
                                            style:
                                                TextStyle(color: Colors.white),
                                          )),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            padding: EdgeInsets.all(0),
                                            backgroundColor: Color(0xFFFD3995),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                          ),
                                          onPressed: () {},
                                          child: Text(
                                            'Delete',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ))
                                    ],
                                  ))
                                ])))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
