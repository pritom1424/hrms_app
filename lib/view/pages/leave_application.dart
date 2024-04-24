import 'package:flutter/material.dart';
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
  BorderRadius borderRadius = const BorderRadius.all(Radius.circular(20));
  Color borderColor = const Color.fromARGB(255, 189, 183, 183);
  double borderWidth = 1.5;

  //font related
  double labelFontSize = 18;
  Color labelFontColor = Colors.grey;

  // action button
  Color actionButtonBgColor = const Color.fromARGB(255, 68, 156, 204);
  Color actionButtonFgColor = Colors.white;
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
      appBar: AppbarDefault(
        appbarName: widget.title,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          height: AppVars.screenSize.height * 0.9,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextFormField(
                autofocus: false,
                controller: _employeeIdController,
                decoration: InputDecoration(
                  labelText: 'Employee ID',
                  contentPadding: contentPadding,
                  focusedBorder: OutlineInputBorder(
                      borderRadius: borderRadius,
                      borderSide:
                          BorderSide(color: borderColor, width: borderWidth)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: borderRadius,
                      borderSide:
                          BorderSide(color: borderColor, width: borderWidth)),
                  hintText: 'Employee ID',
                  labelStyle:
                      TextStyle(fontSize: labelFontSize, color: labelFontColor),
                ),
                validator: (value) {
                  if (value != null && value == "") {
                    return 'Please enter employee ID';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _contactNoController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Contact No',
                  contentPadding: contentPadding,
                  focusedBorder: OutlineInputBorder(
                      borderRadius: borderRadius,
                      borderSide:
                          BorderSide(color: borderColor, width: borderWidth)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: borderRadius,
                      borderSide:
                          BorderSide(color: borderColor, width: borderWidth)),
                  hintText: 'Contact No',
                  labelStyle:
                      TextStyle(fontSize: labelFontSize, color: labelFontColor),
                ),
                validator: (value) {
                  if (value != null && value == "") {
                    return 'Please enter contact number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _responsibleEmployeeIdController,
                decoration: InputDecoration(
                  labelText: 'Responsible Employee ID',
                  contentPadding: contentPadding,
                  focusedBorder: OutlineInputBorder(
                      borderRadius: borderRadius,
                      borderSide:
                          BorderSide(color: borderColor, width: borderWidth)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: borderRadius,
                      borderSide:
                          BorderSide(color: borderColor, width: borderWidth)),
                  hintText: 'Responsible Employee ID',
                  labelStyle:
                      TextStyle(fontSize: labelFontSize, color: labelFontColor),
                ),
              ),
              TextFormField(
                controller: _leaveTypeController,
                decoration: InputDecoration(
                  labelText: 'Leave Type',
                  contentPadding: contentPadding,
                  focusedBorder: OutlineInputBorder(
                      borderRadius: borderRadius,
                      borderSide:
                          BorderSide(color: borderColor, width: borderWidth)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: borderRadius,
                      borderSide:
                          BorderSide(color: borderColor, width: borderWidth)),
                  hintText: 'Leave Type',
                  labelStyle:
                      TextStyle(fontSize: labelFontSize, color: labelFontColor),
                ),
                validator: (value) {
                  if (value != null && value == "") {
                    return 'Please enter leave type';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _startDateController,
                decoration: InputDecoration(
                  labelText: 'Start Date',
                  contentPadding: contentPadding,
                  focusedBorder: OutlineInputBorder(
                      borderRadius: borderRadius,
                      borderSide:
                          BorderSide(color: borderColor, width: borderWidth)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: borderRadius,
                      borderSide:
                          BorderSide(color: borderColor, width: borderWidth)),
                  hintText: 'Start Date',
                  labelStyle:
                      TextStyle(fontSize: labelFontSize, color: labelFontColor),
                ),
                validator: (value) {
                  if (value != null && value == "") {
                    return 'Please enter start date';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _endDateController,
                decoration: InputDecoration(
                  labelText: 'End Date',
                  contentPadding: contentPadding,
                  focusedBorder: OutlineInputBorder(
                      borderRadius: borderRadius,
                      borderSide:
                          BorderSide(color: borderColor, width: borderWidth)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: borderRadius,
                      borderSide:
                          BorderSide(color: borderColor, width: borderWidth)),
                  hintText: 'End Date',
                  labelStyle:
                      TextStyle(fontSize: labelFontSize, color: labelFontColor),
                ),
                validator: (value) {
                  if (value != null && value == "") {
                    return 'Please enter end date';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _totalLeaveDaysController,
                decoration: InputDecoration(
                  labelText: 'Total Leave Days',
                  contentPadding: contentPadding,
                  focusedBorder: OutlineInputBorder(
                      borderRadius: borderRadius,
                      borderSide:
                          BorderSide(color: borderColor, width: borderWidth)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: borderRadius,
                      borderSide:
                          BorderSide(color: borderColor, width: borderWidth)),
                  hintText: 'Total Leave Days',
                  labelStyle:
                      TextStyle(fontSize: labelFontSize, color: labelFontColor),
                ),
                validator: (value) {
                  if (value != null && value == "") {
                    return 'Please enter total leave days';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _addressDuringLeaveController,
                decoration: InputDecoration(
                  labelText: 'Address During Leave',
                  contentPadding: contentPadding,
                  focusedBorder: OutlineInputBorder(
                      borderRadius: borderRadius,
                      borderSide:
                          BorderSide(color: borderColor, width: borderWidth)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: borderRadius,
                      borderSide:
                          BorderSide(color: borderColor, width: borderWidth)),
                  hintText: 'Address During Leave',
                  labelStyle:
                      TextStyle(fontSize: labelFontSize, color: labelFontColor),
                ),
              ),
              TextFormField(
                controller: _reasonForLeaveController,
                decoration: InputDecoration(
                  labelText: 'Reason for Leave',
                  contentPadding: contentPadding,
                  focusedBorder: OutlineInputBorder(
                      borderRadius: borderRadius,
                      borderSide:
                          BorderSide(color: borderColor, width: borderWidth)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: borderRadius,
                      borderSide:
                          BorderSide(color: borderColor, width: borderWidth)),
                  hintText: 'Reason for Leave',
                  labelStyle:
                      TextStyle(fontSize: labelFontSize, color: labelFontColor),
                ),
                validator: (value) {
                  if (value != null && value == "") {
                    return 'Please enter reason for leave';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _remarksController,
                decoration: InputDecoration(
                  labelText: 'Remarks',
                  contentPadding: contentPadding,
                  focusedBorder: OutlineInputBorder(
                      borderRadius: borderRadius,
                      borderSide:
                          BorderSide(color: borderColor, width: borderWidth)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: borderRadius,
                      borderSide:
                          BorderSide(color: borderColor, width: borderWidth)),
                  hintText: 'Remarks',
                  labelStyle:
                      TextStyle(fontSize: labelFontSize, color: labelFontColor),
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
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
