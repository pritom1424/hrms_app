import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hrms_app/utils/app_colors/app_colors.dart';
import 'package:hrms_app/utils/app_variables/app_strings.dart';
import 'package:hrms_app/utils/app_variables/image_paths.dart';

import 'package:intl/intl.dart';
import '../../../utils/app_variables/app_vars.dart';

import '../../widgets/appbar_default_widget.dart';
import 'package:image_picker/image_picker.dart';
import '../../../utils/enums/enums.dart';

class AddNewApplicationForm extends StatefulWidget {
  final String? title;
  const AddNewApplicationForm({super.key, this.title});

  @override
  State<AddNewApplicationForm> createState() => _AddNewApplicationFormState();
}

class _AddNewApplicationFormState extends State<AddNewApplicationForm>
    with SingleTickerProviderStateMixin {
  final _formPersonalInfoKey = GlobalKey<FormState>();
  final _formOfficialInfoKey = GlobalKey<FormState>();
  //.........................................................///
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

  BorderRadius borderRadius = const BorderRadius.all(Radius.circular(10));
  Color borderColor = const Color.fromARGB(255, 189, 183, 183);
  double borderWidth = 1;
  double marginHeight = 5;
  double leftPadding = 20;

  //font related
  double smallLabelFontSize = 12;
  double labelFontSize = 18;
  double mediumLabelFontSize = 15;
  Color labelFontColor = Colors.grey;

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
    return Form(
      key: _formPersonalInfoKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: marginHeight),
            decoration: AppVars.customInputboxDecoration,
            child: TextFormField(
              controller: _employeeNameController,
              decoration: InputDecoration(
                labelText: 'Employee Name',
                contentPadding: AppVars.inputContentPadding,
                hintStyle: AppVars.customHintTextStyle,
                /* prefixIcon: Icon(
                  Icons.abc,
                  color: iconColor,
                ), */
                border: InputBorder.none,
                hintText: 'Employee Name',
                labelStyle:
                    TextStyle(fontSize: labelFontSize, color: labelFontColor),
              ),
              validator: (val) => (val?.isEmpty ?? val == null)
                  ? AppStrings.nameErrorText
                  : null,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: marginHeight),
            decoration: AppVars.customInputboxDecoration,
            child: TextFormField(
              controller: _employeeFatherNameController,
              decoration: InputDecoration(
                labelText: 'Employee Father Name',
                contentPadding: AppVars.inputContentPadding,
                hintStyle: AppVars.customHintTextStyle,
                /* prefixIcon: Icon(
                  Icons.abc,
                  color: iconColor,
                ), */
                border: InputBorder.none,
                hintText: 'Employee Father Name',
                labelStyle:
                    TextStyle(fontSize: labelFontSize, color: labelFontColor),
              ),
              validator: (val) => (val?.isEmpty ?? val == null)
                  ? AppStrings.fatherNameErrorText
                  : null,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: marginHeight),
            decoration: AppVars.customInputboxDecoration,
            child: TextFormField(
              controller: _employeeMotherNameController,
              decoration: InputDecoration(
                labelText: 'Employee Mother Name',
                contentPadding: AppVars.inputContentPadding,
                hintStyle: AppVars.customHintTextStyle,
                /* prefixIcon: Icon(
                  Icons.abc,
                  color: iconColor,
                ), */
                border: InputBorder.none,
                hintText: 'Employee Mother Name',
                labelStyle:
                    TextStyle(fontSize: labelFontSize, color: labelFontColor),
              ),
              validator: (val) => (val?.isEmpty ?? val == null)
                  ? AppStrings.motherNameErrorText
                  : null,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: marginHeight),
            padding: EdgeInsets.only(left: leftPadding),
            //decoration: AppVars.customInputboxDecoration,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Text(
                    "Gender",
                    style: TextStyle(
                        fontSize: labelFontSize, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 10),
                    child: Container(
                      decoration: AppVars.customInputboxDecoration,
                      child: FittedBox(
                        child: ToggleButtons(
                          fillColor:
                              Appcolors.assignButtonColor.withOpacity(0.3),
                          //Appcolors.toggleButtonSelectColor,
                          borderRadius: BorderRadius.circular(10),
                          isSelected: _selectedGender == Gender.male
                              ? [true, false]
                              : _selectedGender == Gender.female
                                  ? [false, true]
                                  : [false, false],
                          onPressed: (int index) {
                            setState(() {
                              _selectedGender =
                                  index == 0 ? Gender.male : Gender.female;
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
              decoration: AppVars.customInputboxDecoration,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Date Of Birth: ${DateFormat.yMd().format(_selectedDate)}', //${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day}
                    style: TextStyle(fontSize: mediumLabelFontSize),
                  ),
                  SizedBox(width: 20),
                  TextButton(
                    onPressed: () =>
                        _selectDate(context, fDate: DateTime(1970)),
                    child: Text(
                      'Select Date',
                      style: TextStyle(fontSize: mediumLabelFontSize),
                    ),
                  ),
                ],
              )),
          Container(
            padding: EdgeInsets.only(left: leftPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    "Nationality",
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
                      child: DropdownButton(
                          padding: EdgeInsets.all(0),
                          hint: Text(
                            "Choose nationality",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                                fontSize: mediumLabelFontSize,
                                color: Colors.black54),
                          ),
                          value: _selectedNation,
                          items: Nationality.values
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
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: leftPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    "Id type",
                    style: TextStyle(
                        fontSize: labelFontSize, fontWeight: FontWeight.bold),
                  ),
                ),
                DropdownButtonHideUnderline(
                  child: Expanded(
                    flex: 2,
                    child: Container(
                      //   width: AppVars.screenSize.width * 0.60,
                      padding: AppVars.inputContentPadding,
                      decoration: AppVars
                          .customInputboxDecoration, //BoxDecoration(border: Border.all(width: 0.4)),
                      margin: EdgeInsets.symmetric(vertical: marginHeight),
                      child: DropdownButton(
                          hint: Text(
                            "Choose Id Type",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                                fontSize: mediumLabelFontSize,
                                color: Colors.black54),
                          ),
                          value: _selectedIdType,
                          items: IdType.values
                              .map(
                                (idtype) => DropdownMenuItem(
                                  value: idtype,
                                  child: Text(
                                    idtype.name.toUpperCase(),
                                    style:
                                        Theme.of(context).textTheme.labelSmall,
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
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: marginHeight),
            decoration: AppVars.customInputboxDecoration,
            child: TextFormField(
              controller: _employeeIdController,
              decoration: InputDecoration(
                labelText: 'Id Number',
                contentPadding: AppVars.inputContentPadding,
                /*  prefixIcon: Icon(
                  Icons.phone,
                  color: iconColor,
                ), */
                border: InputBorder.none,
                hintText: 'Id Number',
                hintStyle: AppVars.customHintTextStyle,
                labelStyle:
                    TextStyle(fontSize: labelFontSize, color: labelFontColor),
              ),
              validator: (value) {
                if (value != null && value == "") {
                  return AppStrings.idNumberErrorText;
                }
                return null;
              },
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: marginHeight),
            decoration: AppVars.customInputboxDecoration,
            child: TextFormField(
              controller: _employeePunchIdController,
              decoration: InputDecoration(
                labelText: 'Punch Id',
                contentPadding: AppVars.inputContentPadding,
                /* prefixIcon: Icon(
                  Icons.phone,
                  color: iconColor,
                ), */
                border: InputBorder.none,
                hintText: 'Punch Id',
                hintStyle: AppVars.customHintTextStyle,
                labelStyle:
                    TextStyle(fontSize: labelFontSize, color: labelFontColor),
              ),
              validator: (value) {
                if (value != null && value == "") {
                  return AppStrings.punchIdErrorText;
                }
                return null;
              },
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: marginHeight),
            decoration: AppVars.customInputboxDecoration,
            child: TextFormField(
              controller: _employeePresentAddressController,
              maxLines: 1,
              decoration: InputDecoration(
                labelText: 'Present Address',
                contentPadding: AppVars.inputContentPadding,
                hintStyle: AppVars.customHintTextStyle,
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
                  return AppStrings.presentAddressErrorText;
                }
                return null;
              },
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: marginHeight),
            decoration: AppVars.customInputboxDecoration,
            child: TextFormField(
              controller: _employeePermanentAddressController,
              maxLines: 1,
              decoration: InputDecoration(
                labelText: 'Permanent Address',
                contentPadding: AppVars.inputContentPadding,
                hintStyle: AppVars.customHintTextStyle,
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
                  return AppStrings.permanentAddressErrorText;
                }
                return null;
              },
            ),
          ),
          Container(
            //  decoration: AppVars.customInputboxDecoration,
            margin: EdgeInsets.symmetric(vertical: marginHeight),
            child: ExpansionTile(
              shape: Border(),
              title: Text("Self Access"),
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: marginHeight),
                  decoration: AppVars.customInputboxDecoration,
                  child: TextFormField(
                    // controller: _employeeNameController,
                    decoration: InputDecoration(
                      labelText: 'Employee Email',
                      contentPadding: AppVars.inputContentPadding,
                      hintStyle: AppVars.customHintTextStyle,
                      /* prefixIcon: Icon(
                    Icons.abc,
                    color: iconColor,
                  ), */
                      border: InputBorder.none,
                      hintText: 'Employee Email',
                      labelStyle: TextStyle(
                          fontSize: labelFontSize, color: labelFontColor),
                    ),
                    /* validator: (val) => (val?.isEmpty ?? val == null)
                        ? AppStrings.nameErrorText
                        : null, */
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: marginHeight),
                  decoration: AppVars.customInputboxDecoration,
                  child: TextFormField(
                    // controller: _employeeFatherNameController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Employee Password',
                      contentPadding: AppVars.inputContentPadding,
                      hintStyle: AppVars.customHintTextStyle,
                      /* prefixIcon: Icon(
                    Icons.abc,
                    color: iconColor,
                  ), */
                      border: InputBorder.none,
                      hintText: 'Employee Password',
                      labelStyle: TextStyle(
                          fontSize: labelFontSize, color: labelFontColor),
                    ),
                    /*  validator: (val) => (val?.isEmpty ?? val == null)
                        ? AppStrings.fatherNameErrorText
                        : null, */
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 5),
                shape: RoundedRectangleBorder(
                  borderRadius: borderRadius,
                ),
                backgroundColor: Appcolors.assignButtonColor,
                foregroundColor: actionButtonFgColor),
            onPressed: () {
              if (_formPersonalInfoKey.currentState == null) {
                return;
              }
              if (_formPersonalInfoKey.currentState!.validate()) {
                _formPersonalInfoKey.currentState!.save();
                // Do something with the validated data
                // print('Name: $_name');
              }

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
    );
  }

  Widget officeInfoTab() {
    return Form(
      key: _formOfficialInfoKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
              margin: EdgeInsets.symmetric(vertical: marginHeight),
              padding: EdgeInsets.only(left: leftPadding),
              decoration: AppVars.customInputboxDecoration,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Shift Date: ${DateFormat.yMd().format(_selectedDate)}', //${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day}
                    style: TextStyle(fontSize: mediumLabelFontSize),
                  ),
                  SizedBox(width: 20),
                  TextButton(
                    onPressed: () => _selectDate(context),
                    child: Text(
                      'Select Date',
                      style: TextStyle(fontSize: mediumLabelFontSize),
                    ),
                  ),
                ],
              )),
          Container(
            padding: EdgeInsets.only(left: leftPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    "Shift",
                    style: TextStyle(
                        fontSize: labelFontSize, fontWeight: FontWeight.bold),
                  ),
                ),
                DropdownButtonHideUnderline(
                  child: Expanded(
                    flex: 2,
                    child: Container(
                      //width: AppVars.screenSize.width * 0.55,
                      padding: AppVars.inputContentPadding,
                      margin: EdgeInsets.symmetric(vertical: marginHeight),
                      decoration: AppVars
                          .customInputboxDecoration, //BoxDecoration(border: Border.all(width: 0.4),),
                      child: DropdownButton(
                          hint: Text(
                            "Choose shift",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                                fontSize: mediumLabelFontSize,
                                color: Colors.black54),
                          ),
                          value: _selectedShift,
                          items: Shift.values
                              .map(
                                (shift) => DropdownMenuItem(
                                  value: shift,
                                  child: Text(
                                    shift.name.toUpperCase(),
                                    style:
                                        Theme.of(context).textTheme.labelSmall,
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
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: marginHeight),
            decoration: AppVars.customInputboxDecoration,
            child: TextFormField(
              controller: _employeeDesignationController,
              decoration: InputDecoration(
                labelText: 'Designation',
                contentPadding: AppVars.inputContentPadding,
                hintStyle: AppVars.customHintTextStyle,
                /* prefixIcon: Icon(
                  Icons.abc,
                  color: iconColor,
                ), */
                border: InputBorder.none,
                hintText: 'Designation',
                labelStyle:
                    TextStyle(fontSize: labelFontSize, color: labelFontColor),
              ),
              validator: (value) {
                if (value != null && value == "") {
                  return AppStrings.designationErrorText;
                }
                return null;
              },
            ),
          ),
          Container(
              margin: EdgeInsets.symmetric(vertical: marginHeight),
              padding: EdgeInsets.only(left: leftPadding),
              decoration: AppVars.customInputboxDecoration,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Joining Date: ${DateFormat.yMd().format(_selectedDate)}', //${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day}
                    style: TextStyle(fontSize: mediumLabelFontSize),
                  ),
                  SizedBox(width: 20),
                  TextButton(
                    onPressed: () => _selectDate(context),
                    child: Text(
                      'Select Date',
                      style: TextStyle(fontSize: mediumLabelFontSize),
                    ),
                  ),
                ],
              )),
          Container(
              margin: EdgeInsets.symmetric(vertical: marginHeight),
              padding: EdgeInsets.only(left: leftPadding),
              decoration: AppVars.customInputboxDecoration,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Confirmation Date: ${DateFormat.yMd().format(_selectedDate)}', //${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day}
                    style: TextStyle(fontSize: mediumLabelFontSize),
                  ),
                  SizedBox(width: 20),
                  TextButton(
                    onPressed: () => _selectDate(
                      context,
                    ),
                    child: Text(
                      'Select Date',
                      style: TextStyle(fontSize: mediumLabelFontSize),
                    ),
                  ),
                ],
              )),
          Container(
            padding: EdgeInsets.only(left: leftPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    "Department",
                    style: TextStyle(
                        fontSize: labelFontSize, fontWeight: FontWeight.bold),
                  ),
                ),
                DropdownButtonHideUnderline(
                  child: Expanded(
                    flex: 2,
                    child: Container(
                      //   width: AppVars.screenSize.width * 0.55,
                      padding: AppVars.inputContentPadding,
                      decoration: AppVars
                          .customInputboxDecoration, //BoxDecoration(border: Border.all(width: 0.4)),
                      margin: EdgeInsets.symmetric(vertical: marginHeight),
                      child: DropdownButton(
                          hint: Text(
                            "Choose department",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                                fontSize: mediumLabelFontSize,
                                color: Colors.black54),
                          ),
                          value: _selectedDepartment,
                          items: Department.values
                              .map(
                                (department) => DropdownMenuItem(
                                  value: department,
                                  child: Text(
                                    department.name.toUpperCase(),
                                    style:
                                        Theme.of(context).textTheme.labelSmall,
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
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: marginHeight),
            decoration: AppVars.customInputboxDecoration,
            child: TextFormField(
              controller: _employeeIdController,
              decoration: InputDecoration(
                labelText: 'Id Number',
                contentPadding: AppVars.inputContentPadding,
                /*  prefixIcon: Icon(
                  Icons.phone,
                  color: iconColor,
                ), */
                border: InputBorder.none,
                hintText: 'Id Number',
                hintStyle: AppVars.customHintTextStyle,
                labelStyle:
                    TextStyle(fontSize: labelFontSize, color: labelFontColor),
              ),
              validator: (value) {
                if (value != null && value == "") {
                  return AppStrings.idNumberErrorText;
                }
                return null;
              },
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: marginHeight),
            decoration: AppVars.customInputboxDecoration,
            child: TextFormField(
              controller: _employeePunchIdController,
              decoration: InputDecoration(
                labelText: 'Punch Id',
                contentPadding: AppVars.inputContentPadding,
                /* prefixIcon: Icon(
                  Icons.phone,
                  color: iconColor,
                ), */
                border: InputBorder.none,
                hintText: 'Punch Id',
                hintStyle: AppVars.customHintTextStyle,
                labelStyle:
                    TextStyle(fontSize: labelFontSize, color: labelFontColor),
              ),
              validator: (value) {
                if (value != null && value == "") {
                  return AppStrings.punchIdErrorText;
                }
                return null;
              },
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: marginHeight),
            decoration: AppVars.customInputboxDecoration,
            child: TextFormField(
              controller: _employeePresentAddressController,
              maxLines: 1,
              decoration: InputDecoration(
                labelText: 'Present Address',
                contentPadding: AppVars.inputContentPadding,
                hintStyle: AppVars.customHintTextStyle,
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
                  return AppStrings.presentAddressErrorText;
                }
                return null;
              },
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: marginHeight),
            decoration: AppVars.customInputboxDecoration,
            child: TextFormField(
              controller: _employeePermanentAddressController,
              maxLines: 1,
              decoration: InputDecoration(
                labelText: 'Permanent Address',
                contentPadding: AppVars.inputContentPadding,
                hintStyle: AppVars.customHintTextStyle,
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
                  return AppStrings.permanentAddressErrorText;
                }
                return null;
              },
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 5),
                shape: RoundedRectangleBorder(
                  borderRadius: borderRadius,
                ),
                backgroundColor: Appcolors.assignButtonColor,
                foregroundColor: actionButtonFgColor),
            onPressed: () {
              if (_formOfficialInfoKey.currentState == null) {
                return;
              }
              if (_formOfficialInfoKey.currentState!.validate()) {
                _formOfficialInfoKey.currentState!.save();
                // Do something with the validated data
                //print('Name: $_name');
              }
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
    );
  }

  @override
  Widget build(BuildContext context) {
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
                        : AssetImage(ImagePath.proPicPlaceholderPath)
                            as ImageProvider,
                    //  backgroundColor: Color(0xFFFFCFDA),
                  ),
                  TextButton(
                    onPressed: _pictureButtonMethod,
                    child: Text(
                      (_storedImage == null)
                          ? "Add Profile Picture"
                          : "Update Profile Picture",
                      style: const TextStyle(
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
                    SingleChildScrollView(
                        padding: EdgeInsets.all(0), child: employeeInfoTab()),
                    SingleChildScrollView(
                        padding: EdgeInsets.all(0), child: officeInfoTab())
                  ]),
            ),

            //              const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
