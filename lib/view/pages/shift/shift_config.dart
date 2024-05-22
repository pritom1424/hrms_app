import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hrms_app/controller/employee_shift_controller.dart';
import 'package:hrms_app/utils/app_variables/api_links.dart';
import 'package:provider/provider.dart';

import '../../../utils/app_variables/app_vars.dart';
import '../../../utils/enums/enums.dart';
import 'shift_config_view.dart';
import '../../widgets/appbar_default_widget.dart';
import 'package:intl/intl.dart';

class ShiftConfig extends StatefulWidget {
  final String? title;
  const ShiftConfig({super.key, this.title});

  @override
  State<ShiftConfig> createState() => _ShiftConfigState();
}

class _ShiftConfigState extends State<ShiftConfig> {
  final TextEditingController _gracePeriodController = TextEditingController();

  EdgeInsetsGeometry contentPadding =
      const EdgeInsets.symmetric(horizontal: 20);
  BorderRadius borderRadius = const BorderRadius.all(Radius.circular(10));
  Color borderColor = const Color.fromARGB(255, 189, 183, 183);
  double borderWidth = 1;
  double marginHeight = 5;
  double leftPadding = 20;
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
  //font related
  double smallLabelFontSize = 12;
  double labelFontSize = 18;
  double mediumLabelFontSize = 15;
  Color labelFontColor = Colors.grey;

  TextStyle hintTextStyle = TextStyle(color: Colors.grey.withOpacity(0.5));

  Color iconColor = Colors.grey;

  // action button
  Color actionButtonBgColor = const Color.fromARGB(255, 68, 156, 204);
  Color actionButtonFgColor = Colors.white;

//enums
  Shift? _selectedShift;
  TimeOfDay _selectedStartTime = TimeOfDay.now();
  TimeOfDay _selectedEndTime = TimeOfDay.now();

  TimeOfDay _selectedBreakStartTime = TimeOfDay.now();
  TimeOfDay _selectedBreakEndTime = TimeOfDay.now();

  Future<void> _selectTime(BuildContext context, bool isEnd) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: (isEnd) ? _selectedEndTime : _selectedStartTime,
    );
    if (picked != null) {
      if (isEnd) {
        if (picked != _selectedEndTime) {
          setState(() {
            _selectedEndTime = picked;
          });
        }
      } else {
        if (picked != _selectedStartTime) {
          setState(() {
            _selectedStartTime = picked;
          });
        }
      }
    }
  }

  Future<void> _selectBreakTime(BuildContext context, bool isEnd) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: (isEnd) ? _selectedBreakEndTime : _selectedBreakStartTime,
    );
    if (picked != null) {
      if (isEnd) {
        if (picked != _selectedBreakEndTime) {
          setState(() {
            _selectedBreakEndTime = picked;
          });
        }
      } else {
        if (picked != _selectedBreakStartTime) {
          setState(() {
            _selectedBreakStartTime = picked;
          });
        }
      }
    }
  }

  @override
  void dispose() {
    _gracePeriodController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EmployeeShiftController>(context);
    var now = DateTime.now();
    return Scaffold(
      appBar: (widget.title != null)
          ? AppbarDefault(
              appbarName: widget.title,
              isShowLeading: false,
              isShowNotification: false,
            )
          : null,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Shift",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            Container(
              padding: EdgeInsets.only(left: leftPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      "Office Shift",
                      style: TextStyle(
                          fontSize: mediumLabelFontSize,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  DropdownButtonHideUnderline(
                    child: Expanded(
                      flex: 2,
                      child: Container(
                        //width: AppVars.screenSize.width * 0.55,
                        padding: contentPadding,
                        decoration: AppVars.customInputboxDecoration,
                        // BoxDecoration(border: Border.all(width: 0.4)),
                        margin: EdgeInsets.symmetric(vertical: marginHeight),
                        child: DropdownButton(
                            hint: Text(
                              "Choose Shift",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                  fontSize: mediumLabelFontSize,
                                  color: Colors.black54),
                            ),
                            value: _selectedShift,
                            items: Shift.values
                                .map(
                                  (shift) => DropdownMenuItem(
                                    value: shift,
                                    child: Text(
                                      shift.name.toUpperCase(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall,
                                    ),
                                  ),
                                )
                                .toList(),
                            onChanged: (val) {
                              if (val == null) {
                                return;
                              }
                              setState(() {
                                _selectedShift = val;
                              });
                            }),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
                margin: EdgeInsets.symmetric(vertical: marginHeight),
                padding: EdgeInsets.only(left: leftPadding),
                decoration: boxDecoration,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Start Time: ${DateFormat.jm().format(DateTime(now.year, now.month, now.day, _selectedStartTime.hour, _selectedStartTime.minute))}', //${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day}
                      style: TextStyle(fontSize: mediumLabelFontSize),
                    ),
                    SizedBox(width: 20),
                    TextButton(
                      onPressed: () => _selectTime(context, false),
                      child: Text(
                        'Select Time',
                        style: TextStyle(fontSize: mediumLabelFontSize),
                      ),
                    ),
                  ],
                )),
            Container(
                margin: EdgeInsets.symmetric(vertical: marginHeight),
                padding: EdgeInsets.only(left: leftPadding),
                decoration: boxDecoration,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'End Time: ${DateFormat.jm().format(DateTime(now.year, now.month, now.day, _selectedEndTime.hour, _selectedEndTime.minute))}', //${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day}
                      style: TextStyle(fontSize: mediumLabelFontSize),
                    ),
                    SizedBox(width: 20),
                    TextButton(
                      onPressed: () => _selectTime(context, true),
                      child: Text(
                        'Select Time',
                        style: TextStyle(fontSize: mediumLabelFontSize),
                      ),
                    ),
                  ],
                )),
            Container(
              padding: EdgeInsets.only(left: leftPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Default Shift"),
                  Checkbox(
                    value: false,
                    onChanged: (val) {},
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: marginHeight),
              decoration: boxDecoration,
              child: TextFormField(
                //    controller: _employeeIdController,
                decoration: InputDecoration(
                  labelText: 'Grace Period (min)',
                  contentPadding: contentPadding,

                  /*  prefixIcon: Icon(
                Icons.phone,
                color: iconColor,
              ), */
                  border: InputBorder.none,
                  hintText: 'Grace Period (min)',
                  hintStyle: AppVars.customHintTextStyle,
                  labelStyle: TextStyle(
                      fontSize: mediumLabelFontSize, color: labelFontColor),
                ),
                validator: (value) {
                  if (value != null && value == "") {
                    return 'Please enter leave type';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Break Time",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            Container(
                margin: EdgeInsets.symmetric(vertical: marginHeight),
                padding: EdgeInsets.only(left: leftPadding),
                decoration: boxDecoration,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Start Time: ${DateFormat.jm().format(DateTime(now.year, now.month, now.day, _selectedStartTime.hour, _selectedStartTime.minute))}', //${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day}
                      style: TextStyle(fontSize: mediumLabelFontSize),
                    ),
                    SizedBox(width: 20),
                    TextButton(
                      onPressed: () => _selectBreakTime(context, false),
                      child: Text(
                        'Select Time',
                        style: TextStyle(fontSize: mediumLabelFontSize),
                      ),
                    ),
                  ],
                )),
            Container(
                margin: EdgeInsets.symmetric(vertical: marginHeight),
                padding: EdgeInsets.only(left: leftPadding),
                decoration: boxDecoration,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'End Time: ${DateFormat.jm().format(DateTime(now.year, now.month, now.day, _selectedEndTime.hour, _selectedEndTime.minute))}', //${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day}
                      style: TextStyle(fontSize: mediumLabelFontSize),
                    ),
                    SizedBox(width: 20),
                    TextButton(
                      onPressed: () => _selectBreakTime(context, true),
                      child: Text(
                        'Select Time',
                        style: TextStyle(fontSize: mediumLabelFontSize),
                      ),
                    ),
                  ],
                )),
            Container(
                margin: EdgeInsets.symmetric(vertical: marginHeight),
                padding: EdgeInsets.only(left: leftPadding, right: 10),
                decoration: boxDecoration,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total Working Hour",
                      style: TextStyle(fontSize: mediumLabelFontSize),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      "7 hours 30 minutes",
                      style: TextStyle(fontSize: mediumLabelFontSize),
                    ),
                  ],
                )),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  shape: RoundedRectangleBorder(
                    borderRadius: borderRadius,
                  ),
                  backgroundColor: actionButtonBgColor,
                  foregroundColor: actionButtonFgColor),
              onPressed: () {
                /* if (_formPersonalInfoKey.currentState == null) {
                return;
              }
              if (_formPersonalInfoKey.currentState!.validate()) {
                _formPersonalInfoKey.currentState!.save();
                // Do something with the validated data
                // print('Name: $_name');
              } */

                // Handle apply button press
                // You can access the values using controller.text for each field
              },
              child: const Text(
                'Save',
                style: TextStyle(fontSize: 25),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            FutureBuilder(
              future:
                  provider.loadEmployeeList(ApiLinks.employeeShiftIndexLink),
              builder: (ctx, snap) => (snap.connectionState ==
                      ConnectionState.waiting)
                  ? SizedBox(
                      height: AppVars.screenSize.height * 0.2,
                      child: Center(child: CircularProgressIndicator()))
                  : (!snap.hasData)
                      ? Text("No data available")
                      : DataTable(
                          headingRowHeight: AppVars.screenSize.height * 0.05,
                          dataTextStyle: TextStyle(color: Colors.black),
                          headingTextStyle: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                          dividerThickness: 1,
                          columnSpacing: 5,
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
                                    child: Center(child: Text('Shift')))),
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
                              snap.data!.data.length,
                              (index) => DataRow(cells: [
                                    DataCell(
                                        Text('${snap.data!.data[index].id}')),
                                    DataCell(Text(
                                        '${snap.data!.data[index].shiftName}')),
                                    DataCell(Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(6),
                                          child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  padding: EdgeInsets.all(0),
                                                  backgroundColor:
                                                      Color(0xFF1DC9B7),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5))),
                                              onPressed: () {},
                                              child: Text(
                                                'Edit',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )),
                                        ),
                                        SizedBox(
                                          width: 2,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(6),
                                          child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                padding: EdgeInsets.all(0),
                                                backgroundColor:
                                                    Color(0xFF886AB5),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                              ),
                                              onPressed: () {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (ctx) =>
                                                            ShiftConfigView(
                                                              title:
                                                                  "Shift Config View",
                                                              id: snap
                                                                  .data!
                                                                  .data[index]
                                                                  .id,
                                                            )));
                                              },
                                              child: Text(
                                                'View',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )),
                                        ),
                                        SizedBox(
                                          width: 2,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(6),
                                          child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                padding: EdgeInsets.all(0),
                                                backgroundColor:
                                                    Color(0xFFFD3995),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                              ),
                                              onPressed: () {
                                                // _deleteUser(index);
                                                if (snap.data!.data[index].id ==
                                                    null) {
                                                  return;
                                                }
                                                provider.deleteShiftById(
                                                    ApiLinks.shiftDeleteLink,
                                                    snap.data!.data[index].id!);
                                              },
                                              child: Text(
                                                'Delete',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )),
                                        )
                                      ],
                                    ))
                                  ]))),
            )
          ],
        ),
      ),
    );
  }
}
