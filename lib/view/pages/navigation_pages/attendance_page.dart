import 'package:flutter/material.dart';
import 'package:hrms_app/controller/employee_attendance_controller.dart';

import 'package:hrms_app/utils/app_methods/app_methods.dart';
import 'package:hrms_app/utils/app_variables/api_links.dart';
import 'package:hrms_app/view/pages/attendance/create_attendance_application.dart';
import 'package:hrms_app/view/pages/attendance/edit_attendance_application.dart';
import 'package:provider/provider.dart';
import '../../../utils/app_colors/app_colors.dart';
import '../../../utils/app_variables/app_strings.dart';
import '../../widgets/appbar_default_widget.dart';

import '../../../utils/app_variables/app_vars.dart';

import 'package:intl/intl.dart';

class AttendancePage extends StatefulWidget {
  final String? title;

  const AttendancePage({super.key, this.title});
  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  //search
  late List<Map<String, dynamic>> filteredUsers;
  TextEditingController searchController = TextEditingController();

  String newName = '';
  String fatherName = '';
  final ScrollController _scrollController = ScrollController();
  bool isInit = false;

//controller
  TextEditingController nameController = TextEditingController();
  TextEditingController faNameController = TextEditingController();
  TextEditingController moNameController = TextEditingController();
  TextEditingController employeeCodeController = TextEditingController();
  TextEditingController punchIdController = TextEditingController();
  @override
  void initState() {
    isInit = true;

    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    faNameController.dispose();
    moNameController.dispose();
    employeeCodeController.dispose();
    punchIdController.dispose();
    _scrollController.dispose();
    searchController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    EmployeeAttendanceController employeeDataController =
        Provider.of<EmployeeAttendanceController>(context, listen: false);

    return Scaffold(
      appBar: (widget.title == null)
          ? null
          : AppbarDefault(
              appbarName: widget.title,
            ),
      body: (isInit)
          ? FutureBuilder(
              future: employeeDataController.getEmployeeAttendanceList(
                  ApiLinks.employeeAttendanceListLink),
              builder: (ctx, snapShot) {
                if (snapShot.connectionState == ConnectionState.waiting) {
                  return SizedBox(
                    height: AppVars.screenSize.height,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                isInit = false;
                return SingleChildScrollView(
                  child: (!snapShot.hasData)
                      ? Container(
                          height: AppVars.screenSize.height,
                          child: const Center(
                            child: Text("No data available"),
                          ),
                        )
                      : attendanceForm(ctx),
                );
              })
          : SingleChildScrollView(
              child: attendanceForm(context),
            ),
    );
  }

  Column attendanceForm(BuildContext context) {
    return Column(
      children: [
        // SearcWidget(),

        Container(
          width: AppVars.screenSize.width,
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Appcolors.searchbarBgColor,
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                              width: 1, color: Appcolors.searchbarBgColor)),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 5),
                      hintText: AppStrings.searchPlaceholderText,
                      prefixIcon: Icon(Icons.search),
                      hintStyle: const TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                          fontWeight: FontWeight.normal),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                              width: 1, color: Appcolors.searchbarBgColor))),
                  onChanged: (value) {
                    Provider.of<EmployeeAttendanceController>(context,
                            listen: false)
                        .filterUserData(value);
                  },
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => CreateAttendanceForm(
                                title: "Add Attendance",
                              ) /* AddAttendanceForm(
                                title: "Add Attendance",
                              ) */
                          ));
                    },
                    style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                        backgroundColor: Appcolors.assignButtonColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    child: const FittedBox(
                      child: Text(
                        "Add Attendance",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    )),
              )
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Consumer<EmployeeAttendanceController>(builder: (ctx, consumer, ch) {
          return RawScrollbar(
              thumbColor: Colors.blueAccent,
              controller: _scrollController,
              thumbVisibility: true,
              thickness: 3,
              child: SingleChildScrollView(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    dataTextStyle: TextStyle(color: Colors.black),
                    dividerThickness: 3,
                    headingTextStyle: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                    headingRowColor: WidgetStateColor.resolveWith(
                        (states) => Appcolors.dataTableHeadingColor),
                    dataRowColor: WidgetStateColor.resolveWith(
                        (states) => Colors.black26),
                    sortAscending: true,
                    columns: const [
                      DataColumn(
                        label: Text('SL'),
                      ),
                      DataColumn(label: Text('Date')),
                      DataColumn(label: Text('Employee Id')),
                      DataColumn(label: Text('Employee Name')),
                      DataColumn(label: Text('In time')),
                      DataColumn(label: Text('Out time')),
                      DataColumn(label: Text('Shift Duration')),
                      DataColumn(label: Text('Late time')),
                      DataColumn(label: Text('Over time')),
                      DataColumn(label: Text('Total Hours')),
                      DataColumn(label: Text('Status')),
                      DataColumn(
                          label:
                              Expanded(child: Center(child: Text('Action')))),
                    ],
                    rows: List<DataRow>.generate(
                      consumer.userData.length,
                      (index) => DataRow(
                          color: WidgetStateColor.resolveWith((states) =>
                              (index % 2 == 0)
                                  ? Color.fromARGB(223, 179, 157, 219)
                                  : Colors.deepPurple.shade100),
                          cells: [
                            DataCell(Text((index + 1).toString())),
                            DataCell(Text(AppMethods().dateOfBirthFormat(
                                consumer.userData[index].attendanceDate))),
                            DataCell(Text(consumer.userData[index].employeeId
                                .toString())),
                            DataCell(Text(
                                consumer.userData[index].employeeName ?? "")),
                            DataCell(
                                Text(consumer.userData[index].inTime ?? "")),
                            DataCell(
                                Text(consumer.userData[index].outTime ?? "")),
                            DataCell(Text(
                                consumer.userData[index].shiftDuration ?? "")),
                            DataCell(
                                Text(consumer.userData[index].lateTime ?? "")),
                            DataCell(
                                Text(consumer.userData[index].overTime ?? "")),
                            DataCell(Text(
                                consumer.userData[index].totalWorkingHour ??
                                    "")),
                            DataCell(Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 3, vertical: 3),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.blueAccent,
                              ),
                              child: Text(
                                (consumer.userData[index].status == null)
                                    ? ""
                                    : Bidi.stripHtmlIfNeeded(
                                        consumer.userData[index].status!),
                                style: TextStyle(color: Colors.white),
                              ),
                            )),
                            DataCell(
                              Row(
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.edit),
                                    onPressed: () async {
                                      print("${consumer.userData[index].id}");
                                      await Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (ctx) =>
                                                  EditAttendanceForm(
                                                    title: "Edit Attendance",
                                                    employeeId: consumer
                                                        .userData[index]
                                                        .employeeId,
                                                    id: consumer
                                                        .userData[index].id,
                                                  )));

                                      setState(() {
                                        isInit = true;
                                      });
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.delete),
                                    onPressed: () async {
                                      if (consumer.userData[index].id == null) {
                                        return;
                                      }
                                      print(
                                          "delete attendance ${consumer.userData[index].id}");
                                      await consumer.deleteEmployee(
                                          ApiLinks.employeeAttendanceDeleteLink,
                                          consumer.userData[index].id!);

                                      isInit = true;
                                      setState(() {});
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ]),
                    ),
                  )));
        }),
      ],
    );
  }
}
