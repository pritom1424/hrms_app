import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hrms_app/utils/app_colors/app_colors.dart';
import '../../../utils/app_variables/app_vars.dart';
import '../../widgets/appbar_default_widget.dart';
import '../../widgets/dashboard_page/search_widget.dart';

class RoleAssignedList extends StatefulWidget {
  final String? title;
  const RoleAssignedList({super.key, this.title});

  @override
  State<RoleAssignedList> createState() => _RoleAssignedListState();
}

class _RoleAssignedListState extends State<RoleAssignedList> {
  final _scController = ScrollController();

  double smallLabelFontSize = 12;
  double labelFontSize = 18;
  double mediumLabelFontSize = 15;
  Color labelFontColor = Colors.grey;

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

  @override
  void dispose() {
    _scController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //font related

    return Scaffold(
      appBar: (widget.title != null)
          ? AppbarDefault(
              appbarName: widget.title,
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
                      decoration: AppVars.customInputboxDecoration,
                      child: SearcWidget()),
                ],
              ),
            ),
            Container(
              child: RawScrollbar(
                controller: _scController,
                thumbColor: Colors.blueAccent,
                thumbVisibility: true,
                child: SingleChildScrollView(
                  controller: _scController,
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      DataTable(
                          dataTextStyle: TextStyle(color: Colors.black),
                          headingTextStyle: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                          dividerThickness: 1,
                          columnSpacing: 10,
                          headingRowColor: MaterialStateColor.resolveWith(
                              (states) => Appcolors
                                  .dataTableHeadingColor), //Colors.blue.shade400
                          /*   dataRowColor:
                              MaterialStateColor.resolveWith((states) => Colors.black26), */
                          sortAscending: true,
                          columns: const [
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
                                    DataCell(
                                        Text('${data[index]["Role name"]}')),
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
                                                    Appcolors.editButtonColor,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5))),
                                            onPressed: () {},
                                            child: const Text(
                                              'Edit',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            )),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              padding: EdgeInsets.all(0),
                                              backgroundColor:
                                                  Appcolors.assignButtonColor,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                            ),
                                            onPressed: () {},
                                            child: const Text(
                                              'Assign',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            )),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              padding: EdgeInsets.all(0),
                                              backgroundColor:
                                                  Appcolors.deleteButtonColor,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                            ),
                                            onPressed: () {},
                                            child: const Text(
                                              'Delete',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ))
                                      ],
                                    ))
                                  ])))
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
