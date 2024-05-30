import 'dart:io';

import 'package:flutter/material.dart';

import 'package:hrms_app/controller/employee_data_controller.dart';
import 'package:hrms_app/model/hrms_employee_model.dart';
import 'package:hrms_app/model/hrms_employee_post_model.dart';
import 'package:hrms_app/utils/app_methods/app_methods.dart';
import 'package:hrms_app/utils/app_variables/api_links.dart';
import 'package:hrms_app/view/pages/employee/employee_table.dart';
import 'package:provider/provider.dart';
import '../../../utils/app_colors/app_colors.dart';
import '../../../utils/app_variables/app_strings.dart';
import '../../../utils/app_variables/image_paths.dart';

import 'package:intl/intl.dart';
import '../../../utils/app_variables/app_vars.dart';

import '../../widgets/appbar_default_widget.dart';
import 'package:image_picker/image_picker.dart';
import '../../../utils/enums/enums.dart';

class AddNewApplicationForm extends StatefulWidget {
  final String? title;
  final bool? isReplace;
  final bool? isPop;
  const AddNewApplicationForm(
      {super.key, this.title, this.isReplace, this.isPop});

  @override
  State<AddNewApplicationForm> createState() => _AddNewApplicationFormState();
}

class _AddNewApplicationFormState extends State<AddNewApplicationForm>
    with SingleTickerProviderStateMixin {
  final _formPersonalInfoKey = GlobalKey<FormState>();
  final _formOfficialInfoKey = GlobalKey<FormState>();
  final TextEditingController _employeeEmailController =
      TextEditingController();
  final TextEditingController _employeePassController = TextEditingController();

  final TextEditingController _employeeIdController = TextEditingController();
  final TextEditingController _employeePunchIdController =
      TextEditingController();

  final TextEditingController _employeeNameController = TextEditingController();

  final TextEditingController _employeeFatherNameController =
      TextEditingController();
  final TextEditingController _employeeMotherNameController =
      TextEditingController();
  final TextEditingController _employeePhoneNumberController =
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
  String? _selectedNation;
  String? _selectedIdType;
  String? _selectedShift;
  int? _selectedDepartment;

  String? _selectSelfAccess;

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
  DateTime _selectedShiftDate = DateTime.now();
  DateTime _selectedJoiningDate = DateTime.now();
  DateTime _selectedConfirmationDate = DateTime.now();

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

  Future<void> _selectJoiningDate(BuildContext context,
      {DateTime? fDate, DateTime? lDate}) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedJoiningDate,
      firstDate: (fDate != null) ? fDate : DateTime(2015, 8),
      lastDate: (lDate != null) ? lDate : DateTime(2101),
    );
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedJoiningDate = picked;
      });
  }

  Future<void> _selectShiftDate(BuildContext context,
      {DateTime? fDate, DateTime? lDate}) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedShiftDate,
      firstDate: (fDate != null) ? fDate : DateTime(2015, 8),
      lastDate: (lDate != null) ? lDate : DateTime(2101),
    );
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedShiftDate = picked;
      });
  }

  Future<void> _selectConfirmDate(BuildContext context,
      {DateTime? fDate, DateTime? lDate}) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedConfirmationDate,
      firstDate: (fDate != null) ? fDate : DateTime(2015, 8),
      lastDate: (lDate != null) ? lDate : DateTime(2101),
    );
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedConfirmationDate = picked;
      });
  }

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);

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
    _employeeEmailController.dispose();
    _employeePassController.dispose();
    _employeePhoneNumberController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  Widget employeeInfoTab(EmployeeDataController eControl) {
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
            decoration: AppVars.customInputboxDecoration,
            child: TextFormField(
              controller: _employeePhoneNumberController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Employee Phone Number',
                contentPadding: AppVars.inputContentPadding,
                hintStyle: AppVars.customHintTextStyle,
                /* prefixIcon: Icon(
                  Icons.abc,
                  color: iconColor,
                ), */
                border: InputBorder.none,
                hintText: 'Employee Phone Number',
                labelStyle:
                    TextStyle(fontSize: labelFontSize, color: labelFontColor),
              ),
              validator: (val) => (val?.isEmpty ?? val == null)
                  ? AppStrings.phoneNumberErrorText
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
                      child: FutureBuilder(
                        future: eControl
                            .getNationalityList(ApiLinks.nationalityLink),
                        builder: (ctx, nationSnap) => (!nationSnap.hasData)
                            ? SizedBox.shrink()
                            : /* Text(nationSnap.data!.data[3].countryName!) */

                            DropdownButton(
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
                                items: List.generate(
                                    nationSnap.data!.data.length,
                                    (index) => DropdownMenuItem(
                                        value: nationSnap
                                            .data!.data[index].countryName,
                                        child: Text(
                                          nationSnap
                                              .data!.data[index].countryName
                                              .toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelSmall,
                                        ))),
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
                      padding: AppVars.inputContentPadding,
                      decoration: AppVars.customInputboxDecoration,
                      margin: EdgeInsets.symmetric(vertical: marginHeight),
                      child: FutureBuilder(
                        future: eControl.getIdTypeList(ApiLinks.idTypeLink),
                        builder: (ctx, snapShot) => (!snapShot.hasData)
                            ? const SizedBox.shrink()
                            : DropdownButton(
                                hint: Text(
                                  "Choose Id Type",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontSize: mediumLabelFontSize,
                                      color: Colors.black54),
                                ),
                                value: _selectedIdType,
                                items: List.generate(
                                    snapShot.data!.data.length,
                                    (index) => DropdownMenuItem(
                                        value:
                                            snapShot.data!.data[index].idType,
                                        child: Text(
                                          snapShot.data!.data[index].idType ??
                                              "type",
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelSmall,
                                        ))),
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
              /*     validator: (value) {
                if (value != null && value == "") {
                  return AppStrings.punchIdErrorText;
                }
                return null;
              } */
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
              onExpansionChanged: (val) {
                if (val == true) {
                  _selectSelfAccess = "has_self_access";
                } else {
                  _selectSelfAccess = null;
                }
                print("on self access click $val");
              },
              shape: Border(),
              title: Text("Self Access"),
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: marginHeight),
                  decoration: AppVars.customInputboxDecoration,
                  child: TextFormField(
                    controller: _employeeEmailController,
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
                    controller: _employeePassController,
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
                padding: const EdgeInsets.symmetric(vertical: 5),
                shape: RoundedRectangleBorder(
                  borderRadius: borderRadius,
                ),
                backgroundColor: Appcolors.assignButtonColor,
                foregroundColor: actionButtonFgColor),
            onPressed: () {
              if (_formPersonalInfoKey.currentState == null) {
                return;
              }
              if (_formPersonalInfoKey.currentState!.validate() &&
                  _selectedIdType != null &&
                  _selectedNation != null) {
                tabController.index = 1;
                _formPersonalInfoKey.currentState!.save();
              } else {
                AppMethods().snackBar(AppStrings.formErrorText, context);
              }
            },
            child: const Text(
              'Next',
              style: TextStyle(fontSize: 25),
            ),
          ),
        ],
      ),
    );
  }

  Widget officeInfoTab(EmployeeDataController econtrol) {
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
                    'Shift Date: ${DateFormat.yMd().format(_selectedShiftDate)}', //${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day}
                    style: TextStyle(fontSize: mediumLabelFontSize),
                  ),
                  const SizedBox(width: 20),
                  TextButton(
                    onPressed: () => _selectShiftDate(context),
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
                      child: FutureBuilder(
                        future: econtrol.getShiftList(ApiLinks.shiftTypeLink),
                        builder: (ctx, snapshot) => (!snapshot.hasData)
                            ? const SizedBox.shrink()
                            : DropdownButton(
                                hint: Text(
                                  "Choose shift",
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
                                        value: snapshot
                                            .data!.data[index].shiftName,
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
                    'Joining Date: ${DateFormat.yMd().format(_selectedJoiningDate)}', //${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day}
                    style: TextStyle(fontSize: mediumLabelFontSize),
                  ),
                  const SizedBox(width: 20),
                  TextButton(
                    onPressed: () => _selectJoiningDate(context),
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
                    'Confirmation Date: ${DateFormat.yMd().format(_selectedConfirmationDate)}', //${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day}
                    style: TextStyle(fontSize: mediumLabelFontSize),
                  ),
                  const SizedBox(width: 20),
                  TextButton(
                    onPressed: () => _selectConfirmDate(
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
                      child: FutureBuilder(
                        future: econtrol
                            .getDepartmentList(ApiLinks.departmentListApiLink),
                        builder: (ctx, snapshot) => (!snapshot.hasData)
                            ? const SizedBox.shrink()
                            : DropdownButton(
                                hint: Text(
                                  "Choose department",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontSize: mediumLabelFontSize,
                                      color: Colors.black54),
                                ),
                                value: _selectedDepartment,
                                items: List.generate(
                                    snapshot.data!.data.length,
                                    (index) => DropdownMenuItem(
                                        value: snapshot.data!.data[index].id,
                                        child: Text(
                                          snapshot
                                              .data!.data[index].departmentName,
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelSmall,
                                        ))),
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
                ),
              ],
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 5),
                shape: RoundedRectangleBorder(
                  borderRadius: borderRadius,
                ),
                backgroundColor: Appcolors.assignButtonColor,
                foregroundColor: actionButtonFgColor),
            onPressed: () async {
              if (_formOfficialInfoKey.currentState == null) {
                return;
              }

              if (_formOfficialInfoKey.currentState!.validate() &&
                  _selectedDepartment != null &&
                  _selectedShift != null) {
                _formOfficialInfoKey.currentState!.save();

                HrmsEmployeePostModel employeeData = HrmsEmployeePostModel(
                    id: null,
                    punchId: _employeePunchIdController.text,
                    employeeName: _employeeNameController.text,
                    employeeFather: _employeeFatherNameController.text,
                    employeeMother: _employeeMotherNameController.text,
                    employeePhoneNumber: _employeePhoneNumberController.text,
                    gender: _selectedGender.name,
                    dateOfBirth: AppMethods().dateOfBirthFormat(_selectedDate),
                    nationality: _selectedNation,
                    idType: _selectedIdType,
                    idNumber: _employeeIdController.text,
                    permanentAddress: _employeePermanentAddressController.text,
                    presentAddress: _employeePermanentAddressController.text,
                    image: _storedImage,
                    userId: null,
                    email: _employeeEmailController.text,
                    password: _employeePassController.text,
                    shiftDate:
                        AppMethods().dateOfBirthFormat(_selectedShiftDate),
                    shiftId: _selectedShift,
                    joiningDate:
                        AppMethods().dateOfBirthFormat(_selectedJoiningDate),
                    confirmDate: AppMethods()
                        .dateOfBirthFormat(_selectedConfirmationDate),
                    designation: _employeeDesignationController.text,
                    departmentId: _selectedDepartment,
                    selfAccess: _selectSelfAccess);

                await econtrol.createEmployee(
                    ApiLinks.employeeListApiLink, employeeData);

                if (widget.isPop != null && widget.isPop == true) {
                  Navigator.of(context).pop();
                } else if (widget.isReplace != null &&
                    widget.isReplace == true) {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (ctx) => const EmployeeList()));
                } else {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx) => const EmployeeList()));
                }
              } else {
                AppMethods().snackBar(AppStrings.formErrorText, context);
              }
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
    EmployeeDataController employeeDataController =
        Provider.of<EmployeeDataController>(context, listen: false);
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
                labelStyle: Theme.of(context).textTheme.headlineSmall,
                controller: tabController,
                isScrollable: false,
                onTap: (value) {
                  if (_formPersonalInfoKey.currentState == null) {
                    return;
                  }
                  if (_formPersonalInfoKey.currentState!.validate() &&
                      _selectedIdType != null &&
                      _selectedNation != null) {
                    tabController.index = 1;
                    _formPersonalInfoKey.currentState!.save();
                  } else {
                    tabController.index = 0;
                    AppMethods().snackBar(AppStrings.formErrorText, context);
                  }
                },
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
                        child: employeeInfoTab(employeeDataController)),
                    SingleChildScrollView(
                        child: officeInfoTab(employeeDataController))
                  ]),
            ),

            //              const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
