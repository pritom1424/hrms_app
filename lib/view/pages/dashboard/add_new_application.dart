import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hrms_app/utils/app_variables/app_vars.dart';
import 'package:hrms_app/utils/app_variables/image_paths.dart';
import 'package:hrms_app/view/widgets/appbar_default_widget.dart';

class AddNewApplicationForm extends StatefulWidget {
  final String? title;
  const AddNewApplicationForm({super.key, this.title});

  @override
  State<AddNewApplicationForm> createState() => _AddNewApplicationFormState();
}

class _AddNewApplicationFormState extends State<AddNewApplicationForm> {
  final TextEditingController _employeeIdController = TextEditingController();
  final TextEditingController _employeeCodeController = TextEditingController();

  final TextEditingController _employeeNameController = TextEditingController();
  final TextEditingController _employeePhoneController =
      TextEditingController();
  final TextEditingController _employeeEmailController =
      TextEditingController();
  final TextEditingController _employeeWebsiteController =
      TextEditingController();
  final TextEditingController _responsibleEmployeeNameController =
      TextEditingController();
  final TextEditingController _responsibleEmployeePhoneController =
      TextEditingController();
  final TextEditingController _employeeAddressController =
      TextEditingController();
  @override
  void dispose() {
    _employeeIdController.dispose();
    _employeeCodeController.dispose();
    _employeeNameController.dispose();
    _employeeEmailController.dispose();
    _employeePhoneController.dispose();
    _employeeWebsiteController.dispose();
    _responsibleEmployeeNameController.dispose();
    _responsibleEmployeePhoneController.dispose();
    _employeeAddressController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarDefault(
        appbarName: widget.title,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(0),
        child: Container(
          padding:
              const EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 2),
          height: AppVars.screenSize.height * 0.9,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage(ImagePath.proPicPath),
                    ),
                    const Text(
                      "Add Profile Picture",
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              SizedBox(
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _employeeIdController,
                        decoration: const InputDecoration(
                          labelText: 'Employee ID',
                          contentPadding: EdgeInsets.only(left: 10),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 189, 183, 183),
                                  width: 1.5)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 189, 183, 183),
                                  width: 1.5)),
                          hintText: 'Employee ID',
                          labelStyle:
                              TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                        validator: (value) {
                          if (value != null && value == "") {
                            return 'Please enter employee ID';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: _employeeCodeController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Employee Code',
                          contentPadding: EdgeInsets.only(left: 10),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 189, 183, 183),
                                  width: 1.5)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 189, 183, 183),
                                  width: 1.5)),
                          hintText: 'Employee Code',
                          labelStyle:
                              TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                        validator: (value) {
                          if (value != null && value == "") {
                            return 'Please enter contact number';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),

              TextFormField(
                controller: _employeeNameController,
                decoration: const InputDecoration(
                  labelText: 'Employee Name',
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
                  hintText: 'Employee Name',
                  labelStyle: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ),
              TextFormField(
                controller: _employeePhoneController,
                decoration: const InputDecoration(
                  labelText: 'Phone',
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
                  hintText: 'Phone',
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
                controller: _employeeEmailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
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
                  hintText: 'Email',
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
                controller: _employeeWebsiteController,
                decoration: const InputDecoration(
                  labelText: 'Website',
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
                  hintText: 'Website',
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
                controller: _responsibleEmployeeNameController,
                decoration: const InputDecoration(
                  labelText: 'Responsible Person',
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
                  hintText: 'Responsible Person',
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
                controller: _responsibleEmployeePhoneController,
                decoration: const InputDecoration(
                  labelText: 'Responsible Person Number',
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
                controller: _employeeAddressController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Address',
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
                  hintText: 'Address',
                  labelStyle: TextStyle(fontSize: 18, color: Colors.grey),
                ),
                validator: (value) {
                  if (value != null && value == "") {
                    return 'Please enter reason for leave';
                  }
                  return null;
                },
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
                  'Create',
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
