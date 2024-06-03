import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hrms_app/controller/leave_controller.dart';
import 'package:hrms_app/model/leave_apply_model.dart';
import 'package:hrms_app/utils/app_methods/app_methods.dart';
import 'package:hrms_app/utils/app_variables/user_credential.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../utils/app_colors/app_colors.dart';
import '../../utils/app_variables/app_vars.dart';
import '../widgets/appbar_default_widget.dart';

class LeaveFormPage extends StatefulWidget {
  final String? title;
  const LeaveFormPage({this.title, super.key});
  @override
  State<LeaveFormPage> createState() => _LeaveFormPageState();
}

class _LeaveFormPageState extends State<LeaveFormPage> {
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  String? _selectLeaveType;
  String _totalLeaveDays = "";
  // Define controllers for text fields
  double leftPadding = 20;
  final TextEditingController _leaveReasonController = TextEditingController();

  // form vars
  EdgeInsetsGeometry contentPadding =
      const EdgeInsets.symmetric(horizontal: 20);
  BorderRadius borderRadius = const BorderRadius.all(Radius.circular(10));
  Color borderColor = const Color.fromARGB(255, 189, 183, 183);
  double borderWidth = 1;

  double marginHeight = 5;

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
  double smallLabelFontSize = 12;

  double mediumLabelFontSize = 15;
  int leaveTypeId = 0;
  // action button
  Color actionButtonBgColor = const Color.fromARGB(255, 68, 156, 204);
  Color actionButtonFgColor = Colors.white;

  Color iconColor = Colors.grey;
  Future<DateTime?> selectDate(BuildContext context,
      {DateTime? fDate, DateTime? lDate}) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: (fDate != null) ? fDate : DateTime(2015, 8),
      lastDate: (lDate != null) ? lDate : DateTime(2101),
    );
    return picked;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // Clean up controllers when the widget is disposed

    _leaveReasonController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provLeave = Provider.of<LeaveController>(context, listen: false);

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
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(left: leftPadding),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          "Leave Type",
                          style: TextStyle(
                              fontSize: labelFontSize,
                              fontWeight: FontWeight.bold),
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
                            margin:
                                EdgeInsets.symmetric(vertical: marginHeight),
                            child: FutureBuilder(
                              future: provLeave.getLeaveType(),
                              builder: (ctx, leaveSnap) => (!leaveSnap.hasData)
                                  ? SizedBox.shrink()
                                  : /* Text(nationSnap.data!.data[3].countryName!) */

                                  Consumer<LeaveController>(
                                      builder: (ctx, sConsume, _) =>
                                          DropdownButton(
                                              padding: EdgeInsets.all(0),
                                              hint: Text(
                                                "Choose Leave Type",
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style: TextStyle(
                                                    fontSize:
                                                        mediumLabelFontSize,
                                                    color: Colors.black54),
                                              ),
                                              value: sConsume.leaveType,
                                              items: List.generate(
                                                  leaveSnap.data!.data.length,
                                                  (index) => DropdownMenuItem(
                                                      value: leaveSnap.data!
                                                          .data[index].leaveType
                                                          .toString(),
                                                      child: Text(
                                                        leaveSnap
                                                            .data!
                                                            .data[index]
                                                            .leaveType
                                                            .toString(),
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .labelSmall,
                                                      ))),
                                              onChanged: (val) {
                                                if (val == null) {
                                                  return;
                                                }
                                                final ind = leaveSnap.data!.data
                                                    .indexWhere((type) =>
                                                        type.leaveType == val);
                                                if (ind > -1) {
                                                  leaveTypeId = leaveSnap
                                                      .data!.data[ind].id;
                                                } else {
                                                  leaveTypeId = -1;
                                                }
                                                provLeave.setLeaveType(val);
                                              }),
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
                        Consumer<LeaveController>(
                          builder: (ctx, leaveSnap, _) => Text(
                            'From Date: ${DateFormat.yMd().format(leaveSnap.fromDate)}', //${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day}
                            style: TextStyle(fontSize: mediumLabelFontSize),
                          ),
                        ),
                        SizedBox(width: 20),
                        TextButton(
                          onPressed: () async {
                            final selecDate = await selectDate(context,
                                fDate: DateTime(1970));
                            provLeave.setFromDate(selecDate ?? DateTime.now());
                          },
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
                        Consumer<LeaveController>(
                          builder: (ctx, leaveSnap, _) => Text(
                            'To Date: ${DateFormat.yMd().format(leaveSnap.toDate)}', //${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day}
                            style: TextStyle(fontSize: mediumLabelFontSize),
                          ),
                        ),
                        SizedBox(width: 20),
                        TextButton(
                          onPressed: () async {
                            final selecDate = await selectDate(context,
                                fDate: DateTime(1970));
                            provLeave.setToDate(selecDate ?? DateTime.now());
                          },
                          child: Text(
                            'Select Date',
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
                          "Number of leave days",
                          style: TextStyle(fontSize: mediumLabelFontSize),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Consumer<LeaveController>(
                          builder: (ctx, leaveConsume, _) => Text(
                            (leaveConsume.gettotalLeaveDays() > 0)
                                ? leaveConsume.gettotalLeaveDays().toString()
                                : "",
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
                          "Remaining leave days",
                          style: TextStyle(fontSize: mediumLabelFontSize),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        FutureBuilder(
                          future: provLeave.getRemainLeave(),
                          builder: (ctx, snap) => (!snap.hasData)
                              ? SizedBox.shrink()
                              : Text(
                                  snap.data.toString(),
                                  style:
                                      TextStyle(fontSize: mediumLabelFontSize),
                                ),
                        ),
                      ],
                    )),
                Container(
                  decoration: boxDecoration,
                  child: TextFormField(
                    controller: _leaveReasonController,
                    decoration: InputDecoration(
                        labelText: 'Leave Reason',
                        contentPadding: contentPadding,
                        border: InputBorder.none,
                        /* focusedBorder: OutlineInputBorder(
                          borderRadius: borderRadius,
                          borderSide:
                              BorderSide(color: borderColor, width: borderWidth)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: borderRadius,
                          borderSide:
                              BorderSide(color: borderColor, width: borderWidth)), */
                        hintText: 'Enter Leave Reason',
                        labelStyle: TextStyle(
                            fontSize: labelFontSize, color: labelFontColor),
                        hintStyle: AppVars.customHintTextStyle),
                    validator: (value) {
                      if (value != null && value == "") {
                        return 'Please enter leave reason';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      backgroundColor: Appcolors.assignButtonColor,
                      foregroundColor: actionButtonFgColor),
                  onPressed: () async {
                    FocusScope.of(context).unfocus();
                    if (_formKey.currentState == null) {
                      return;
                    }
                    if (_formKey.currentState!.validate() &&
                        provLeave.leaveType != null) {
                      if (provLeave.gettotalLeaveDays() <= 0) {
                        AppMethods().snackBar(
                            "Please check \"form\" and \"to\" Dates", context);
                        return;
                      }
                      if (leaveTypeId < 0) {
                        AppMethods().snackBar("Something went wrong", context);
                      }
                      _formKey.currentState!.save();

                      provLeave.setLoading(true);
                      final leaveModel = LeaveApplyModel(
                          UserCredential.userid,
                          leaveTypeId,
                          AppMethods().dateOfBirthFormat(provLeave.fromDate),
                          AppMethods().dateOfBirthFormat(provLeave.toDate),
                          provLeave.gettotalLeaveDays().toString(),
                          _leaveReasonController.text);

                      await provLeave.applyLeave(leaveModel);
                      provLeave.initLeaveForm();
                      provLeave.setLoading(false);
                      _leaveReasonController.text = "";
                      if (context.mounted) {
                        AppMethods().snackBar(
                            "Application for leave successfully submitted",
                            context,
                            Appcolors.deepGreenColor);
                      }
                    } else {
                      AppMethods()
                          .snackBar("Application for leave failed", context);
                    }
                    // Handle apply button press
                    // You can access the values using controller.text for each field
                  },
                  child: const Text(
                    'Apply',
                    style: TextStyle(fontSize: 25),
                  ),
                ),
                const SizedBox(height: 20),
                Consumer<LeaveController>(builder: (ctx, snap, ch) {
                  if (snap.isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Appcolors.contentColorPurple,
                      ),
                    );
                  } else {
                    return SizedBox.shrink();
                  }
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
