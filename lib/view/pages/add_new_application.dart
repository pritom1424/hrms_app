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
  double smallLabelFontSize = 12;
  double labelFontSize = 18;
  Color labelFontColor = Colors.grey;

  TextStyle hintTextStyle = TextStyle(color: Colors.grey.withOpacity(0.5));

  Color iconColor = Colors.grey;

  // action button
  Color actionButtonBgColor = const Color.fromARGB(255, 68, 156, 204);
  Color actionButtonFgColor = Colors.white;

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
      appBar: (widget.title == null)
          ? null
          : AppbarDefault(
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
                    ),
                  ],
                ),
              ),
              SizedBox(
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: boxDecoration,
                        child: TextFormField(
                          controller: _employeeIdController,
                          decoration: InputDecoration(
                            labelText: 'Employee ID',
                            contentPadding: contentPadding,
                            prefixIcon: Icon(
                              Icons.person,
                              color: iconColor,
                            ),
                            hintStyle: hintTextStyle,
                            border: InputBorder.none,
                            /*  focusedBorder: OutlineInputBorder(
                                borderRadius: borderRadius,
                                borderSide: BorderSide(
                                    color: borderColor, width: borderWidth)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: borderRadius,
                                borderSide: BorderSide(
                                    color: borderColor, width: borderWidth)), */
                            hintText: 'Employee ID',
                            labelStyle: TextStyle(
                                fontSize: smallLabelFontSize,
                                color: labelFontColor),
                          ),
                          validator: (value) {
                            if (value != null && value == "") {
                              return 'Please enter employee ID';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Container(
                        decoration: boxDecoration,
                        child: TextFormField(
                          controller: _employeeCodeController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Employee Code',
                            contentPadding: contentPadding,
                            prefixIcon: Icon(
                              Icons.code,
                              color: iconColor,
                            ),
                            border: InputBorder.none,
                            /* focusedBorder: OutlineInputBorder(
                                borderRadius: borderRadius,
                                borderSide: BorderSide(
                                    color: borderColor, width: borderWidth)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: borderRadius,
                                borderSide: BorderSide(
                                    color: borderColor, width: borderWidth)), */
                            hintText: 'Employee Code',
                            hintStyle: hintTextStyle,
                            labelStyle: TextStyle(
                                fontSize: smallLabelFontSize,
                                color: labelFontColor),
                          ),
                          validator: (value) {
                            if (value != null && value == "") {
                              return 'Please enter contact number';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                decoration: boxDecoration,
                child: TextFormField(
                  controller: _employeeNameController,
                  decoration: InputDecoration(
                    labelText: 'Employee Name',
                    contentPadding: contentPadding,
                    hintStyle: hintTextStyle,
                    prefixIcon: Icon(
                      Icons.abc,
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
                    hintText: 'Employee Name',
                    labelStyle: TextStyle(
                        fontSize: labelFontSize, color: labelFontColor),
                  ),
                ),
              ),
              Container(
                decoration: boxDecoration,
                child: TextFormField(
                  controller: _employeePhoneController,
                  decoration: InputDecoration(
                    labelText: 'Phone',
                    contentPadding: contentPadding,
                    prefixIcon: Icon(
                      Icons.phone,
                      color: iconColor,
                    ),
                    border: InputBorder.none,
                    /*   focusedBorder: OutlineInputBorder(
                        borderRadius: borderRadius,
                        borderSide:
                            BorderSide(color: borderColor, width: borderWidth)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: borderRadius,
                        borderSide:
                            BorderSide(color: borderColor, width: borderWidth)), */
                    hintText: 'Phone',
                    hintStyle: hintTextStyle,
                    labelStyle: TextStyle(
                        fontSize: labelFontSize, color: labelFontColor),
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
                decoration: boxDecoration,
                child: TextFormField(
                  controller: _employeeEmailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    contentPadding: contentPadding,
                    prefixIcon: Icon(
                      Icons.email,
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
                    hintText: 'Email',
                    hintStyle: hintTextStyle,
                    labelStyle: TextStyle(
                        fontSize: labelFontSize, color: labelFontColor),
                  ),
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
                  controller: _employeeWebsiteController,
                  decoration: InputDecoration(
                    labelText: 'Website',
                    contentPadding: contentPadding,
                    prefixIcon: Icon(
                      Icons.web,
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
                    hintText: 'Website',
                    hintStyle: hintTextStyle,
                    labelStyle: TextStyle(
                        fontSize: labelFontSize, color: labelFontColor),
                  ),
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
                  controller: _responsibleEmployeeNameController,
                  decoration: InputDecoration(
                    labelText: 'Responsible Person',
                    contentPadding: contentPadding,
                    hintStyle: hintTextStyle,
                    prefixIcon: Icon(
                      Icons.group,
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
                    hintText: 'Responsible Person',
                    labelStyle: TextStyle(
                        fontSize: labelFontSize, color: labelFontColor),
                  ),
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
                  controller: _responsibleEmployeePhoneController,
                  decoration: InputDecoration(
                    labelText: 'Responsible Person Number',
                    contentPadding: contentPadding,
                    prefixIcon: Icon(
                      Icons.phone_android,
                      color: iconColor,
                    ),
                    hintStyle: hintTextStyle,
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
                  ),
                ),
              ),
              Container(
                decoration: boxDecoration,
                child: TextFormField(
                  controller: _employeeAddressController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    labelText: 'Address',
                    contentPadding: contentPadding,
                    hintStyle: hintTextStyle,
                    prefixIcon: Icon(
                      Icons.home,
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
                    hintText: 'Address',
                    labelStyle: TextStyle(
                        fontSize: labelFontSize, color: labelFontColor),
                  ),
                  validator: (value) {
                    if (value != null && value == "") {
                      return 'Please enter reason for leave';
                    }
                    return null;
                  },
                ),
              ),

//              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: borderRadius,
                    ),
                    backgroundColor: actionButtonBgColor,
                    foregroundColor: actionButtonFgColor),
                onPressed: () {
                  // Handle apply button press
                  // You can access the values using controller.text for each field
                },
                child: const Text(
                  'Create',
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
