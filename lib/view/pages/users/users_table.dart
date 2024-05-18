import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hrms_app/utils/app_colors/app_colors.dart';
import 'package:hrms_app/utils/app_variables/app_strings.dart';

import '../../../utils/app_variables/app_vars.dart';
import '../../../utils/app_variables/image_paths.dart';
import '../../../utils/enums/enums.dart';
import '../employee/add_new_application.dart';
import '../employee/edit_employee_application.dart';
import '../text_to_pdf.dart';
import '../../widgets/dashboard_page/search_widget.dart';
import 'package:intl/intl.dart';

class UsersList extends StatefulWidget {
  final String? title;

  const UsersList({super.key, this.title});
  @override
  State<UsersList> createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  //search
  late List<Map<String, dynamic>> filteredUsers;
  TextEditingController searchController = TextEditingController();

  List<bool> didEnable = [];
  Gender _selectedGender = Gender.male;

  final List<Map<String, dynamic>> users = [
    {
      "id": 1,
      "name": "Tanay Sayed",
      "employeeCode": "007",
      "faName": "New York",
      "gender": "Male",
      "dateOfBirth": "9-9-2000",
      "Nationality": "BD",
      "image": ImagePath.proPicPath //""
    },
    {
      "id": 2,
      "name": "Bkash Nahid",
      "employeeCode": "008",
      "faName": "London",
      "gender": "Male",
      "dateOfBirth": "5-12-1998",
      "Nationality": "BD",
      "image": ""
    },
    {
      "id": 3,
      "name": "Pitom Ahmed",
      "employeeCode": "012",
      "faName": "New York",
      "gender": "Male",
      "dateOfBirth": "9-9-2000",
      "Nationality": "BD",
      "image": ""
    },
    {
      "id": 4,
      "name": "Roni From Noakhali",
      "employeeCode": "024",
      "faName": "Father",
      "gender": "Male",
      "dateOfBirth": "2-5-2005",
      "Nationality": "BD",
      "image": ""
    },
    {
      "id": 5,
      "name": "Partho Das",
      "employeeCode": "###",
      "faName": "New York",
      "gender": "Male",
      "dateOfBirth": "2-3-1995",
      "Nationality": "BD",
      "image": ""
    },
    {
      "id": 6,
      "name": "Bkash Naiii",
      "employeeCode": "###",
      "faName": "New York",
      "gender": "Male",
      "dateOfBirth": "12-8-2011",
      "Nationality": "BD",
      "image": ""
    },
    {
      "id": 7,
      "name": "Bkash Nahid",
      "employeeCode": "###",
      "faName": "New York",
      "gender": "Male",
      "dateOfBirth": "5-9-2001",
      "Nationality": "BD",
      "image": ""
    },
    {
      "id": 8,
      "name": "Nahid Bkash",
      "employeeCode": "###",
      "faName": "New York",
      "gender": "Male",
      "dateOfBirth": "1-2-2002",
      "Nationality": "BD",
      "image": ""
    },
    {
      "id": 9,
      "name": "Bkash Bolci",
      "employeeCode": "###",
      "faName": "New York",
      "gender": "Male",
      "dateOfBirth": "1-2-2009",
      "Nationality": "BD",
      "image": ""
    },
    {
      "id": 10,
      "name": "Sajjad hasan",
      "employeeCode": "###",
      "faName": "father",
      "gender": "Male",
      "dateOfBirth": "9-9-2002",
      "Nationality": "BD",
      "image": ""
    },
  ];

  String newName = '';
  String fatherName = '';
  final ScrollController _scrollController = ScrollController();
  Nationality? _selectedNation;

  //date picker
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

//controller
  TextEditingController nameController = TextEditingController();
  TextEditingController faNameController = TextEditingController();
  TextEditingController moNameController = TextEditingController();
  TextEditingController employeeCodeController = TextEditingController();
  TextEditingController punchIdController = TextEditingController();

  @override
  void initState() {
    //AppVars.filteredUserData = users;
    filteredUsers = [];
    filteredUsers = users;
    print("filteredUser: ${filteredUsers.length}");
    // TODO: implement initState
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
    // TODO: implement dispose
    super.dispose();
  }

  void filterUsers(String query) {
    setState(() {
      filteredUsers = users.where((user) {
        bool matchFound = false;
        user.forEach((key, value) {
          if (value.toString().toLowerCase().contains(query.toLowerCase())) {
            matchFound = true;
          }
        });
        return matchFound;

        /* user['name']
            .toString()
            .toLowerCase()
            .contains(query.toLowerCase()); */
      }).toList();
    });
  }

  MaterialStateColor getRandomColor() {
    // Generate random RGB values
    final random = Random();

    final int minBrightness = 210; // Minimum brightness value
    final int maxBrightness = 220; // Maximum brightness value
    final int r = minBrightness + random.nextInt(maxBrightness - minBrightness);
    final int g = minBrightness + random.nextInt(maxBrightness - minBrightness);
    final int b = minBrightness + random.nextInt(maxBrightness - minBrightness);

    return MaterialStateColor.resolveWith(
        (states) => Color.fromRGBO(r, g, b, 1.0));
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
        print("Selected Date Trigger");
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: (widget.title != null)
            ? Text(widget.title!)
            : Text('Employee List'),
        actions: [
          /*  Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => AddNewApplicationForm(
                          title: "Add new employee",
                        )));
              },
              child: Text("Add Employee"),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF886AB5),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.all(5),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5))),
            ),
          ) */
        ],
      ),
      body: SingleChildScrollView(
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
                  filterUsers(value);
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            RawScrollbar(
              thumbColor: Colors.blueAccent,
              controller: _scrollController,
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
                        label: Expanded(child: Center(child: Text('Action')))),
                  ],
                  rows: List<DataRow>.generate(
                    filteredUsers.length, // users.length,
                    (index) => DataRow(
                      color: MaterialStateColor.resolveWith((states) =>
                          (index % 2 == 0)
                              ? Color.fromARGB(223, 179, 157, 219)
                              : Colors.deepPurple.shade100), //getRandomColor(),
                      cells: [
                        DataCell(Text(filteredUsers[index]["id"].toString())),
                        DataCell(Text(filteredUsers[index]["name"].toString())),
                        DataCell(Text(
                            filteredUsers[index]["employeeCode"].toString())),
                        DataCell(
                            Text(filteredUsers[index]["punchId"].toString())),
                        DataCell(
                            Text(filteredUsers[index]["faName"].toString())),
                        DataCell(
                            Text(filteredUsers[index]["maName"].toString())),
                        DataCell(
                            Text(filteredUsers[index]["gender"].toString())),
                        DataCell(Text(
                            filteredUsers[index]["dateOfBirth"].toString())),
                        DataCell(Text(
                            filteredUsers[index]["nationality"].toString())),
                        DataCell(CircleAvatar(
                            backgroundImage: (filteredUsers[index]["image"]
                                    .toString()
                                    .isNotEmpty)
                                ? AssetImage(
                                    filteredUsers[index]["image"].toString())
                                : null,
                            child: (filteredUsers[index]["image"]
                                    .toString()
                                    .isNotEmpty)
                                ? null
                                : Icon(Icons.person))),

                        /*  DataCell(Text(users[index]["id"].toString())),
                        DataCell(Text(users[index]["name"].toString())),
                        DataCell(Text(users[index]["employeeCode"].toString())),
                        DataCell(Text(users[index]["punchId"].toString())),
                        DataCell(Text(users[index]["faName"].toString())),
                        DataCell(Text(users[index]["maName"].toString())),
                        DataCell(Text(users[index]["gender"].toString())),
                        DataCell(Text(users[index]["dateOfBirth"].toString())),
                        DataCell(Text(users[index]["nationality"].toString())),
                        DataCell(CircleAvatar(
                            backgroundImage: (users[index]["image"]
                                    .toString()
                                    .isNotEmpty)
                                ? AssetImage(users[index]["image"].toString())
                                : null,
                            child: (users[index]["image"].toString().isNotEmpty)
                                ? null
                                : Icon(Icons
                                    .person))), */ //Text(users[index]["image"].toString())
                        DataCell(Row(
                          children: [
                            Checkbox(
                                value: didEnable.length > index
                                    ? didEnable[index]
                                    : false,
                                onChanged: (val) {
                                  setState(() {
                                    if (didEnable.length <= index) {
                                      didEnable.add(false);
                                    }
                                    didEnable[index] = val ?? false;
                                  });
                                }),
                            Text("Enable")
                          ],
                        )),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _editName(BuildContext context, Map<String, dynamic> user) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'Edit Name',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20.0),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'New Name',
                  ),
                  onChanged: (value) {
                    setState(() {
                      newName = value;
                    });
                  },
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    // Update name in the data table
                    setState(() {
                      user['name'] = newName;
                    });
                    Navigator.pop(context);
                  },
                  child: Text('Save'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _editUser(BuildContext context, Map<String, dynamic> user) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        if (user['name'] != null && nameController.text.isEmpty) {
          nameController.text = user['name'];
        }
        if (user['faName'] != null && faNameController.text.isEmpty) {
          faNameController.text = user['faName'];
        }

        if (user['maName'] != null && moNameController.text.isEmpty) {
          moNameController.text = user['maName']!;
        }
        if (user['employeeCode'] != null &&
            employeeCodeController.text.isEmpty) {
          employeeCodeController.text = user['employeeCode'];
        }
        if (user['punchId'] != null && punchIdController.text.isEmpty) {
          punchIdController.text = user['punchId'];
        }

        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'Edit Employee',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: employeeCodeController,
                        decoration: InputDecoration(
                          labelText: 'Employee Code',
                        ),
                        onChanged: (value) {
                          setState(() {
                            employeeCodeController.clear();
                            employeeCodeController.text = value;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextField(
                        controller: punchIdController,
                        decoration: InputDecoration(
                          labelText: 'Punch Id',
                        ),
                        onChanged: (value) {
                          setState(() {
                            punchIdController.clear();
                            punchIdController.text = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                          labelText: 'New Name',
                        ),
                        onChanged: (value) {
                          setState(() {
                            nameController.clear();
                            nameController.text = value;
                          });
                        },
                      ),
                    ),
                    ToggleButtons(
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
                  ],
                ),
                SizedBox(height: 20.0),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: faNameController,
                        decoration: InputDecoration(
                          labelText: 'Father Name',
                        ),
                        onChanged: (value) {
                          setState(() {
                            faNameController.clear();
                            faNameController.text = value;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextField(
                        controller: moNameController,
                        decoration: InputDecoration(
                          labelText: 'Mother Name',
                        ),
                        onChanged: (value) {
                          setState(() {
                            moNameController.clear();
                            moNameController.text = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    padding: EdgeInsets.only(left: 10),
                    //  decoration: boxDecoration,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Date Of Birth: ${DateFormat.yMd().format(_selectedDate)}', //${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day}
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(width: 20),
                        TextButton(
                          onPressed: () =>
                              _selectDate(context, fDate: DateTime(1970)),
                          child: Text(
                            'Select Date',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    )),
                Container(
                  padding: EdgeInsets.only(left: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Nationality",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      DropdownButtonHideUnderline(
                        child: Container(
                          width: AppVars.screenSize.width * 0.55,
                          padding: EdgeInsets.all(8),
                          decoration:
                              BoxDecoration(border: Border.all(width: 0.4)),
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: DropdownButton(
                              hint: Text(
                                "Choose nationality",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black54),
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
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    if (nameController.text.isEmpty ||
                        faNameController.text.isEmpty) {
                      return;
                    }
                    // Update name in the data table
                    setState(() {
                      user['name'] = nameController.text;
                      user['faName'] = faNameController.text;
                      user['maName'] = moNameController.text;
                      user['punchId'] = punchIdController.text;
                      user['employeeCode'] = employeeCodeController.text;
                      user['nationality'] = (_selectedNation != null)
                          ? _selectedNation!.name
                          : "null";

                      user['dateOfBirth'] =
                          DateFormat.yMd().format(_selectedDate);
                    });
                  },
                  child: Text('Save'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _deleteUser(int index) {
    setState(() {
      users.removeAt(index);
    });
  }
}
