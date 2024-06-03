import 'package:flutter/material.dart';
import 'package:hrms_app/controller/employee_user_controller.dart';
import 'package:hrms_app/model/hrms_user_model.dart';
import 'package:hrms_app/utils/app_methods/app_methods.dart';
import 'package:hrms_app/utils/app_variables/api_links.dart';
import 'package:hrms_app/view/pages/employee/edit_employee_application.dart';
import 'package:provider/provider.dart';
import '../../../utils/app_colors/app_colors.dart';
import '../../../utils/app_variables/app_strings.dart';

import '../../../utils/app_variables/app_vars.dart';

class UsersList extends StatefulWidget {
  final String? title;

  const UsersList({super.key, this.title});
  @override
  State<UsersList> createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  bool isInit = false;

  HrmsEmployeeUserModel? _hrmsEmployeeUserModel;
  //search
  late List<Map<String, dynamic>> filteredUsers;
  TextEditingController searchController = TextEditingController();

  List<bool> didEnable = [];

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    isInit = true;

    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    searchController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<EmployeeUserController>(context, listen: false);

    return Scaffold(
        appBar: AppBar(
          title:
              (widget.title != null) ? Text(widget.title!) : Text('User List'),
          actions: [],
        ),
        body: (isInit)
            ? FutureBuilder(
                future: provider.loadAllUser(ApiLinks.employeeUserListLink),
                builder: (ctx, snap) {
                  if (snap.connectionState == ConnectionState.waiting) {
                    return Container(
                      height: AppVars.screenSize.height,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else {
                    if (!snap.hasData) {
                      return Container(
                        height: AppVars.screenSize.height,
                        child: const Center(
                          child: Text("No data available"),
                        ),
                      );
                    }
                    isInit = false;
                    _hrmsEmployeeUserModel = snap.data!;

                    for (int i = 0; i < snap.data!.data.length; i++) {
                      didEnable
                          .add((snap.data!.data[i].status == 1) ? true : false);
                    }

                    return mainDataTable(_hrmsEmployeeUserModel);
                  }
                },
              )
            : mainDataTable(_hrmsEmployeeUserModel));
  }

  Widget mainDataTable(HrmsEmployeeUserModel? hrmsEmployeeUserModel) {
    return (hrmsEmployeeUserModel == null)
        ? SizedBox.shrink()
        : SingleChildScrollView(
            child: Column(
              children: [
                // SearcWidget(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Appcolors.searchbarBgColor,
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                width: 1, color: Appcolors.searchbarBgColor)),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 5),
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
                      Provider.of<EmployeeUserController>(context,
                              listen: false)
                          .filterUserData(value);
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Consumer<EmployeeUserController>(builder: (ctx, consumer, ch) {
                  return RawScrollbar(
                    thumbColor: Colors.blueAccent,
                    controller: _scrollController,
                    thickness: 3,
                    thumbVisibility: true,
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        headingRowHeight: AppVars.screenSize.height * 0.06,
                        dataTextStyle: TextStyle(color: Colors.black),
                        dividerThickness: 3,
                        headingTextStyle: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                        headingRowColor: MaterialStateColor.resolveWith(
                            (states) => Appcolors.dataTableHeadingColor),
                        dataRowColor: MaterialStateColor.resolveWith(
                            (states) => Colors.black26),
                        sortAscending: true,
                        columns: const [
                          DataColumn(label: Text('Name')),
                          DataColumn(label: Text('Employee Code')),
                          DataColumn(label: Text('Email')),
                          DataColumn(
                              label: Expanded(
                                  child: Center(child: Text('Action')))),
                        ],
                        rows: List<DataRow>.generate(
                          consumer.userData.length, // users.length,
                          (index) => DataRow(
                            color: MaterialStateColor.resolveWith((states) =>
                                (index % 2 == 0)
                                    ? Color.fromARGB(223, 179, 157, 219)
                                    : Colors.deepPurple
                                        .shade100), //getRandomColor(),
                            cells: [
                              DataCell(Text(
                                  consumer.userData[index].name.toString())),
                              DataCell(Text(consumer
                                  .userData[index].employeeCode
                                  .toString())),
                              DataCell(Text(
                                  consumer.userData[index].email.toString())),
                              DataCell((consumer.userData[index].employeeCode ==
                                      null)
                                  ? SizedBox.shrink()
                                  : ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.all(0),
                                        backgroundColor: (didEnable)[index]
                                            ? Color(0xFFFD3995)
                                            : Colors.deepPurple,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                      ),
                                      onPressed: () async {
                                        if (consumer.userData[index].email ==
                                            null) {
                                          await Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (ctx) =>
                                                      EditEmployeeApplicationForm(
                                                          title:
                                                              "Edit Employee",
                                                          employeeID: AppMethods()
                                                              .employeeCodeToId(
                                                                  consumer
                                                                      .userData[
                                                                          index]
                                                                      .employeeCode!),
                                                          employeeCode: consumer
                                                              .userData[index]
                                                              .employeeCode)));

                                          isInit = true;
                                        } else {
                                          didEnable[index] = !didEnable[index];
                                        }
                                        await consumer.updateUserStatus(
                                            ApiLinks.userStatusUpdate,
                                            consumer.userData[index].id);

                                        setState(() {});
                                      },
                                      child: Text(
                                        (didEnable)[index]
                                            ? "Inactive"
                                            : "Active",
                                        style: TextStyle(color: Colors.white),
                                      ))),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          );
  }
}
