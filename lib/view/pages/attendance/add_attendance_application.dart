import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hrms_app/controller/employee_attendance_controller.dart';
import 'package:hrms_app/controller/employee_data_controller.dart';
import 'package:hrms_app/model/hrms_add_attendance_post_model.dart';

import 'package:hrms_app/model/hrms_employee_attendance_list_model.dart';
import 'package:hrms_app/model/hrms_employee_model.dart';

import 'package:hrms_app/utils/app_methods/app_methods.dart';
import 'package:hrms_app/utils/app_variables/api_links.dart';
import 'package:hrms_app/utils/app_variables/app_strings.dart';
import 'package:hrms_app/utils/app_variables/app_vars.dart';
import 'package:hrms_app/view/widgets/appbar_default_widget.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddAttendanceForm extends StatefulWidget {
  final String? title;
  const AddAttendanceForm({super.key, this.title});

  @override
  State<AddAttendanceForm> createState() => _AddAttendanceFormState();
}

class _AddAttendanceFormState extends State<AddAttendanceForm> {
  final _formInfoKey = GlobalKey<FormState>();
  List<TextEditingController> _employeeShiftDurationContollers = [];
  List<TextEditingController> _totalWorkingHourController = [];

//  final TextEditingController _employeeCodeController = TextEditingController();
  //final TextEditingController _employeeNameController = TextEditingController();
  // final TextEditingController _employeeShiftDurationController =
  //     TextEditingController();
  // final TextEditingController _totalWorkingHourController =
  //     TextEditingController();
  bool isInit = false;
  int listLength = 0;
  List<bool?> didPresent = [];
  Column formColumn = Column();
  //bool? didPresent;
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
  List<TimeOfDay?> _selectedInTimes = [];
  List<TimeOfDay?> _selectedOutTimes = [];
  List<TimeOfDay?> _selectedLateTimes = [];
  List<TimeOfDay?> _selectedOverTimes = [];
  DateTime _selectedAttendanceTime = DateTime.now();
  List<String> _employeeCodes = [];
  List<String> _employeeNames = [];

/* 
  TimeOfDay _selectedInTime = TimeOfDay.now();
  TimeOfDay _selectedOutTime = TimeOfDay.now();

  TimeOfDay _selectedLateTime = TimeOfDay.now();
  TimeOfDay _selectedOverTime = TimeOfDay.now();

  DateTime _selectedAttendanceTime = DateTime.now();

  String _employeeCode = "";
  String _employeeName = ""; */

  //String _totalWorkingHour = "";

  /* String calculateTotalWorkingHours(
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
  }*/

  Widget attFormList() {
    final provider = Provider.of<EmployeeAttendanceController>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Column(
          children: List.generate(listLength, (ind) => _editForm(context, ind)),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          child: ElevatedButton(
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
              /*  if (_formInfoKey.currentState!.validate()) {
                _formInfoKey.currentState!.save();

              
              } else {
                AppMethods().snackBar(AppStrings.formErrorText, context);
              } */
              List<String?> inTimes = [];
              List<String?> outTimes = [];
              List<String?> lateTimes = [];
              List<String?> overTimes = [];
              List<String?> duration = [];
              List<String?> totalHours = [];
              List<int?> status = [];
              List<int?> ids = [];
              for (int i = 0; i < listLength; i++) {
                inTimes.add((_selectedInTimes[i] != null)
                    ? AppMethods()
                        .timeIn24Hour(DateTime.now(), _selectedInTimes[i]!)
                    : "");
                outTimes.add((_selectedOutTimes[i] != null)
                    ? AppMethods()
                        .timeIn24Hour(DateTime.now(), _selectedOutTimes[i]!)
                    : "");
                lateTimes.add((_selectedLateTimes[i] != null)
                    ? AppMethods()
                        .timeIn24Hour(DateTime.now(), _selectedLateTimes[i]!)
                    : "");
                overTimes.add((_selectedOverTimes[i] != null)
                    ? AppMethods()
                        .timeIn24Hour(DateTime.now(), _selectedOverTimes[i]!)
                    : "");
                duration.add(_employeeShiftDurationContollers[i].text);
                totalHours.add(_totalWorkingHourController[i].text);
                status.add(didPresent[i]! ? 1 : 0);
                ids.add(AppMethods().employeeCodeToId(_employeeCodes[i]));
              }

              final postAttendanceModel = HrmsAddAttendancePostModel(
                  attendanceDate:
                      AppMethods().dateOfBirthFormat(_selectedAttendanceTime),
                  employeeId: ids,
                  employeeInTime: inTimes,
                  employeeOutTime: outTimes,
                  employeeShiftDuration: duration,
                  employeeLateTime: lateTimes,
                  employeeOverTime: overTimes,
                  employeeTotalWorkingHour: totalHours,
                  employeeStatus: status);

              /* if (didPresent == null) {
                                                                didPresent = false;
                                                              }
                                              
                                                              final postAttendanceModel = HrmsAttendancePostModel(
                                                                  attendanceDate:
                                                                      AppMethods.dateOfBirthFormat(_selectedAttendanceTime),
                                                                  employeeId: widget.employeeId,
                                                                  employeeInTime: AppMethods.timeIn24Hour(
                                                                      _selectedAttendanceTime, _selectedInTime),
                                                                  employeeOutTime: AppMethods.timeIn24Hour(
                                                                      _selectedAttendanceTime, _selectedOutTime),
                                                                  employeeShiftDuration:
                                                                      _employeeShiftDurationController.text,
                                                                  employeeLateTime: AppMethods.timeIn24Hour(
                                                                      _selectedAttendanceTime, _selectedLateTime),
                                                                  employeeOverTime: AppMethods.timeIn24Hour(
                                                                      _selectedAttendanceTime, _selectedOverTime),
                                                                  employeeTotalWorkingHour: _totalWorkingHourController.text,
                                                                  employeeStatus: (didPresent!) ? "Present" : "Absent");
                                               */
              await provider.addAttendance(
                  ApiLinks.addAttendanceLink, postAttendanceModel);

              Navigator.of(context).pop();
            },
            child: const Text(
              'Add',
              style: TextStyle(fontSize: 25),
            ),
          ),
        ),
      ],
    );
  }

  Future<TimeOfDay?> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      return picked;
    } else {
      return null;
    }
  }

  Future<DateTime?> _selectDate(BuildContext context,
      {DateTime? fDate, DateTime? lDate}) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: (fDate != null) ? fDate : DateTime(2015, 8),
      lastDate: (lDate != null) ? lDate : DateTime(2101),
    );
    if (picked != null) {
      return picked;
    }
    return null;
  }

  void initEditAttendanceForm(HrmsEmployeeModel hrmsAttendanceModelList) {
    for (int i = 0; i < hrmsAttendanceModelList.data.length; i++) {
      _employeeShiftDurationContollers.add(TextEditingController());
      _totalWorkingHourController.add(TextEditingController());
      if (hrmsAttendanceModelList.data[i].id != null) {
        _employeeCodes.add(hrmsAttendanceModelList.data[i].employeeCode!);
      }
      if (hrmsAttendanceModelList.data[i].employeeName != null) {
        _employeeNames.add(hrmsAttendanceModelList.data[i].employeeName!);
      }
      _selectedInTimes.add(TimeOfDay.now());
      _selectedOutTimes.add(TimeOfDay.now());
      _selectedLateTimes.add(TimeOfDay.now());
      _selectedOverTimes.add(TimeOfDay.now());
      didPresent.add(false);
    }
/*     _employeeCodeController.text =
        hrmsAttendanceModel.employee.employeeCode ?? "";
    _employeeNameController.text =
        hrmsAttendanceModel.employee.employeeName ?? "";
    _employeeShiftDurationController.text =
        hrmsAttendanceModel.shiftDuration ?? "";
    _totalWorkingHourController.text =
        hrmsAttendanceModel.totalWorkingHour ?? ""; */
  }

  @override
  void initState() {
    isInit = true;
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    for (int i = 0; i < _employeeShiftDurationContollers.length; i++) {
      _employeeShiftDurationContollers[i].dispose();
    }
    for (int i = 0; i < _totalWorkingHourController.length; i++) {
      _totalWorkingHourController[i].dispose();
    }

    // TODO: implement dispose
    super.dispose();
  }

  Widget _editForm(BuildContext ctx, int ind) {
    print("formind $ind");
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        /*  Text(
      "Edit Attendance",
      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ), */
        Center(
          child: Text(
            "Date: ${DateFormat('EEE, d MMM yyyy').format(_selectedAttendanceTime)}",
            textAlign: TextAlign.center,
          ),
        ),
        Form(
            // key: _formInfoKey,
            child: Container(
                margin: EdgeInsets.symmetric(vertical: marginHeight),
                padding: EdgeInsets.only(left: leftPadding),
                decoration: AppVars.customInputboxDecoration,
                child: Column(
                  children: [
                    Container(
                        margin: EdgeInsets.symmetric(vertical: marginHeight),
                        padding: EdgeInsets.only(left: leftPadding, right: 10),
                        decoration: boxDecoration,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Employee Id",
                              style: TextStyle(fontSize: mediumLabelFontSize),
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            Text(
                              _employeeCodes[ind],
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
                              _employeeNames[ind],
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
                              'In Time: ${(_selectedInTimes[ind] == null) ? "" : AppMethods().dateTimeToTimeString(_selectedInTimes[ind]!)}', //${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day}
                              style: TextStyle(fontSize: mediumLabelFontSize),
                            ),
                            SizedBox(width: 20),
                            TextButton(
                              onPressed: () async {
                                _selectedInTimes[ind] =
                                    await _selectTime(context) ??
                                        TimeOfDay.now();
                                setState(() {});
                              },
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
                              'Out Time: ${(_selectedOutTimes[ind] == null) ? "" : AppMethods().dateTimeToTimeString(_selectedOutTimes[ind]!)}', //${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day}
                              style: TextStyle(fontSize: mediumLabelFontSize),
                            ),
                            SizedBox(width: 20),
                            TextButton(
                              onPressed: () async {
                                _selectedOutTimes[ind] =
                                    await _selectTime(context) ??
                                        TimeOfDay.now();
                                setState(() {});
                              },
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
                        controller: _employeeShiftDurationContollers[ind],
                        keyboardType: TextInputType.number,
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
                              fontSize: mediumLabelFontSize,
                              color: labelFontColor),
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
                              'Late Time: ${(_selectedLateTimes[ind] == null) ? "" : AppMethods().dateTimeToTimeString(_selectedLateTimes[ind]!)}', //${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day}
                              style: TextStyle(fontSize: mediumLabelFontSize),
                            ),
                            SizedBox(width: 20),
                            TextButton(
                              onPressed: () async {
                                _selectedLateTimes[ind] =
                                    await _selectTime(context) ??
                                        TimeOfDay.now();
                                setState(() {});
                              },
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
                              'Over Time: ${(_selectedOverTimes[ind] == null) ? "" : AppMethods().dateTimeToTimeString(_selectedOverTimes[ind]!)}', //${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day}
                              style: TextStyle(fontSize: mediumLabelFontSize),
                            ),
                            SizedBox(width: 20),
                            TextButton(
                              onPressed: () async {
                                _selectedOverTimes[ind] =
                                    await _selectTime(context) ??
                                        TimeOfDay.now();
                                setState(() {});
                              },
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
                        controller: _totalWorkingHourController[ind],
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
                              fontSize: mediumLabelFontSize,
                              color: labelFontColor),
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
                                value: didPresent[ind] ?? false,
                                onChanged: (val) {
                                  didPresent[ind] = val;
                                  print("didPresent: $val $didPresent");

                                  setState(() {
                                    didPresent[ind] = (val) ? true : false;
                                  });
                                })
                          ],
                        )),
                  ],
                )))
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    final provider =
        Provider.of<EmployeeAttendanceController>(context, listen: false);
    final employeeProvider =
        Provider.of<EmployeeDataController>(context, listen: false);

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
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child: Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              // height: AppVars.screenSize.height * 1,
              child: (isInit)
                  ? FutureBuilder(
                      future: employeeProvider
                          .loadEmployeeList(ApiLinks.employeeListApiLink),
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
                            initEditAttendanceForm(snap.data!);

                            print(snap.data);
                            listLength = snap.data!.data.length;

                            print(listLength);
                            return attFormList();
                          }
                        }
                      })
                  : attFormList()),
        ));
  }
}
