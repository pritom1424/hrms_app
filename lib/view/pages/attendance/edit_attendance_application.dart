import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hrms_app/controller/employee_attendance_controller.dart';

import 'package:hrms_app/model/hrms_attendance_post_model.dart';

import 'package:hrms_app/model/hrms_employee_attendance_model.dart';

import 'package:hrms_app/utils/app_methods/app_methods.dart';
import 'package:hrms_app/utils/app_variables/api_links.dart';
import 'package:hrms_app/utils/app_variables/app_strings.dart';
import 'package:hrms_app/utils/app_variables/app_vars.dart';
import 'package:hrms_app/view/widgets/appbar_default_widget.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EditAttendanceForm extends StatefulWidget {
  final int? id;
  final int? employeeId;
  final String? title;
  const EditAttendanceForm({super.key, this.id, this.title, this.employeeId});

  @override
  State<EditAttendanceForm> createState() => _EditShiftConfigFormState();
}

class _EditShiftConfigFormState extends State<EditAttendanceForm> {
  final _formInfoKey = GlobalKey<FormState>();
  final TextEditingController _employeeCodeController = TextEditingController();
  final TextEditingController _employeeNameController = TextEditingController();
  final TextEditingController _employeeShiftDurationController =
      TextEditingController();
  final TextEditingController _totalWorkingHourController =
      TextEditingController();
  bool isInit = false;
  bool? didPresent;
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

  TimeOfDay _selectedInTime = TimeOfDay.now();
  TimeOfDay _selectedOutTime = TimeOfDay.now();

  TimeOfDay _selectedLateTime = TimeOfDay.now();
  TimeOfDay _selectedOverTime = TimeOfDay.now();

  DateTime _selectedAttendanceTime = DateTime.now();

  String _employeeCode = "";
  String _employeeName = "";

  //String _totalWorkingHour = "";

  /*  String calculateTotalWorkingHours(
      TimeOfDay shiftStartTime,
      TimeOfDay shiftEndTime,
      TimeOfDay breakStartTime,
      TimeOfDay breakEndTime) {
    // Convert TimeOfDay to DateTime
    final now = DateTime.now();
    DateTime startTime =
        DateTime(now.year, 1, 1, shiftStartTime.hour, shiftStartTime.minute);
    DateTime endTime =
        DateTime(now.year, 1, 1, shiftEndTime.hour, shiftEndTime.minute);
    DateTime breakStart =
        DateTime(now.year, 1, 1, breakStartTime.hour, breakStartTime.minute);
    DateTime breakEnd =
        DateTime(now.year, 1, 1, breakEndTime.hour, breakEndTime.minute);

    // Calculate total working minutes
    Duration totalShiftDuration = endTime.difference(startTime);
    Duration breakDuration = breakEnd.difference(breakStart);
    Duration totalWorkingDuration = totalShiftDuration - breakDuration;

    // Calculate total working hours and minutes
    int totalHours = totalWorkingDuration.inHours;
    int totalMinutes = totalWorkingDuration.inMinutes.remainder(60);

    // Format the result into string
    String result = "$totalHours hours $totalMinutes minutes";
    return result;
  } */

  Future<void> _selectTime(BuildContext context, bool isEnd) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: (isEnd) ? _selectedOutTime : _selectedInTime,
    );
    if (picked != null) {
      if (isEnd) {
        if (picked != _selectedOutTime) {
          setState(() {
            _selectedInTime = picked;
          });
        }
      } else {
        if (picked != _selectedInTime) {
          setState(() {
            _selectedInTime = picked;
          });
        }
      }
    }
  }

  Future<void> _selectDate(BuildContext context,
      {DateTime? fDate, DateTime? lDate}) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedAttendanceTime,
      firstDate: (fDate != null) ? fDate : DateTime(2015, 8),
      lastDate: (lDate != null) ? lDate : DateTime(2101),
    );
    if (picked != null && picked != _selectedAttendanceTime)
      setState(() {
        _selectedAttendanceTime = picked;
      });
  }

  Future<void> selectLateTime(BuildContext contex) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedLateTime,
    );
    if (picked != null) {
      if (picked != _selectedLateTime) {
        setState(() {
          _selectedLateTime = picked;
        });
      }
    }
  }

  Future<void> selectOverTime(BuildContext contex) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedOverTime,
    );
    if (picked != null) {
      if (picked != _selectedOverTime) {
        setState(() {
          _selectedOverTime = picked;
        });
      }
    }
  }

  void initEditAttendanceForm(HrmsEmployeeAttendanceModel hrmsAttendanceModel) {
    _employeeCode = hrmsAttendanceModel.employee?.employeeCode ?? "";
    _employeeName = hrmsAttendanceModel.employee?.employeeName ?? "";
    _employeeCodeController.text =
        hrmsAttendanceModel.employee?.employeeCode ?? "";
    _employeeNameController.text =
        hrmsAttendanceModel.employee?.employeeName ?? "";
    _employeeShiftDurationController.text =
        hrmsAttendanceModel.shiftDuration ?? "";
    _totalWorkingHourController.text =
        hrmsAttendanceModel.totalWorkingHour ?? "";

    (hrmsAttendanceModel.status == 1) ? didPresent = true : didPresent = false;

    print("_selectedStartTime: }");
    /*   _selectedStartTime =
        AppMethods().dateStringToTimeOfDay(hrmsShiftModel.shiftStartTime); */
    final format = DateFormat("HH:mm"); //"6:00 AM"
    _selectedInTime =
        TimeOfDay.fromDateTime(format.parse(hrmsAttendanceModel.inTime!));
    _selectedOutTime =
        TimeOfDay.fromDateTime(format.parse(hrmsAttendanceModel.outTime!));
    _selectedLateTime =
        TimeOfDay.fromDateTime(format.parse(hrmsAttendanceModel.lateTime!));
    _selectedOverTime =
        TimeOfDay.fromDateTime(format.parse(hrmsAttendanceModel.overTime!));
    _selectedAttendanceTime = hrmsAttendanceModel.attendanceDate!;
  }

  @override
  void initState() {
    isInit = true;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    final provider =
        Provider.of<EmployeeAttendanceController>(context, listen: false);

    return Scaffold(
        appBar: (widget.title == null)
            ? null
            : AppbarDefault(
                appbarName: widget.title,
                isShowLeading: false,
                isShowNotification: false,
              ),
        body: Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            height: AppVars.screenSize.height * 1,
            child: (widget.id == null)
                ? Container(
                    height: AppVars.screenSize.height,
                    child: const Center(
                      child: Text("No Id found"),
                    ),
                  )
                : (isInit)
                    ? SingleChildScrollView(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                        child: FutureBuilder(
                            future: provider.showEmployeeAttendance(
                                ApiLinks.employeeAttendanceLink, widget.id!),
                            builder: (ctx, snap) {
                              if (snap.connectionState ==
                                  ConnectionState.waiting) {
                                return Container(
                                  height: AppVars.screenSize.height,
                                  child: const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              } else {
                                if (!snap.hasData) {
                                  return Container(
                                    height: AppVars.screenSize.height,
                                    child: const Center(
                                      child: Text("No data available"),
                                    ),
                                  );
                                } else {
                                  isInit = false;
                                  initEditAttendanceForm(snap.data!);
                                  return _editForm(provider, context, now);
                                }
                              }
                            }),
                      )
                    : _editForm(provider, context, now)));
  }

  SingleChildScrollView _editForm(EmployeeAttendanceController provider,
      BuildContext context, DateTime now) {
    return SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Text(
            "Edit Attendance",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          Form(
            key: _formInfoKey,
            child: Container(
                margin: EdgeInsets.symmetric(vertical: marginHeight),
                padding: EdgeInsets.only(left: leftPadding),
                decoration: AppVars.customInputboxDecoration,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Attendance Date: ${AppMethods().dateOfBirthFormat(_selectedAttendanceTime)}', //${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day}
                      style: TextStyle(fontSize: mediumLabelFontSize),
                    ),
                    SizedBox(width: 20),
                    TextButton(
                      onPressed: () =>
                          _selectDate(context, fDate: DateTime(2010)),
                      child: Text(
                        'Select Date',
                        style: TextStyle(fontSize: mediumLabelFontSize),
                      ),
                    ),
                  ],
                )),
          ),
          Container(
              margin: EdgeInsets.symmetric(vertical: marginHeight),
              padding: EdgeInsets.only(left: leftPadding, right: 10),
              decoration: boxDecoration,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Employee Code",
                    style: TextStyle(fontSize: mediumLabelFontSize),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    _employeeCode,
                    style: TextStyle(fontSize: mediumLabelFontSize),
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
                    "Employee Name",
                    style: TextStyle(fontSize: mediumLabelFontSize),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    _employeeName,
                    style: TextStyle(fontSize: mediumLabelFontSize),
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
                    'In Time: ${AppMethods().dateTimeToTimeString(_selectedInTime)}', //${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day}
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
                    'Out Time: ${AppMethods().dateTimeToTimeString(_selectedOutTime)}', //${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day}
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
            margin: EdgeInsets.symmetric(vertical: marginHeight),
            decoration: boxDecoration,
            child: TextFormField(
              controller: _employeeShiftDurationController,
              decoration: InputDecoration(
                labelText: 'Shift Duration',
                contentPadding: contentPadding,
                border: InputBorder.none,
                hintText: 'Shift Duration',
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
          Container(
              margin: EdgeInsets.symmetric(vertical: marginHeight),
              padding: EdgeInsets.only(left: leftPadding),
              decoration: boxDecoration,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Late Time: ${AppMethods().dateTimeToTimeString(_selectedLateTime)}', //${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day}
                    style: TextStyle(fontSize: mediumLabelFontSize),
                  ),
                  SizedBox(width: 20),
                  TextButton(
                    onPressed: () => selectLateTime(context),
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
                    'Over Time: ${AppMethods().dateTimeToTimeString(_selectedOverTime)}', //${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day}
                    style: TextStyle(fontSize: mediumLabelFontSize),
                  ),
                  SizedBox(width: 20),
                  TextButton(
                    onPressed: () => selectOverTime(context),
                    child: Text(
                      'Select Time',
                      style: TextStyle(fontSize: mediumLabelFontSize),
                    ),
                  ),
                ],
              )),
          Container(
            margin: EdgeInsets.symmetric(vertical: marginHeight),
            decoration: boxDecoration,
            child: TextFormField(
              controller: _totalWorkingHourController,
              decoration: InputDecoration(
                labelText: 'Total Working Hour',
                contentPadding: contentPadding,
                border: InputBorder.none,
                hintText: 'Total Working Hour',
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
            height: 10,
          ),
          Container(
              margin: EdgeInsets.symmetric(vertical: marginHeight),
              padding: EdgeInsets.only(left: leftPadding, right: 10),
              decoration: boxDecoration,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Status",
                    style: TextStyle(fontSize: mediumLabelFontSize),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  CupertinoSwitch(
                      value: didPresent ?? false,
                      onChanged: (val) {
                        didPresent = val;
                        print("didPresent: $val $didPresent");
                        didPresent = (val) ? true : false;
                        setState(() {});
                      })
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
            onPressed: () async {
              if (_formInfoKey.currentState!.validate()) {
                _formInfoKey.currentState!.save();

                if (didPresent == null) {
                  didPresent = false;
                }

                final postAttendanceModel = HrmsAttendancePostModel(
                    attendanceDate:
                        AppMethods().dateOfBirthFormat(_selectedAttendanceTime),
                    employeeId: widget.employeeId,
                    employeeInTime: AppMethods()
                        .timeIn24Hour(_selectedAttendanceTime, _selectedInTime),
                    employeeOutTime: AppMethods().timeIn24Hour(
                        _selectedAttendanceTime, _selectedOutTime),
                    employeeShiftDuration:
                        _employeeShiftDurationController.text,
                    employeeLateTime: AppMethods().timeIn24Hour(
                        _selectedAttendanceTime, _selectedLateTime),
                    employeeOverTime: AppMethods().timeIn24Hour(
                        _selectedAttendanceTime, _selectedOverTime),
                    employeeTotalWorkingHour: _totalWorkingHourController.text,
                    employeeStatus: (didPresent!) ? 1 : 0);

                await provider.updateAttendance(
                    ApiLinks.employeeAttendanceUpdateLink,
                    widget.id!,
                    postAttendanceModel);

                Navigator.of(context).pop();
              } else {
                AppMethods().snackBar(AppStrings.formErrorText, context);
              }
            },
            child: const Text(
              'Update',
              style: TextStyle(fontSize: 25),
            ),
          )
        ]));
  }
}
