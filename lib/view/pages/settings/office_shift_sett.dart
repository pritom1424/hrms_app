import 'package:flutter/material.dart';
import '../../../utils/app_variables/app_vars.dart';
import '../../widgets/appbar_default_widget.dart';

class OfficeShiftSettings extends StatelessWidget {
  final String? title;
  const OfficeShiftSettings({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> data = [
      {
        "id": 1,
        "shift name": "Night Shift",
      },
      {
        "id": 2,
        "shift name": "Evening Shift",
      },
      {
        "id": 3,
        "shift name": "Morning Shift",
      },
      {
        "id": 4,
        "shift name": "Evening Shift",
      },
      {
        "id": 5,
        "shift name": "Morning Shift",
      },
      {
        "id": 6,
        "shift name": "Morning Shift",
      },
      {
        "id": 7,
        "shift name": "Morning Shift",
      },
      {
        "id": 8,
        "shift name": "Day Shift",
      },
      {
        "id": 9,
        "shift name": "Morning Shift",
      },
      {
        "id": 10,
        "shift name": "Night Shift",
      },
    ];
    return Scaffold(
      appBar: (title != null)
          ? AppbarDefault(
              appbarName: title,
              isShowLeading: false,
              isShowNotification: false,
            )
          : null,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Add Shift",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Container(
              //  padding: EdgeInsets.symmetric(horizontal: 8),
              width: AppVars.screenSize.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: AppVars.screenSize.width * 0.6,
                    margin: EdgeInsets.symmetric(vertical: 10),
                    decoration: AppVars.customInputboxDecoration,
                    child: TextFormField(
                      // controller: _employeePunchIdController,
                      decoration: InputDecoration(
                        labelText: 'Shift Name',
                        contentPadding: AppVars.inputContentPadding,
                        /* prefixIcon: Icon(
                      Icons.phone,
                      color: iconColor,
                    ), */
                        border: InputBorder.none,
                        hintText: 'Enter shift name',
                        hintStyle: AppVars.customHintTextStyle,
                        labelStyle: Theme.of(context).textTheme.labelMedium,
                      ),
                      validator: (value) {
                        if (value != null && value == "") {
                          return 'Please enter leave type';
                        }
                        return null;
                      },
                    ),
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(0),
                        foregroundColor: Colors.white,
                        backgroundColor: Color(0xFF7A59AD),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                      ),
                      onPressed: () {},
                      child: Text("Submit"))
                ],
              ),
            ),
            DataTable(
                dataTextStyle: TextStyle(color: Colors.black),
                headingTextStyle:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                dividerThickness: 1,
                columnSpacing: 80,
                headingRowColor: MaterialStateColor.resolveWith(
                    (states) => Color(0xFF7A59AD)), //Colors.blue.shade400
                /*   dataRowColor:
                      MaterialStateColor.resolveWith((states) => Colors.black26), */
                sortAscending: true,
                columns: [
                  DataColumn(label: Text('ID')),
                  DataColumn(label: Center(child: Text('Shift Name'))),
                  DataColumn(
                      label: Center(
                    child: Text(
                      'Action',
                    ),
                  ))
                ],
                rows: List.generate(
                    data.length,
                    (index) => DataRow(cells: [
                          DataCell(Text('${data[index]["id"]}')),
                          DataCell(Text('${data[index]["shift name"]}')),
                          DataCell(ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.all(0),
                                    backgroundColor: Color(0xFFFD3995),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                  ),
                                  onPressed: () {},
                                  child: Text(
                                    'Delete',
                                    style: TextStyle(color: Colors.white),
                                  )) /* Row(
                              children: [
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.zero,
                                        backgroundColor: Color(0xFF1DC9B7),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5))),
                                    onPressed: () {},
                                    child: Text(
                                      'Edit',
                                      style: TextStyle(color: Colors.white),
                                    )),
                                SizedBox(
                                  width: 10,
                                ),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.all(0),
                                      backgroundColor: Color(0xFF886AB5),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(5)),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (ctx) => ShiftConfigView(
                                                    title: "Shift Config View",
                                                  )));
                                    },
                                    child: Text(
                                      'View',
                                      style: TextStyle(color: Colors.white),
                                    )),
                                SizedBox(
                                  width: 10,
                                ),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.all(0),
                                      backgroundColor: Color(0xFFFD3995),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(5)),
                                    ),
                                    onPressed: () {},
                                    child: Text(
                                      'Delete',
                                      style: TextStyle(color: Colors.white),
                                    ))
                              ],
                            ) */
                              )
                        ])))
          ],
        ),
      ),
    );
  }
}
