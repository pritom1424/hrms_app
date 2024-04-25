import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:hrms_app/utils/app_colors/app_colors.dart';
import 'package:hrms_app/utils/app_variables/app_vars.dart';
import 'package:hrms_app/view/widgets/appbar_default_widget.dart';

class LeaveFormPage extends StatefulWidget {
  final String? title;
  const LeaveFormPage(this.title, {super.key});
  @override
  State<LeaveFormPage> createState() => _LeaveFormPageState();
}

class _LeaveFormPageState extends State<LeaveFormPage> {
  // Define controllers for text fields
  final TextEditingController _employeeIdController = TextEditingController();
  final TextEditingController _contactNoController = TextEditingController();
  final TextEditingController _responsibleEmployeeIdController =
      TextEditingController();
  final TextEditingController _leaveTypeController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _totalLeaveDaysController =
      TextEditingController();
  final TextEditingController _addressDuringLeaveController =
      TextEditingController();
  final TextEditingController _reasonForLeaveController =
      TextEditingController();
  final TextEditingController _remarksController = TextEditingController();

  // form vars
  EdgeInsetsGeometry contentPadding =
      const EdgeInsets.symmetric(horizontal: 20);
  BorderRadius borderRadius = const BorderRadius.all(Radius.circular(10));
  Color borderColor = const Color.fromARGB(255, 189, 183, 183);
  double borderWidth = 1;

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
  double labelFontSize = 18;
  Color labelFontColor = Colors.grey;

  TextStyle hintTextStyle = TextStyle(color: Colors.grey.withOpacity(0.5));

  // action button
  Color actionButtonBgColor = const Color.fromARGB(255, 68, 156, 204);
  Color actionButtonFgColor = Colors.white;

  Color iconColor = Colors.grey;
  @override
  void dispose() {
    // Clean up controllers when the widget is disposed

    _employeeIdController.dispose();
    _contactNoController.dispose();
    _responsibleEmployeeIdController.dispose();
    _leaveTypeController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    _totalLeaveDaysController.dispose();
    _addressDuringLeaveController.dispose();
    _reasonForLeaveController.dispose();
    _remarksController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Leave Application Form
      appBar: (widget.title == null)
          ? null
          : AppbarDefault(
              appbarName: widget.title,
            ),
      body: SingleChildScrollView(
        child: Container(
          color: Appcolors.appBgColor,
          padding: const EdgeInsets.all(16),
          height: AppVars.screenSize.height * 0.9,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                decoration: boxDecoration,
                child: TextFormField(
                  autofocus: false,
                  controller: _employeeIdController,
                  decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      labelText: 'Employee ID',
                      contentPadding: contentPadding,
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.person,
                        color: iconColor,
                      ),
                      /* focusedBorder: OutlineInputBorder(
                        borderRadius: borderRadius,
                        borderSide:
                            BorderSide(color: borderColor, width: borderWidth)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: borderRadius,
                        borderSide:
                            BorderSide(color: borderColor, width: borderWidth)), */
                      hintText: 'Employee ID',
                      labelStyle: TextStyle(
                          fontSize: labelFontSize, color: labelFontColor),
                      hintStyle: hintTextStyle),
                  validator: (value) {
                    if (value != null && value == "") {
                      return 'Please enter employee ID';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                decoration: boxDecoration,
                child: TextFormField(
                  controller: _contactNoController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: 'Contact No',
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.phone,
                        color: iconColor,
                      ),
                      contentPadding: contentPadding,
                      /* focusedBorder: OutlineInputBorder(
                        borderRadius: borderRadius,
                        borderSide:
                            BorderSide(color: borderColor, width: borderWidth)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: borderRadius,
                        borderSide:
                            BorderSide(color: borderColor, width: borderWidth)), */
                      hintText: 'Contact No',
                      labelStyle: TextStyle(
                          fontSize: labelFontSize, color: labelFontColor),
                      hintStyle: hintTextStyle),
                  validator: (value) {
                    if (value != null && value == "") {
                      return 'Please enter contact number';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                decoration: boxDecoration,
                child: TextFormField(
                  controller: _responsibleEmployeeIdController,
                  decoration: InputDecoration(
                      labelText: 'Responsible Employee ID',
                      contentPadding: contentPadding,
                      prefixIcon: Icon(
                        Icons.group,
                        color: iconColor,
                      ),
                      border: InputBorder.none,
                      /*  focusedBorder: OutlineInputBorder(
                        borderRadius: borderRadius,
                        borderSide:
                            BorderSide(color: borderColor, width: borderWidth)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: borderRadius,
                        borderSide:
                            BorderSide(color: borderColor, width: borderWidth)), */
                      hintText: 'Responsible Employee ID',
                      labelStyle: TextStyle(
                          fontSize: labelFontSize, color: labelFontColor),
                      hintStyle: hintTextStyle),
                ),
              ),
              Container(
                decoration: boxDecoration,
                child: TextFormField(
                  controller: _leaveTypeController,
                  decoration: InputDecoration(
                      labelText: 'Leave Type',
                      contentPadding: contentPadding,
                      prefixIcon: Icon(
                        Icons.type_specimen,
                        color: iconColor,
                      ),
                      border: InputBorder.none,
                      /*  focusedBorder: OutlineInputBorder(
                        borderRadius: borderRadius,
                        borderSide:
                            BorderSide(color: borderColor, width: borderWidth)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: borderRadius,
                        borderSide:
                            BorderSide(color: borderColor, width: borderWidth)), */
                      hintText: 'Leave Type',
                      labelStyle: TextStyle(
                          fontSize: labelFontSize, color: labelFontColor),
                      hintStyle: hintTextStyle),
                  validator: (value) {
                    if (value != null && value == "") {
                      return 'Please enter leave type';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                decoration: boxDecoration,
                child: TextFormField(
                  controller: _startDateController,
                  decoration: InputDecoration(
                      labelText: 'Start Date',
                      contentPadding: contentPadding,
                      prefixIcon: Icon(
                        Icons.calendar_month,
                        color: iconColor,
                      ),
                      border: InputBorder.none,
                      /* focusedBorder: OutlineInputBorder(
                        borderRadius: borderRadius,
                        borderSide:
                            BorderSide(color: borderColor, width: borderWidth)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: borderRadius,
                        borderSide:
                            BorderSide(color: borderColor, width: borderWidth)), */
                      hintText: 'Start Date',
                      labelStyle: TextStyle(
                          fontSize: labelFontSize, color: labelFontColor),
                      hintStyle: hintTextStyle),
                  validator: (value) {
                    if (value != null && value == "") {
                      return 'Please enter start date';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                decoration: boxDecoration,
                child: TextFormField(
                  controller: _endDateController,
                  decoration: InputDecoration(
                      labelText: 'End Date',
                      contentPadding: contentPadding,
                      prefixIcon: Icon(
                        Icons.calendar_month,
                        color: iconColor,
                      ),
                      border: InputBorder.none,
                      /* focusedBorder: OutlineInputBorder(
                        borderRadius: borderRadius,
                        borderSide:
                            BorderSide(color: borderColor, width: borderWidth)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: borderRadius,
                        borderSide:
                            BorderSide(color: borderColor, width: borderWidth)), */
                      hintText: 'End Date',
                      labelStyle: TextStyle(
                          fontSize: labelFontSize, color: labelFontColor),
                      hintStyle: hintTextStyle),
                  validator: (value) {
                    if (value != null && value == "") {
                      return 'Please enter end date';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                decoration: boxDecoration,
                child: TextFormField(
                  controller: _totalLeaveDaysController,
                  decoration: InputDecoration(
                      labelText: 'Total Leave Days',
                      contentPadding: contentPadding,
                      prefixIcon: Icon(
                        Icons.calendar_view_day,
                        color: iconColor,
                      ),
                      border: InputBorder.none,
                      /* focusedBorder: OutlineInputBorder(
                        borderRadius: borderRadius,
                        borderSide:
                            BorderSide(color: borderColor, width: borderWidth)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: borderRadius,
                        borderSide:
                            BorderSide(color: borderColor, width: borderWidth)), */
                      hintText: 'Total Leave Days',
                      labelStyle: TextStyle(
                          fontSize: labelFontSize, color: labelFontColor),
                      hintStyle: hintTextStyle),
                  validator: (value) {
                    if (value != null && value == "") {
                      return 'Please enter total leave days';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                decoration: boxDecoration,
                child: TextFormField(
                  controller: _addressDuringLeaveController,
                  decoration: InputDecoration(
                      labelText: 'Address During Leave',
                      contentPadding: contentPadding,
                      prefixIcon: Icon(
                        Icons.calendar_today,
                        color: iconColor,
                      ),
                      border: InputBorder.none,
                      /* focusedBorder: OutlineInputBorder(
                        borderRadius: borderRadius,
                        borderSide:
                            BorderSide(color: borderColor, width: borderWidth)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: borderRadius,
                        borderSide:
                            BorderSide(color: borderColor, width: borderWidth)), */
                      hintText: 'Address During Leave',
                      labelStyle: TextStyle(
                          fontSize: labelFontSize, color: labelFontColor),
                      hintStyle: hintTextStyle),
                ),
              ),
              Container(
                decoration: boxDecoration,
                child: TextFormField(
                  controller: _reasonForLeaveController,
                  decoration: InputDecoration(
                      labelText: 'Reason for Leave',
                      contentPadding: contentPadding,
                      prefixIcon: Icon(
                        Icons.time_to_leave,
                        color: iconColor,
                      ),
                      border: InputBorder.none,
                      /* focusedBorder: OutlineInputBorder(
                        borderRadius: borderRadius,
                        borderSide:
                            BorderSide(color: borderColor, width: borderWidth)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: borderRadius,
                        borderSide:
                            BorderSide(color: borderColor, width: borderWidth)), */
                      hintText: 'Reason for Leave',
                      labelStyle: TextStyle(
                          fontSize: labelFontSize, color: labelFontColor),
                      hintStyle: hintTextStyle),
                  validator: (value) {
                    if (value != null && value == "") {
                      return 'Please enter reason for leave';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                decoration: boxDecoration,
                child: TextFormField(
                  controller: _remarksController,
                  decoration: InputDecoration(
                      labelText: 'Remarks',
                      contentPadding: contentPadding,
                      prefixIcon: Icon(
                        CupertinoIcons.pen,
                        color: iconColor,
                      ),
                      border: InputBorder.none,
                      /* focusedBorder: OutlineInputBorder(
                        borderRadius: borderRadius,
                        borderSide:
                            BorderSide(color: borderColor, width: borderWidth)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: borderRadius,
                        borderSide:
                            BorderSide(color: borderColor, width: borderWidth)), */
                      hintText: 'Remarks',
                      labelStyle: TextStyle(
                          fontSize: labelFontSize, color: labelFontColor),
                      hintStyle: hintTextStyle),
                ),
              ),
//              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    backgroundColor: actionButtonBgColor,
                    foregroundColor: actionButtonFgColor),
                onPressed: () {
                  // Handle apply button press
                  // You can access the values using controller.text for each field
                },
                child: const Text(
                  'Apply',
                  style: TextStyle(fontSize: 25),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
