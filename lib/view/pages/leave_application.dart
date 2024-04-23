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
                decoration: const InputDecoration(
                  labelText: 'Employee ID',
                  contentPadding: EdgeInsets.only(left: 10),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 189, 183, 183),
                          width: 1.5)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 189, 183, 183),
                          width: 1.5)),
                  hintText: 'Employee ID',
                  labelStyle: TextStyle(fontSize: 18, color: Colors.grey),
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
                decoration: const InputDecoration(
                  labelText: 'Contact No',
                  contentPadding: EdgeInsets.only(left: 10),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 189, 183, 183),
                          width: 1.5)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 189, 183, 183),
                          width: 1.5)),
                  hintText: 'Contact No',
                  labelStyle: TextStyle(fontSize: 18, color: Colors.grey),
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
                decoration: const InputDecoration(
                  labelText: 'Responsible Employee ID',
                  contentPadding: EdgeInsets.only(left: 10),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 189, 183, 183),
                          width: 1.5)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 189, 183, 183),
                          width: 1.5)),
                  hintText: 'Responsible Employee ID',
                  labelStyle: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ),
              TextFormField(
                controller: _leaveTypeController,
                decoration: const InputDecoration(
                  labelText: 'Leave Type',
                  contentPadding: EdgeInsets.only(left: 10),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 189, 183, 183),
                          width: 1.5)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 189, 183, 183),
                          width: 1.5)),
                  hintText: 'Leave Type',
                  labelStyle: TextStyle(fontSize: 18, color: Colors.grey),
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
                decoration: const InputDecoration(
                  labelText: 'Start Date',
                  contentPadding: EdgeInsets.only(left: 10),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 189, 183, 183),
                          width: 1.5)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 189, 183, 183),
                          width: 1.5)),
                  hintText: 'Start Date',
                  labelStyle: TextStyle(fontSize: 18, color: Colors.grey),
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
                decoration: const InputDecoration(
                  labelText: 'End Date',
                  contentPadding: EdgeInsets.only(left: 10),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 189, 183, 183),
                          width: 1.5)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 189, 183, 183),
                          width: 1.5)),
                  hintText: 'End Date',
                  labelStyle: TextStyle(fontSize: 18, color: Colors.grey),
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
                decoration: const InputDecoration(
                  labelText: 'Total Leave Days',
                  contentPadding: EdgeInsets.only(left: 10),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 189, 183, 183),
                          width: 1.5)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 189, 183, 183),
                          width: 1.5)),
                  hintText: 'Total Leave Days',
                  labelStyle: TextStyle(fontSize: 18, color: Colors.grey),
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
                decoration: const InputDecoration(
                  labelText: 'Address During Leave',
                  contentPadding: EdgeInsets.only(left: 10),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 189, 183, 183),
                          width: 1.5)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 189, 183, 183),
                          width: 1.5)),
                  hintText: 'Address During Leave',
                  labelStyle: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ),
              TextFormField(
                controller: _reasonForLeaveController,
                decoration: const InputDecoration(
                  labelText: 'Reason for Leave',
                  contentPadding: EdgeInsets.only(left: 10),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 189, 183, 183),
                          width: 1.5)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 189, 183, 183),
                          width: 1.5)),
                  hintText: 'Reason for Leave',
                  labelStyle: TextStyle(fontSize: 18, color: Colors.grey),
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
                decoration: const InputDecoration(
                  labelText: 'Remarks',
                  contentPadding: EdgeInsets.only(left: 10),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 189, 183, 183),
                          width: 1.5)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 189, 183, 183),
                          width: 1.5)),
                  hintText: 'Remarks',
                  labelStyle: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ),
//              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    backgroundColor: Color.fromARGB(255, 68, 156, 204),
                    foregroundColor: Colors.white),
                onPressed: () {
                  // Handle apply button press
                  // You can access the values using controller.text for each field
                },
                child: Text(
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
