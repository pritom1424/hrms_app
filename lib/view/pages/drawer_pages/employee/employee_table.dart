import 'package:flutter/material.dart';

import '../../../../controller/employee_data_controller.dart';

import '../../../../utils/app_colors/app_colors.dart';
import '../../../../utils/app_methods/app_methods.dart';
import '../../../../utils/app_variables/api_links.dart';
import '../../../../utils/app_variables/app_strings.dart';
import 'package:provider/provider.dart';
import '../../../../utils/app_variables/app_vars.dart';
import '../../../../utils/app_variables/image_paths.dart';

import 'add_new_application.dart';
import 'edit_employee_application.dart';
import 'text_to_pdf.dart';

class EmployeeList extends StatefulWidget {
  final String? title;

  const EmployeeList({super.key, this.title});
  @override
  State<EmployeeList> createState() => _EmployeeListState();
}

class _EmployeeListState extends State<EmployeeList> {
  TextEditingController searchController = TextEditingController();

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();

    searchController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    EmployeeDataController employeeDataController =
        Provider.of<EmployeeDataController>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: (widget.title != null)
            ? Text(widget.title!)
            : Text('Employee List'),
        actions: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: ElevatedButton(
              onPressed: () async {
                await Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => const AddNewApplicationForm(
                          title: "Add new employee",
                          isPop: true,
                        )));

                setState(() {});
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF886AB5),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.all(5),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5))),
              child: const Text("Add Employee"),
            ),
          )
        ],
      ),
      body: FutureBuilder(
          future: employeeDataController
              .loadEmployeeList(ApiLinks.employeeListApiLink),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return SizedBox(
                height: AppVars.screenSize.height,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else {
              return SingleChildScrollView(
                child: (!snapshot.hasData)
                    ? Container(
                        height: AppVars.screenSize.height,
                        child: const Center(
                          child: Text("No data available"),
                        ),
                      )
                    : Column(
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
                                          width: 1,
                                          color: Appcolors.searchbarBgColor)),
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
                                          width: 1,
                                          color: Appcolors.searchbarBgColor))),
                              onChanged: (value) {
                                Provider.of<EmployeeDataController>(context,
                                        listen: false)
                                    .filterUserData(value);

                                // filterUsers(value, snapshot.data!);
                              },
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Consumer<EmployeeDataController>(
                            builder: (ctx, consumer, ch) {
                              return RawScrollbar(
                                thumbColor: Colors.blueAccent,
                                controller: _scrollController,
                                thumbVisibility: true,
                                thickness: 3,
                                child: SingleChildScrollView(
                                  controller: _scrollController,
                                  scrollDirection: Axis.horizontal,
                                  child: DataTable(
                                    headingRowHeight:
                                        AppVars.screenSize.height * 0.06,
                                    dataTextStyle:
                                        TextStyle(color: Colors.black),
                                    dividerThickness: 3,
                                    headingTextStyle: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                    headingRowColor:
                                        WidgetStateColor.resolveWith((states) =>
                                            Appcolors.dataTableHeadingColor),
                                    dataRowColor: WidgetStateColor.resolveWith(
                                        (states) => Colors.black26),
                                    sortAscending: true,
                                    columns: const [
                                      DataColumn(
                                        label: Text('ID'),
                                      ),
                                      DataColumn(label: Text('Name')),
                                      DataColumn(label: Text('Employee Code')),
                                      DataColumn(label: Text('Punch Id')),
                                      DataColumn(label: Text('Father Name')),
                                      DataColumn(label: Text('Mother Name')),
                                      DataColumn(label: Text('Gender')),
                                      DataColumn(label: Text('Date of Birth')),
                                      DataColumn(label: Text('Nationality')),
                                      DataColumn(label: Text('Image')),
                                      DataColumn(
                                          label: Expanded(
                                              child: Center(
                                                  child: Text('Action')))),
                                    ],
                                    rows: List<DataRow>.generate(
                                      consumer.userData.length, //users.length,
                                      (index) => DataRow(
                                        color: WidgetStateColor.resolveWith(
                                            (states) => (index % 2 == 0)
                                                ? Color.fromARGB(
                                                    223, 179, 157, 219)
                                                : Colors.deepPurple.shade100),
                                        cells: [
                                          DataCell(Text(
                                              '${consumer.userData[index].id ?? -1}')),
                                          DataCell(Text(consumer
                                              .userData[index].employeeName
                                              .toString())),
                                          DataCell(Text(consumer
                                              .userData[index].employeeCode
                                              .toString())),
                                          DataCell(Text(consumer
                                              .userData[index].punchId
                                              .toString())),
                                          DataCell(Text(consumer
                                              .userData[index].employeeFather
                                              .toString())),
                                          DataCell(Text(consumer
                                              .userData[index].employeeMother
                                              .toString())),
                                          DataCell(Text(consumer
                                              .userData[index].gender
                                              .toString())),
                                          DataCell(Text(consumer
                                              .userData[index].dateOfBirth
                                              .toString())),
                                          DataCell(Text(consumer
                                              .userData[index].nationality
                                              .toString())),
                                          DataCell(CircleAvatar(
                                            backgroundImage: (consumer
                                                        .userData[index]
                                                        .image !=
                                                    null)
                                                ? (AppMethods().stripLink(
                                                            consumer
                                                                .userData[index]
                                                                .image!) !=
                                                        null)
                                                    ? NetworkImage(AppMethods()
                                                        .stripLink(consumer
                                                            .userData[index]
                                                            .image!)!)
                                                    : AssetImage(ImagePath
                                                            .proPicPlaceholderPath)
                                                        as ImageProvider
                                                : AssetImage(ImagePath
                                                    .proPicPlaceholderPath),
                                          )),
                                          DataCell(Row(
                                            children: [
                                              IconButton(
                                                icon: Icon(Icons.edit),
                                                onPressed: () async {
                                                  print(
                                                      "${consumer.userData[index].id}");
                                                  await Navigator.of(context)
                                                      .push(MaterialPageRoute(
                                                          builder: (ctx) => EditEmployeeApplicationForm(
                                                              title:
                                                                  "Edit employee",
                                                              employeeID:
                                                                  consumer
                                                                      .userData[
                                                                          index]
                                                                      .id,
                                                              employeeCode: consumer
                                                                  .userData[
                                                                      index]
                                                                  .employeeCode)));
                                                  setState(() {});
                                                  print("pop");
                                                  /* _editUser(
                                        context,
                                        users[
                                            index]);  */ //_editName(context, users[index]);
                                                },
                                              ),
                                              IconButton(
                                                icon: Icon(Icons.delete),
                                                onPressed: () async {
                                                  await consumer.deleteEmployee(
                                                      ApiLinks
                                                          .employeeDeleteLink,
                                                      consumer
                                                          .userData[index].id!);
                                                  setState(() {});
                                                  // _deleteUser(index);
                                                },
                                              ),
                                              IconButton(
                                                icon:
                                                    Icon(Icons.picture_as_pdf),
                                                onPressed: () {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (ctx) =>
                                                              TextToPdfConverter(
                                                                id: consumer
                                                                    .userData[
                                                                        index]
                                                                    .id!,
                                                              )));
                                                  // Handle PDF download action
                                                },
                                              ),
                                            ],
                                          )),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
              );
            }
          }),
    );
  }
}
