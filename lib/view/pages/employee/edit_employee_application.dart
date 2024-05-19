import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hrms_app/controller/employee_edit_data_controller.dart';
import 'package:hrms_app/model/hrms_employee_edit_model.dart';
import 'package:hrms_app/model/hrms_employee_post_model.dart';
import 'package:hrms_app/utils/app_methods/app_methods.dart';
import 'package:hrms_app/view/pages/employee/employee_table.dart';
import '../../../controller/employee_data_controller.dart';

import '../../../utils/app_colors/app_colors.dart';
import '../../../utils/app_variables/api_links.dart';
import '../../../utils/app_variables/app_strings.dart';
import '../../../utils/app_variables/image_paths.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../utils/app_variables/app_vars.dart';

import '../../widgets/appbar_default_widget.dart';
import 'package:image_picker/image_picker.dart';
import '../../../utils/enums/enums.dart';

class EditEmployeeApplicationForm extends StatefulWidget {
  final String? title;
  final int? employeeID;

  const EditEmployeeApplicationForm(
      {super.key, this.title, required this.employeeID});

  @override
  State<EditEmployeeApplicationForm> createState() =>
      _EditEmployeeApplicationFormState();
}

class _EditEmployeeApplicationFormState
    extends State<EditEmployeeApplicationForm>
    with SingleTickerProviderStateMixin {
  final _formPersonalInfoKey = GlobalKey<FormState>();
  final _formOfficialInfoKey = GlobalKey<FormState>();

  bool isInit = false;
  final TextEditingController _employeeEmailController =
      TextEditingController();
  final TextEditingController _employeePasswordController =
      TextEditingController();
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
  String? selectedDateString;
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
    isInit = true;

    super.initState();
  }

  void initField(HrmsEmployeeEditModel hrmsEmployeeEditModel) {
    _employeeNameController.text = hrmsEmployeeEditModel.employeeName ?? "";
    /*   _employeeFatherNameController.text =
        hrmsEmployeeEditModel.employeeFather ?? ""; */
    _employeeFatherNameController.text =
        (hrmsEmployeeEditModel.employeeFather == null)
            ? ""
            : hrmsEmployeeEditModel.employeeFather!;

/*     _employeeMotherNameController.text =
        hrmsEmployeeEditModel.employeeMother ?? ""; */

    _employeeMotherNameController.text =
        (hrmsEmployeeEditModel.employeeMother == null)
            ? ""
            : hrmsEmployeeEditModel.employeeMother!;

    (hrmsEmployeeEditModel.gender == null)
        ? _selectedGender = Gender.male
        : (hrmsEmployeeEditModel.gender?.toLowerCase() ==
                "Female".toLowerCase())
            ? Gender.female
            : Gender.male;
    /*  (hrmsEmployeeEditModel.gender?.toLowerCase() == "Female".toLowerCase())
        ? _selectedGender = Gender.female
        : _selectedGender = Gender.male; */
    selectedDateString = hrmsEmployeeEditModel.dateOfBirth;
    /*  _selectedDate = DateTime.parse(
            hrmsEmployeeEditModel.dateOfBirth ?? DateTime.now.toString()) ??
        DateTime.now(); */
    _selectedNation = hrmsEmployeeEditModel.nationality;
    _selectedIdType = hrmsEmployeeEditModel.idType;

    _employeeIdController.text = (hrmsEmployeeEditModel.idNumber == null)
        ? ""
        : hrmsEmployeeEditModel.idNumber!;

/*     _employeeIdController.text = hrmsEmployeeEditModel.idNumber ?? ""; */

    _employeePunchIdController.text = (hrmsEmployeeEditModel.punchId == null)
        ? ""
        : hrmsEmployeeEditModel.punchId!;
    // _employeePunchIdController.text = hrmsEmployeeEditModel.punchId ?? "";
/*     _employeePresentAddressController.text =
        hrmsEmployeeEditModel.presentAddress ?? ""; */

    _employeePresentAddressController.text =
        (hrmsEmployeeEditModel.presentAddress == null)
            ? ""
            : hrmsEmployeeEditModel.presentAddress!;
    /*  _employeePermanentAddressController.text =
        hrmsEmployeeEditModel.permanentAddress ?? ""; */

    _employeePermanentAddressController.text =
        (hrmsEmployeeEditModel.permanentAddress == null)
            ? ""
            : hrmsEmployeeEditModel.permanentAddress!;

    //office info

    if (hrmsEmployeeEditModel.officeInformation == null) {
      // print("office info null");
      _selectedShiftDate = DateTime.now();

      _selectedJoiningDate = DateTime.now();

      _selectedConfirmationDate = DateTime.now();
    } else {
      // print("office info not null");

      DateTime? tempDate =
          DateTime.tryParse(hrmsEmployeeEditModel.officeInformation!.shiftDate);

      DateTime? tempJoinDate = DateTime.tryParse(
          hrmsEmployeeEditModel.officeInformation!.joiningDate);

      DateTime? tempConfirmDate = DateTime.tryParse(
          hrmsEmployeeEditModel.officeInformation!.confirmationDate);

      /*   _employeeDesignationController.text =
          hrmsEmployeeEditModel.officeInformation!.designation ?? null; */

      _selectedDepartment =
          hrmsEmployeeEditModel.officeInformation!.departmentId;

      _selectedShift =
          hrmsEmployeeEditModel.officeInformation!.shiftId?.toString();
      (tempDate != null)
          ? _selectedDate = tempDate
          : _selectedDate = DateTime.now();

      (tempJoinDate != null)
          ? _selectedJoiningDate = tempJoinDate
          : _selectedJoiningDate = DateTime.now();
      (tempConfirmDate != null)
          ? _selectedConfirmationDate = tempConfirmDate
          : _selectedConfirmationDate = DateTime.now();

      print("office info $_selectedConfirmationDate $tempConfirmDate end");
    }

    // _employeeEmailController.text = hrmsEmployeeEditModel.e
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

    _employeeJoiningDateController.dispose();
    _employeeConfirmDateController.dispose();

    _employeeEmailController.dispose();
    _employeePasswordController.dispose();
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
                    'Date Of Birth: ${selectedDateString}', //${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day}
                    style: TextStyle(fontSize: mediumLabelFontSize),
                  ),
/* 
                   Text(
                    'Date Of Birth: ${DateFormat.yMd().format(_selectedDate)}', //${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day}
                    style: TextStyle(fontSize: mediumLabelFontSize),
                  ), */
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

                                /* Nationality.values
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
                                .toList() */
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
                      //   width: AppVars.screenSize.width * 0.60,
                      padding: AppVars.inputContentPadding,
                      decoration: AppVars
                          .customInputboxDecoration, //BoxDecoration(border: Border.all(width: 0.4)),
                      margin: EdgeInsets.symmetric(vertical: marginHeight),
                      child: FutureBuilder(
                        future: eControl.getIdTypeList(ApiLinks.idTypeLink),
                        builder: (ctx, snapShot) => (!snapShot.hasData)
                            ? SizedBox.shrink()
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
                                          snapShot.data!.data[index].idType,
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
              onExpansionChanged: (value) {
                if (value == true) {
                  _selectSelfAccess = "has_self_access";
                } else {
                  _selectSelfAccess = null;
                }
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
                    controller: _employeePasswordController,
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
                tabController.index = 1;
                _formPersonalInfoKey.currentState!.save();
              }

              // Handle apply button press
              // You can access the values using controller.text for each field
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
                  SizedBox(width: 20),
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
                            ? SizedBox.shrink()
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
                  SizedBox(width: 20),
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
                  SizedBox(width: 20),
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
                            ? SizedBox.shrink()
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
                padding: EdgeInsets.symmetric(vertical: 5),
                shape: RoundedRectangleBorder(
                  borderRadius: borderRadius,
                ),
                backgroundColor: Appcolors.assignButtonColor,
                foregroundColor: actionButtonFgColor),
            onPressed: () async {
              if (_formOfficialInfoKey.currentState == null) {
                return;
              }
              if (_formOfficialInfoKey.currentState!.validate()) {
                _formOfficialInfoKey.currentState!.save();

                print("email: ${_employeeEmailController.text}");
                HrmsEmployeePostModel employeeData = HrmsEmployeePostModel(
                    id: widget.employeeID,
                    punchId: _employeePunchIdController.text,
                    employeeName: _employeeNameController.text,
                    employeeFather: _employeeFatherNameController.text,
                    employeeMother: _employeeMotherNameController.text,
                    gender: _selectedGender.name,
                    dateOfBirth: AppMethods.dateOfBirthFormat(_selectedDate),
                    nationality: _selectedNation,
                    idType: _selectedIdType,
                    idNumber: _employeeIdController.text,
                    permanentAddress: _employeePermanentAddressController.text,
                    presentAddress: _employeePermanentAddressController.text,
                    image: null,
                    userId: null,
                    email: _employeeEmailController.text,
                    password: _employeePasswordController.text,
                    shiftDate: AppMethods.dateOfBirthFormat(_selectedShiftDate),
                    shiftId: _selectedShift,
                    joiningDate:
                        AppMethods.dateOfBirthFormat(_selectedJoiningDate),
                    confirmDate:
                        AppMethods.dateOfBirthFormat(_selectedConfirmationDate),
                    designation: _employeeDesignationController.text,
                    departmentId: _selectedDepartment,
                    selfAccess: _selectSelfAccess);

                if (widget.employeeID != null) {
                  await econtrol.updateEmployee(ApiLinks.employeeUpdateLink,
                      widget.employeeID!, employeeData);
                }

                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (ctx) => EmployeeList()));
                // Do something with the validated data
                //print('Name: $_name');
              }
              // Handle apply button press
              // You can access the values using controller.text for each field
            },
            child: const Text(
              'Update',
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
    EmployeeEditDataController employeeEditDataController =
        Provider.of<EmployeeEditDataController>(context, listen: false);
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
        child: (widget.employeeID == null)
            ? Container(
                height: AppVars.screenSize.height,
                child: const Center(
                  child: Text("No Id found"),
                ),
              )
            : (isInit)
                ? FutureBuilder(
                    future: employeeEditDataController.getEmployeeCurrentInfo(
                        ApiLinks.employeeInfoLink, widget.employeeID!),
                    builder: (ctx, infosnapShot) {
                      if (infosnapShot.connectionState ==
                          ConnectionState.waiting) {
                        return Container(
                          height: AppVars.screenSize.height,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      } else {
                        if (!infosnapShot.hasData) {
                          return Container(
                            height: AppVars.screenSize.height,
                            child: const Center(
                              child: Text("No data available"),
                            ),
                          );
                        } else {
                          initField(infosnapShot.data!);
                          isInit = false;
                          return editForm(context, employeeDataController);
                        }
                      }
                    })
                : editForm(context, employeeDataController),
      ),
    );
  }

  Column editForm(
      BuildContext context, EmployeeDataController employeeDataController) {
    return Column(
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
                    child: employeeInfoTab(employeeDataController)),
                SingleChildScrollView(
                    child: officeInfoTab(employeeDataController))
              ]),
        ),

        //              const SizedBox(height: 20),
      ],
    );
  }
}
