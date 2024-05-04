import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import '../../utils/app_variables/app_vars.dart';
import '../../utils/app_variables/image_paths.dart';
import '../widgets/appbar_default_widget.dart';
import 'package:image_picker/image_picker.dart';

enum Gender { male, female }

enum Nationality { bangladesh, india, pakistan }

enum IdType { nid, birth_certificate, passport }

enum Shift { morning, day, evening }

enum Department { reporter, editor, designer }

class AddNewApplicationForm extends StatefulWidget {
  final String? title;
  const AddNewApplicationForm({super.key, this.title});

  @override
  State<AddNewApplicationForm> createState() => _AddNewApplicationFormState();
}

class _AddNewApplicationFormState extends State<AddNewApplicationForm>
    with SingleTickerProviderStateMixin {
  final TextEditingController _employeeIdController = TextEditingController();
  final TextEditingController _employeePunchIdController =
      TextEditingController();

  final TextEditingController _employeeNameController = TextEditingController();

  final TextEditingController _employeeFatherNameController =
      TextEditingController();
  final TextEditingController _employeeMotherNameController =
      TextEditingController();

  final TextEditingController _employeePermanentAddressController =
      TextEditingController();
  final TextEditingController _employeePresentAddressController =
      TextEditingController();

  final TextEditingController _employeeDOBController = TextEditingController();

  late TabController tabController;
  /*************************************************************** */
  final TextEditingController _shiftDateController = TextEditingController();
  final TextEditingController _employeeDesignationController =
      TextEditingController();
  final TextEditingController _employeeJoiningDateController =
      TextEditingController();
  final TextEditingController _employeeConfirmDateController =
      TextEditingController();
  /*************************************************************** */

// form vars
  Gender _selectedGender = Gender.male;
  Nationality? _selectedNation;
  IdType? _selectedIdType;
  Shift? _selectedShift;
  Department? _selectedDepartment;

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
  Color labelFontColor = Colors.grey;

  TextStyle hintTextStyle = TextStyle(color: Colors.grey.withOpacity(0.5));

  Color iconColor = Colors.grey;

  // action button
  Color actionButtonBgColor = const Color.fromARGB(255, 68, 156, 204);
  Color actionButtonFgColor = Colors.white;

//date picker
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  File? _storedImage;
  Future<void> _clickOrChoosePhoto(ImageSource imageSource) async {
    final picker = ImagePicker();
    Navigator.of(context).pop();
    final imageFile = await picker.pickImage(
        source: imageSource, maxWidth: 600, imageQuality: 100);
    if (imageFile == null) {
      return;
    }

    setState(() {
      _storedImage = File(imageFile.path);
      //widget.onSelectImage(_storedImage);
    });
  }

  Future<void> _pictureButtonMethod() async {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => AlertDialog(
              title: Text(
                'Select/Click Profile Photo!',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              content: Text(
                "Select a method!",
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton.icon(
                        onPressed: () {
                          _clickOrChoosePhoto(ImageSource.camera);
                        },
                        icon: const Icon(Icons.camera_alt_rounded),
                        label: const Text("Camera")),
                    TextButton.icon(
                        onPressed: () {
                          _clickOrChoosePhoto(ImageSource.gallery);
                        },
                        icon: const Icon(Icons.photo),
                        label: const Text("Gallery"))
                  ],
                )
              ],
            ));
  }

  Future<void> _selectDate(BuildContext context,
      {DateTime? fDate, DateTime? lDate}) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: (fDate != null) ? fDate : DateTime(2015, 8),
      lastDate: (lDate != null) ? lDate : DateTime(2101),
    );
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
      });
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime)
      setState(() {
        _selectedTime = picked;
      });
  }

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _employeeIdController.dispose();
    _employeePunchIdController.dispose();
    _employeeNameController.dispose();
    _employeeFatherNameController.dispose();
    _employeeDesignationController.dispose();
    _employeeMotherNameController.dispose();
    _employeeDOBController.dispose();
    _employeePermanentAddressController.dispose();
    _employeePresentAddressController.dispose();
    _shiftDateController.dispose();
    _employeeJoiningDateController.dispose();
    _employeeConfirmDateController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  Widget employeeInfoTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: marginHeight),
          decoration: boxDecoration,
          child: TextFormField(
            controller: _employeeNameController,
            decoration: InputDecoration(
              labelText: 'Employee Name',
              contentPadding: contentPadding,
              hintStyle: hintTextStyle,
              /* prefixIcon: Icon(
                Icons.abc,
                color: iconColor,
              ), */
              border: InputBorder.none,
              hintText: 'Employee Name',
              labelStyle:
                  TextStyle(fontSize: labelFontSize, color: labelFontColor),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: marginHeight),
          decoration: boxDecoration,
          child: TextFormField(
            controller: _employeeFatherNameController,
            decoration: InputDecoration(
              labelText: 'Employee Father Name',
              contentPadding: contentPadding,
              hintStyle: hintTextStyle,
              /* prefixIcon: Icon(
                Icons.abc,
                color: iconColor,
              ), */
              border: InputBorder.none,
              hintText: 'Employee Father Name',
              labelStyle:
                  TextStyle(fontSize: labelFontSize, color: labelFontColor),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: marginHeight),
          decoration: boxDecoration,
          child: TextFormField(
            controller: _employeeMotherNameController,
            decoration: InputDecoration(
              labelText: 'Employee Mother Name',
              contentPadding: contentPadding,
              hintStyle: hintTextStyle,
              /* prefixIcon: Icon(
                Icons.abc,
                color: iconColor,
              ), */
              border: InputBorder.none,
              hintText: 'Employee Mother Name',
              labelStyle:
                  TextStyle(fontSize: labelFontSize, color: labelFontColor),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: marginHeight),
          padding: EdgeInsets.only(left: leftPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Gender",
                style: TextStyle(
                    fontSize: labelFontSize, fontWeight: FontWeight.bold),
              ),
              ToggleButtons(
                isSelected: _selectedGender == Gender.male
                    ? [true, false]
                    : _selectedGender == Gender.female
                        ? [false, true]
                        : [false, false],
                onPressed: (int index) {
                  setState(() {
                    _selectedGender = index == 0 ? Gender.male : Gender.female;
                  });
                },
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      children: [Icon(Icons.male), Text("male")],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      children: [Icon(Icons.female), Text("female")],
                    ),
                  ),
                ],
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
                  'Selected Date: ${DateFormat.yMd().format(_selectedDate)}', //${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day}
                  style: TextStyle(fontSize: labelFontSize),
                ),
                SizedBox(width: 20),
                TextButton(
                  onPressed: () => _selectDate(context, fDate: DateTime(1970)),
                  child: Text(
                    'Select Date',
                    style: TextStyle(fontSize: labelFontSize),
                  ),
                ),
              ],
            ) /* TextFormField(
            controller: _employeeDOBController,
            decoration: InputDecoration(
              labelText: 'Date Of Birth',
              contentPadding: contentPadding,
              /* prefixIcon: Icon(
                Icons.phone,
                color: iconColor,
              ), */
              border: InputBorder.none,
              hintText: 'Date Of Birth',
              hintStyle: hintTextStyle,
              labelStyle:
                  TextStyle(fontSize: labelFontSize, color: labelFontColor),
            ),
            validator: (value) {
              if (value != null && value == "") {
                return 'Please enter leave type';
              }
              return null;
            },
          ), */
            ),
        Container(
          padding: EdgeInsets.only(left: leftPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Nationality",
                style: TextStyle(
                    fontSize: labelFontSize, fontWeight: FontWeight.bold),
              ),
              DropdownButtonHideUnderline(
                child: Container(
                  padding: contentPadding,
                  margin: EdgeInsets.symmetric(vertical: marginHeight),
                  decoration: BoxDecoration(border: Border.all(width: 0.4)),
                  child: DropdownButton(
                      hint: Text(
                        "Choose nationality",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: labelFontSize, color: Colors.black54),
                      ),
                      value: _selectedNation,
                      items: Nationality.values
                          .map(
                            (nationality) => DropdownMenuItem(
                              value: nationality,
                              child: Text(
                                nationality.name.toUpperCase(),
                                style: const TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (val) {
                        if (val == null) {
                          return;
                        }
                        setState(() {
                          _selectedNation = val;
                        });
                      }),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: leftPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "ID Type",
                style: TextStyle(
                    fontSize: labelFontSize, fontWeight: FontWeight.bold),
              ),
              DropdownButtonHideUnderline(
                child: Container(
                  padding: contentPadding,
                  decoration: BoxDecoration(border: Border.all(width: 0.4)),
                  margin: EdgeInsets.symmetric(vertical: marginHeight),
                  child: DropdownButton(
                      hint: Text(
                        "Choose Id type",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: labelFontSize, color: Colors.black54),
                      ),
                      value: _selectedIdType,
                      items: IdType.values
                          .map(
                            (idType) => DropdownMenuItem(
                              value: idType,
                              child: Text(
                                idType.name.toUpperCase(),
                                style: const TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (val) {
                        if (val == null) {
                          return;
                        }
                        setState(() {
                          _selectedIdType = val;
                        });
                      }),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: marginHeight),
          decoration: boxDecoration,
          child: TextFormField(
            controller: _employeeIdController,
            decoration: InputDecoration(
              labelText: 'Id Number',
              contentPadding: contentPadding,
              /*  prefixIcon: Icon(
                Icons.phone,
                color: iconColor,
              ), */
              border: InputBorder.none,
              hintText: 'Id Number',
              hintStyle: hintTextStyle,
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
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: marginHeight),
          decoration: boxDecoration,
          child: TextFormField(
            controller: _employeePunchIdController,
            decoration: InputDecoration(
              labelText: 'Punch Id',
              contentPadding: contentPadding,
              /* prefixIcon: Icon(
                Icons.phone,
                color: iconColor,
              ), */
              border: InputBorder.none,
              hintText: 'Punch Id',
              hintStyle: hintTextStyle,
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
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: marginHeight),
          decoration: boxDecoration,
          child: TextFormField(
            controller: _employeePresentAddressController,
            maxLines: 3,
            decoration: InputDecoration(
              labelText: 'Present Address',
              contentPadding: contentPadding,
              hintStyle: hintTextStyle,
              /*  prefixIcon: Icon(
                Icons.home,
                color: iconColor,
              ), */
              border: InputBorder.none,
              hintText: 'Present Address',
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
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: marginHeight),
          decoration: boxDecoration,
          child: TextFormField(
            controller: _employeePermanentAddressController,
            maxLines: 3,
            decoration: InputDecoration(
              labelText: 'Permanent Address',
              contentPadding: contentPadding,
              hintStyle: hintTextStyle,
              /* prefixIcon: Icon(
                Icons.home,
                color: iconColor,
              ), */
              border: InputBorder.none,
              hintText: 'Permanent Address',
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
        ),
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
    );
  }

  Widget officeInfoTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: marginHeight),
          decoration: boxDecoration,
          child: TextFormField(
            controller: _shiftDateController,
            decoration: InputDecoration(
              labelText: 'Shift Date',
              contentPadding: contentPadding,
              /* prefixIcon: Icon(
                Icons.phone,
                color: iconColor,
              ), */
              border: InputBorder.none,
              hintText: 'Shift Date',
              hintStyle: hintTextStyle,
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
        ),
        Container(
          padding: EdgeInsets.only(left: leftPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Shift",
                style: TextStyle(
                    fontSize: labelFontSize, fontWeight: FontWeight.bold),
              ),
              DropdownButtonHideUnderline(
                child: Container(
                  padding: contentPadding,
                  margin: EdgeInsets.symmetric(vertical: marginHeight),
                  decoration: BoxDecoration(border: Border.all(width: 0.4)),
                  child: DropdownButton(
                      hint: Text(
                        "Choose shift",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: labelFontSize, color: Colors.black54),
                      ),
                      value: _selectedShift,
                      items: Shift.values
                          .map(
                            (shift) => DropdownMenuItem(
                              value: shift,
                              child: Text(
                                shift.name.toUpperCase(),
                                style: const TextStyle(
                                  color: Colors.black,
                                ),
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
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: marginHeight),
          decoration: boxDecoration,
          child: TextFormField(
            controller: _employeeDesignationController,
            decoration: InputDecoration(
              labelText: 'Designation',
              contentPadding: contentPadding,
              hintStyle: hintTextStyle,
              /* prefixIcon: Icon(
                Icons.abc,
                color: iconColor,
              ), */
              border: InputBorder.none,
              hintText: 'Designation',
              labelStyle:
                  TextStyle(fontSize: labelFontSize, color: labelFontColor),
            ),
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
                  'Joining Date: ${DateFormat.yMd().format(_selectedDate)}', //${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day}
                  style: TextStyle(fontSize: labelFontSize),
                ),
                SizedBox(width: 20),
                TextButton(
                  onPressed: () => _selectDate(context),
                  child: Text(
                    'Select Date',
                    style: TextStyle(fontSize: labelFontSize),
                  ),
                ),
              ],
            ) /* TextFormField(
            controller: _employeeJoiningDateController,
            decoration: InputDecoration(
              labelText: 'Joining Date',
              contentPadding: contentPadding,
              /* prefixIcon: Icon(
                Icons.phone,
                color: iconColor,
              ), */
              border: InputBorder.none,
              hintText: 'Joining Date',
              hintStyle: hintTextStyle,
              labelStyle:
                  TextStyle(fontSize: labelFontSize, color: labelFontColor),
            ),
            validator: (value) {
              if (value != null && value == "") {
                return 'Please enter leave type';
              }
              return null;
            },
          ), */
            ),
        Container(
            margin: EdgeInsets.symmetric(vertical: marginHeight),
            padding: EdgeInsets.only(left: leftPadding),
            decoration: boxDecoration,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Confirmation Date: ${DateFormat.yMd().format(_selectedDate)}', //${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day}
                  style: TextStyle(fontSize: labelFontSize),
                ),
                SizedBox(width: 20),
                TextButton(
                  onPressed: () => _selectDate(
                    context,
                  ),
                  child: Text(
                    'Select Date',
                    style: TextStyle(fontSize: labelFontSize),
                  ),
                ),
              ],
            )

            /* TextFormField(
            controller: _employeeConfirmDateController,
            decoration: InputDecoration(
              labelText: 'Confirmation Date',
              contentPadding: contentPadding,
              /* prefixIcon: Icon(
                Icons.phone,
                color: iconColor,
              ), */
              border: InputBorder.none,
              hintText: 'Confirmation Date',
              hintStyle: hintTextStyle,
              labelStyle:
                  TextStyle(fontSize: labelFontSize, color: labelFontColor),
            ),
            validator: (value) {
              if (value != null && value == "") {
                return 'Please enter leave type';
              }
              return null;
            },
          ), */
            ),
        Container(
          padding: EdgeInsets.only(left: leftPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Department",
                style: TextStyle(
                    fontSize: labelFontSize, fontWeight: FontWeight.bold),
              ),
              DropdownButtonHideUnderline(
                child: Container(
                  padding: contentPadding,
                  decoration: BoxDecoration(border: Border.all(width: 0.4)),
                  margin: EdgeInsets.symmetric(vertical: marginHeight),
                  child: DropdownButton(
                      hint: Text(
                        "Choose department",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: labelFontSize, color: Colors.black54),
                      ),
                      value: _selectedDepartment,
                      items: Department.values
                          .map(
                            (department) => DropdownMenuItem(
                              value: department,
                              child: Text(
                                department.name.toUpperCase(),
                                style: const TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (val) {
                        if (val == null) {
                          return;
                        }
                        setState(() {
                          _selectedDepartment = val;
                        });
                      }),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: marginHeight),
          decoration: boxDecoration,
          child: TextFormField(
            controller: _employeeIdController,
            decoration: InputDecoration(
              labelText: 'Id Number',
              contentPadding: contentPadding,
              /*  prefixIcon: Icon(
                Icons.phone,
                color: iconColor,
              ), */
              border: InputBorder.none,
              hintText: 'Id Number',
              hintStyle: hintTextStyle,
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
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: marginHeight),
          decoration: boxDecoration,
          child: TextFormField(
            controller: _employeePunchIdController,
            decoration: InputDecoration(
              labelText: 'Punch Id',
              contentPadding: contentPadding,
              /* prefixIcon: Icon(
                Icons.phone,
                color: iconColor,
              ), */
              border: InputBorder.none,
              hintText: 'Punch Id',
              hintStyle: hintTextStyle,
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
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: marginHeight),
          decoration: boxDecoration,
          child: TextFormField(
            controller: _employeePresentAddressController,
            maxLines: 3,
            decoration: InputDecoration(
              labelText: 'Present Address',
              contentPadding: contentPadding,
              hintStyle: hintTextStyle,
              /*  prefixIcon: Icon(
                Icons.home,
                color: iconColor,
              ), */
              border: InputBorder.none,
              hintText: 'Present Address',
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
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: marginHeight),
          decoration: boxDecoration,
          child: TextFormField(
            controller: _employeePermanentAddressController,
            maxLines: 3,
            decoration: InputDecoration(
              labelText: 'Permanent Address',
              contentPadding: contentPadding,
              hintStyle: hintTextStyle,
              /* prefixIcon: Icon(
                Icons.home,
                color: iconColor,
              ), */
              border: InputBorder.none,
              hintText: 'Permanent Address',
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
        ),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (widget.title == null)
          ? null
          : AppbarDefault(
              appbarName: widget.title,
            ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        /*    
        height: AppVars.screenSize.height * 0.9, */
        child: Column(
          //   mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: (_storedImage != null)
                        ? FileImage(_storedImage!)
                        : null,
                    backgroundColor: Color(0xFFFFCFDA),
                  ),
                  TextButton(
                    onPressed: _pictureButtonMethod,
                    child: Text(
                      (_storedImage == null)
                          ? "Add Profile Picture"
                          : "Update Profile Picture",
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            TabBar(
                labelStyle: Theme.of(context)
                    .textTheme
                    .headlineSmall /* TextStyle(fontSize: 17, fontWeight: FontWeight.bold) */,
                controller: tabController,
                isScrollable: false,
                tabs: const [
                  Tab(
                    icon: Text(
                      'Employee Information',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  Tab(
                    icon: Text(
                      'Office Information',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ]),
            Expanded(
              //  height: AppVars.screenSize.height * 0.6,
              child: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  controller: tabController,
                  children: [
                    SingleChildScrollView(child: employeeInfoTab()),
                    SingleChildScrollView(child: officeInfoTab())
                  ]),
            ),

            //              const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
 /* focusedBorder: OutlineInputBorder(
                        borderRadius: borderRadius,
                        borderSide:
                            BorderSide(color: borderColor, width: borderWidth)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: borderRadius,
                        borderSide:
                            BorderSide(color: borderColor, width: borderWidth)), */
 /* Container(
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
              ), */
              /* Container(
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
              ), */

               /*  SizedBox(
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
              ), */