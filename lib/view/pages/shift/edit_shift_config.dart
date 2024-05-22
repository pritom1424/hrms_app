import 'package:flutter/material.dart';
import 'package:hrms_app/controller/employee_data_controller.dart';
import 'package:hrms_app/controller/employee_shift_controller.dart';
import 'package:hrms_app/model/hrms_employee_post_model.dart';
import 'package:hrms_app/model/hrms_shift_model.dart';
import 'package:hrms_app/model/hrms_shift_post_model.dart';
import 'package:hrms_app/utils/app_methods/app_methods.dart';
import 'package:hrms_app/utils/app_variables/api_links.dart';
import 'package:hrms_app/utils/app_variables/app_vars.dart';
import 'package:hrms_app/view/widgets/appbar_default_widget.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EditShiftConfigForm extends StatefulWidget {
  final int? userId;
  final int? id;
  final String? title;
  const EditShiftConfigForm({super.key, this.id, this.title, this.userId});

  @override
  State<EditShiftConfigForm> createState() => _EditShiftConfigFormState();
}

class _EditShiftConfigFormState extends State<EditShiftConfigForm> {
  final TextEditingController _gracePeriodController = TextEditingController();
  bool isInit = false;
  bool? didDefaultShift;
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
  int? _selectedShift;
  TimeOfDay _selectedStartTime = TimeOfDay.now();
  TimeOfDay _selectedEndTime = TimeOfDay.now();

  TimeOfDay _selectedBreakStartTime = TimeOfDay.now();
  TimeOfDay _selectedBreakEndTime = TimeOfDay.now();

  String _totalWorkingHour = "";

  String calculateTotalWorkingHours(
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
  }

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

  void initShiftConfigForm(HrmsShiftModel hrmsShiftModel) {
    _gracePeriodController.text = hrmsShiftModel.gracePeriod ?? "";
    _selectedShift = hrmsShiftModel.shift.id;

    print("_selectedStartTime: }");
    /*   _selectedStartTime =
        AppMethods().dateStringToTimeOfDay(hrmsShiftModel.shiftStartTime); */
    final format = DateFormat.jm(); //"6:00 AM"
    _selectedStartTime =
        TimeOfDay.fromDateTime(format.parse(hrmsShiftModel.shiftStartTime!));
    _selectedEndTime =
        TimeOfDay.fromDateTime(format.parse(hrmsShiftModel.shiftEndTime!));
    _selectedBreakStartTime =
        TimeOfDay.fromDateTime(format.parse(hrmsShiftModel.breakStartTime!));
    _selectedBreakEndTime =
        TimeOfDay.fromDateTime(format.parse(hrmsShiftModel.breakEndTime!));
    _totalWorkingHour = hrmsShiftModel.totalWorkingHour ?? "";

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
        Provider.of<EmployeeDataController>(context, listen: false);

    final providerShift =
        Provider.of<EmployeeShiftController>(context, listen: false);
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
                    ? FutureBuilder(
                        future: providerShift.loadShiftById(
                            ApiLinks.employeeShiftLink, widget.id!),
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
                              initShiftConfigForm(snap.data!);
                              return _editForm(
                                  provider, context, now, providerShift);
                            }
                          }
                        })
                    : _editForm(provider, context, now, providerShift)));
  }

  SingleChildScrollView _editForm(EmployeeDataController provider,
      BuildContext context, DateTime now, EmployeeShiftController provShif) {
    return SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
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
                      child: FutureBuilder(
                        future: provider.getShiftList(ApiLinks.shiftTypeLink),
                        builder: (ctx, snapshot) => (!snapshot.hasData)
                            ? const SizedBox.shrink()
                            : DropdownButton(
                                hint: Text(
                                  "Choose Shift",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontSize: mediumLabelFontSize,
                                      color: Colors.black54),
                                ),
                                value: _selectedShift,
                                items: List.generate(
                                    snapshot.data!.data.length,
                                    (index) => DropdownMenuItem(
                                        value: snapshot.data!.data[index].id,
                                        child: Text(
                                          snapshot.data!.data[index].shiftName,
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelSmall,
                                        ))),
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
                    'Start Time: ${AppMethods().dateTimeToTimeString(_selectedStartTime)}', //${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day}
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
                    'End Time: ${AppMethods().dateTimeToTimeString(_selectedEndTime)}', //${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day}
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
                  value: (didDefaultShift == null) ? false : didDefaultShift,
                  onChanged: (val) {
                    setState(() {
                      (didDefaultShift == null)
                          ? didDefaultShift = true
                          : didDefaultShift = !didDefaultShift!;
                    });
                  },
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: marginHeight),
            decoration: boxDecoration,
            child: TextFormField(
              controller: _gracePeriodController,
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
                    'Start Time: ${AppMethods().dateTimeToTimeString(_selectedBreakStartTime)}', //${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day}
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
                    'End Time: ${AppMethods().dateTimeToTimeString(_selectedBreakEndTime)}', //${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day}
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
                    _totalWorkingHour,
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
            onPressed: () async {
              if (_selectedShift == null ||
                  _gracePeriodController.text.isEmpty) {
                return;
              }
              _totalWorkingHour = calculateTotalWorkingHours(
                  _selectedStartTime,
                  _selectedEndTime,
                  _selectedBreakStartTime,
                  _selectedBreakEndTime);
              final shiftPostModel = HrmsShiftPostModel(
                  shiftId: _selectedShift!,
                  shiftStartTime:
                      AppMethods().dateTimeToTimeString(_selectedStartTime),
                  shiftEndTime:
                      AppMethods().dateTimeToTimeString(_selectedEndTime),
                  defaultShift: didDefaultShift,
                  gracePeriod: _gracePeriodController.text,
                  breakStartTime: AppMethods()
                      .dateTimeToTimeString(_selectedBreakStartTime),
                  breakEndTime:
                      AppMethods().dateTimeToTimeString(_selectedBreakEndTime),
                  totalWorkingHour: _totalWorkingHour,
                  userID: widget.userId);

              await provShif.updateShift(
                  ApiLinks.shiftConfigUpdateLink, widget.id!, shiftPostModel);

              Navigator.of(context).pop();

              /* if (_formPersonalInfoKey.currentState!.validate()) {
                _formPersonalInfoKey.currentState!.save();
                // Do something with the validated data
                // print('Name: $_name');
              } */

              // Handle apply button press
              // You can access the values using controller.text for each field
            },
            child: const Text(
              'Update',
              style: TextStyle(fontSize: 25),
            ),
          )
        ]));
  }
}
