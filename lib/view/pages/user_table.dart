import 'dart:math';

import 'package:flutter/material.dart';

class MyDataTable extends StatefulWidget {
  @override
  _MyDataTableState createState() => _MyDataTableState();
}

class _MyDataTableState extends State<MyDataTable> {
  final List<Map<String, dynamic>> users = [
    {
      "id": 1,
      "name": "Tanay Sayed",
      "employeeCode": "###",
      "faName": "New York",
      "gender": "Male",
      "dateOfBirth": "9-9-2000",
      "Nationality": "BD",
      "image": ""
    },
    {
      "id": 2,
      "name": "Bkash Nahid",
      "employeeCode": "###",
      "faName": "New York",
      "gender": "Male",
      "dateOfBirth": "9-9-2000",
      "Nationality": "BD",
      "image": ""
    },
    {
      "id": 3,
      "name": "Pitom Ahmed",
      "employeeCode": "###",
      "faName": "New York",
      "gender": "Male",
      "dateOfBirth": "9-9-2000",
      "Nationality": "BD",
      "image": ""
    },
    {
      "id": 4,
      "name": "Roni From Noakhali",
      "employeeCode": "###",
      "faName": "New York",
      "gender": "Male",
      "dateOfBirth": "9-9-2000",
      "Nationality": "BD",
      "image": ""
    },
    {
      "id": 5,
      "name": "Partho Das",
      "employeeCode": "###",
      "faName": "New York",
      "gender": "Male",
      "dateOfBirth": "9-9-2000",
      "Nationality": "BD",
      "image": ""
    },
    {
      "id": 6,
      "name": "Bkash Naiii",
      "employeeCode": "###",
      "faName": "New York",
      "gender": "Male",
      "dateOfBirth": "9-9-2000",
      "Nationality": "BD",
      "image": ""
    },
    {
      "id": 7,
      "name": "Bkash Nahid",
      "employeeCode": "###",
      "faName": "New York",
      "gender": "Male",
      "dateOfBirth": "9-9-2000",
      "Nationality": "BD",
      "image": ""
    },
    {
      "id": 8,
      "name": "Nahid Bkash",
      "employeeCode": "###",
      "faName": "New York",
      "gender": "Male",
      "dateOfBirth": "9-9-2000",
      "Nationality": "BD",
      "image": ""
    },
    {
      "id": 9,
      "name": "Bkash Bolci",
      "employeeCode": "###",
      "faName": "New York",
      "gender": "Male",
      "dateOfBirth": "9-9-2000",
      "Nationality": "BD",
      "image": ""
    },
    {
      "id": 10,
      "name": "Tanay Sayed",
      "employeeCode": "###",
      "faName": "New York",
      "gender": "Male",
      "dateOfBirth": "9-9-2000",
      "Nationality": "BD",
      "image": ""
    },
  ];

  String newName = '';
  ScrollController _scrollController = ScrollController();

  MaterialStateColor getRandomColor() {
    // Generate random RGB values
    final random = Random();
    final int minBrightness = 200; // Minimum brightness value
    final int maxBrightness = 255; // Maximum brightness value
    final int r = minBrightness + random.nextInt(maxBrightness - minBrightness);
    final int g = minBrightness + random.nextInt(maxBrightness - minBrightness);
    final int b = minBrightness + random.nextInt(maxBrightness - minBrightness);

    return MaterialStateColor.resolveWith(
        (states) => Color.fromRGBO(r, g, b, 1.0));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Data Table'),
      ),
      body: RawScrollbar(
        thumbColor: Colors.blueAccent,
        controller: _scrollController,
        thumbVisibility: true,
        child: SingleChildScrollView(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          child: DataTable(
            dataTextStyle: TextStyle(color: Colors.black),
            dividerThickness: 3,
            headingRowColor: MaterialStateColor.resolveWith(
                (states) => Colors.blue.shade400),
            dataRowColor:
                MaterialStateColor.resolveWith((states) => Colors.black26),
            sortAscending: true,
            columns: const [
              DataColumn(
                label: Text('ID'),
              ),
              DataColumn(label: Text('Name')),
              DataColumn(label: Text('Employee Code')),
              DataColumn(label: Text('Father Name')),
              DataColumn(label: Text('Mother Name')),
              DataColumn(label: Text('Gender')),
              DataColumn(label: Text('Date of Birth')),
              DataColumn(label: Text('Nationality')),
              DataColumn(label: Text('Image')),
              DataColumn(label: Text('Action')),
            ],
            rows: List<DataRow>.generate(
              users.length,
              (index) => DataRow(
                color: getRandomColor(),
                cells: [
                  DataCell(Text('${users[index]["id"]}')),
                  DataCell(Text(users[index]["name"].toString())),
                  DataCell(Text(users[index]["employeeCode"].toString())),
                  DataCell(Text(users[index]["faName"].toString())),
                  DataCell(Text(users[index]["maName"].toString())),
                  DataCell(Text(users[index]["gender"].toString())),
                  DataCell(Text(users[index]["dateOfBirth"].toString())),
                  DataCell(Text(users[index]["nationality"].toString())),
                  DataCell(Text(users[index]["image"].toString())),
                  DataCell(Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          _editName(context, users[index]);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          _deleteUser(index);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.picture_as_pdf),
                        onPressed: () {
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

  void _deleteUser(int index) {
    setState(() {
      users.removeAt(index);
    });
  }
}
