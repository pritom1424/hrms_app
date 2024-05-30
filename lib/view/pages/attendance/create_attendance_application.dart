import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hrms_app/controller/employee_attendance_controller.dart';

import 'package:hrms_app/model/hrms_attendance_post_model.dart';
import 'package:hrms_app/model/hrms_employee_attendance_list_model.dart';

import 'package:hrms_app/model/hrms_employee_attendance_model.dart';

import 'package:hrms_app/utils/app_methods/app_methods.dart';
import 'package:hrms_app/utils/app_variables/api_links.dart';
import 'package:hrms_app/utils/app_variables/app_strings.dart';
import 'package:hrms_app/utils/app_variables/app_vars.dart';
import 'package:hrms_app/view/widgets/appbar_default_widget.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CreateAttendanceForm extends StatefulWidget {
  final String? title;
  const CreateAttendanceForm({
    super.key,
    this.title,
  });

  @override
  State<CreateAttendanceForm> createState() => _CreateAttendanceFormState();
}

class _CreateAttendanceFormState extends State<CreateAttendanceForm> {
  final _formInfoKey = GlobalKey<FormState>();

  final TextEditingController _employeeShiftDurationController =
      TextEditingController();
  final TextEditingController _totalWorkingHourController =
      TextEditingController();
  bool isInit = false;
  bool didPresent = true;
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

  TimeOfDay? _selectedInTime;
  TimeOfDay? _selectedOutTime;

  TimeOfDay? _selectedLateTime;
  TimeOfDay? _selectedOverTime;

  DateTime _selectedAttendanceTime = DateTime.now();

  String? _selectedEmployee;
  int? _selectedEmployeeID;

  String _employeeCode = "";
  String _employeeName = "";

  HrmsEmployeeAttendanceListModel? currentModel;

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
    _selectedInTime = TimeOfDay.now();
    _selectedOutTime = TimeOfDay.now();
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: (isEnd) ? _selectedOutTime! : _selectedInTime!,
    );

    if (isEnd) {
      if (picked != _selectedOutTime) {
        setState(() {
          _selectedOutTime = picked;
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
    _selectedLateTime = TimeOfDay.now();
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedLateTime!,
    );

    if (picked != _selectedLateTime) {
      setState(() {
        _selectedLateTime = picked;
      });
    }
  }

  Future<void> selectOverTime(BuildContext contex) async {
    _selectedOverTime = TimeOfDay.now();
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedOverTime!,
    );

    if (picked != _selectedOverTime) {
      setState(() {
        _selectedOverTime = picked;
      });
    }
  }

  void initEditAttendanceForm(
      HrmsEmployeeAttendanceListModel hrmsAttendanceModel) {
    // _employeeCode = hrmsAttendanceModel.data.employeeCode;
    //_employeeName = hrmsAttendanceModel.employee.employeeName;
/*     _employeeCodeController.text =
        hrmsAttendanceModel.employee.employeeCode ?? "";
    _employeeNameController.text = */
    //    hrmsAttendanceModel.employee.employeeName ?? "";
    /*   _employeeShiftDurationController.text =
        hrmsAttendanceModel.shiftDuration ?? ""; */
    /*  _totalWorkingHourController.text =
        hrmsAttendanceModel.totalWorkingHour ?? ""; */

    // (hrmsAttendanceModel.status == 1) ? didPresent = true : didPresent = false;

    print("_selectedStartTime: }");
    /*   _selectedStartTime =
        AppMethods().dateStringToTimeOfDay(hrmsShiftModel.shiftStartTime); */
    /*  final format = DateFormat("HH:mm"); //"6:00 AM"
    _selectedInTime =
        TimeOfDay.fromDateTime(format.parse(hrmsAttendanceModel.inTime!));
    _selectedOutTime =
        TimeOfDay.fromDateTime(format.parse(hrmsAttendanceModel.outTime!));
    _selectedLateTime =
        TimeOfDay.fromDateTime(format.parse(hrmsAttendanceModel.lateTime!));
    _selectedOverTime =
        TimeOfDay.fromDateTime(format.parse(hrmsAttendanceModel.overTime!));
    _selectedAttendanceTime = hrmsAttendanceModel.attendanceDate!; */

    /*  _selectedEndTime =
        AppMethods().dateStringToTimeOfDay(hrmsShiftModel.shiftEndTime);
    _selectedBreakStartTime =
        AppMethods().dateStringToTimeOfDay(hrmsShiftModel.breakStartTime);
    _selectedBreakEndTime =
        AppMethods().dateStringToTimeOfDay(hrmsShiftModel.breakEndTime); */
    /*    _totalWorkingHour = hrmsShiftModel.totalWorkingHour ?? ""; */
  }

  @override
  void initState() {
    isInit = true;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    final provider =
        Provider.of<EmployeeAttendanceController>(context, listen: false);

/*     final providerShift =
        Provider.of<EmployeeShiftController>(context, listen: false); */
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
            child: (isInit)
                ? SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                    child: FutureBuilder(
                        future: provider.getEmployeeAttendanceList(
                            ApiLinks.employeeAttendanceListLink),
                        builder: (ctx, snap) {
                          if (snap.connectionState == ConnectionState.waiting) {
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
                              currentModel = snap.data;
                              initEditAttendanceForm(currentModel!);
                              return _editForm(currentModel!, context, now);
                            }
                          }
                        }),
                  )
                : _editForm(currentModel!, context, now)));
  }

  SingleChildScrollView _editForm(HrmsEmployeeAttendanceListModel attendList,
      BuildContext context, DateTime now) {
    final provider =
        Provider.of<EmployeeAttendanceController>(context, listen: false);
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
                    /* 
                     Text(
                      'Date Of Birth: ${DateFormat.yMd().format(_selectedDate)}', //${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day}
                      style: TextStyle(fontSize: mediumLabelFontSize),
                    ), */
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
            padding: EdgeInsets.only(left: leftPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    "Employee",
                    style: TextStyle(
                        fontSize: labelFontSize, fontWeight: FontWeight.bold),
                  ),
                ),
                DropdownButtonHideUnderline(
                  child: Expanded(
                    flex: 2,
                    child: Container(
                      //width: AppVars.screenSize.width * 0.40,
                      padding: AppVars.inputContentPadding,
                      decoration: AppVars
                          .customInputboxDecoration, // BoxDecoration(border: Border.all(width: 0.4)),
                      margin: EdgeInsets.symmetric(vertical: marginHeight),
                      child: (attendList.data.isEmpty)
                          ? SizedBox.shrink()
                          : /* Text(nationSnap.data!.data[3].countryName!) */

                          DropdownButton(
                              padding: EdgeInsets.all(0),
                              hint: Text(
                                "Select employee",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                    fontSize: mediumLabelFontSize,
                                    color: Colors.black54),
                              ),
                              value: _selectedEmployee,
                              items: List.generate(
                                  attendList.data.length,
                                  (index) => DropdownMenuItem(
                                      value: currentModel!
                                          .data[index].employeeName,
                                      child: Text(
                                        attendList.data[index].employeeName
                                            .toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall,
                                      ))),

                              /* Nationality.values
                              .map(
                                (nationality) => DropdownMenuItem(
                                  value: nationality,
                                  child: Text(
                                    nationality.name.toUpperCase(),
                                    style:
                                        Theme.of(context).textTheme.labelSmall,
                                  ),
                                ),
                              )
                              .toList() */
                              onChanged: (val) {
                                if (val == null) {
                                  return;
                                }
                                setState(() {
                                  _selectedEmployee = val;
                                  _selectedEmployeeID = attendList
                                      .data[attendList.data.indexWhere((data) =>
                                          data.employeeName ==
                                          _selectedEmployee)]
                                      .employeeId;
                                });
                              }),
                    ),
                  ),
                ),
              ],
            ),
          ),
          /*    Container(
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
              )), */
          /* Container(
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
              )), */
          Container(
              margin: EdgeInsets.symmetric(vertical: marginHeight),
              padding: EdgeInsets.only(left: leftPadding),
              decoration: boxDecoration,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'In Time: ${(_selectedInTime == null) ? "" : AppMethods().dateTimeToTimeString(_selectedInTime!)}', //${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day}
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
                    'Out Time: ${(_selectedOutTime == null) ? "" : AppMethods().dateTimeToTimeString(_selectedOutTime!)}', //${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day}
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

                /*  prefixIcon: Icon(
              Icons.phone,
              color: iconColor,
            ), */
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
                    'Late Time: ${(_selectedLateTime == null) ? "" : AppMethods().dateTimeToTimeString(_selectedLateTime!)}', //${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day}
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
                    'Over Time: ${(_selectedOverTime == null) ? "" : AppMethods().dateTimeToTimeString(_selectedOverTime!)}', //${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day}
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

                /*  prefixIcon: Icon(
              Icons.phone,
              color: iconColor,
            ), */
                border: InputBorder.none,
                hintText: 'Total Working Hour',
                hintStyle: AppVars.customHintTextStyle,
                labelStyle: TextStyle(
                    fontSize: mediumLabelFontSize, color: labelFontColor),
              ),
              /*   validator: (value) {
                if (value != null && value == "") {
                  return 'Please enter leave type';
                }
                return null;
              }, */
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
                    "Present",
                    style: TextStyle(fontSize: mediumLabelFontSize),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  CupertinoSwitch(
                      value: didPresent,
                      onChanged: (val) {
                        didPresent = val;
                        print("didPresent: $val $didPresent");
                        didPresent = (val) ? true : false;
                        setState(() {});
                      })
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
                    "Absent",
                    style: TextStyle(fontSize: mediumLabelFontSize),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  CupertinoSwitch(
                      value: !didPresent,
                      onChanged: (val) {
                        didPresent = val;
                        print("didPresent: $val $didPresent");
                        didPresent = (val) ? false : true;
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
              // _gracePeriodController.text.isEmpty
              /* if (_selected == null) {
                AppMethods.snackBar(AppStrings.formErrorText, context);
                return;
              } */
              if (_formInfoKey.currentState!.validate() &&
                  _selectedInTime != null &&
                  _selectedOutTime != null) {
                _formInfoKey.currentState!.save();

                final postAttendanceModel = HrmsAttendancePostModel(
                    attendanceDate:
                        AppMethods().dateOfBirthFormat(_selectedAttendanceTime),
                    employeeId: _selectedEmployeeID, //widget.employeeId,
                    employeeInTime: AppMethods().timeIn24Hour(
                        _selectedAttendanceTime, _selectedInTime!),
                    employeeOutTime: AppMethods().timeIn24Hour(
                        _selectedAttendanceTime, _selectedOutTime!),
                    employeeShiftDuration:
                        _employeeShiftDurationController.text,
                    employeeLateTime: (_selectedLateTime == null)
                        ? null
                        : AppMethods().timeIn24Hour(
                            _selectedAttendanceTime, _selectedLateTime!),
                    employeeOverTime: (_selectedOverTime == null)
                        ? null
                        : AppMethods().timeIn24Hour(
                            _selectedAttendanceTime, _selectedOverTime!),
                    employeeTotalWorkingHour: _totalWorkingHourController.text,
                    employeeStatus: (didPresent) ? 1 : 0);
/* 
                await provider.updateAttendance(
                    ApiLinks.employeeAttendanceUpdateLink,
                    1 /* widget.id! */,
                    postAttendanceModel); */
                final didSuccess = await provider.createAttendance(
                    ApiLinks.addAttendanceLink, postAttendanceModel);
                if (didSuccess) {
                  Navigator.of(context).pop();
                } else {
                  AppMethods().snackBar("Employee already exists", context);
                }
              } else {
                AppMethods().snackBar(AppStrings.formErrorText, context);
              }
              /* if (_formPersonalInfoKey.currentState!.validate()) {
                _formPersonalInfoKey.currentState!.save();
                // Do something with the validated data
                // print('Name: $_name');
              } */

              // Handle apply button press
              // You can access the values using controller.text for each field
            },
            child: const Text(
              'Add',
              style: TextStyle(fontSize: 25),
            ),
          )
        ]));
  }
}
