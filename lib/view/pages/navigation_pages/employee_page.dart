import 'package:flutter/material.dart';
import '../../../utils/app_methods/app_methods.dart';
import '../../../utils/app_variables/app_vars.dart';
import '../../widgets/appbar_default_widget.dart';

class EmployeePage extends StatelessWidget {
  final String? title;
  const EmployeePage({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> employeeData = [
      {
        'name': 'Sajjad Rahman',
        'phone': '0171600000',
        'id': '001122',
        'joining date': '1-1-2024',
        'gender': 'male',
        'position': 'app developer',
        'working shift': 'morning'
      },
      {
        'name': 'Sajjad Rahman',
        'phone': '0171600000',
        'id': '001122',
        'joining date': '1-1-2024',
        'gender': 'male',
        'position': 'app developer',
        'working shift': 'morning'
      },
      {
        'name': 'Sajjad Rahman',
        'phone': '0171600000',
        'id': '001122',
        'joining date': '1-1-2024',
        'gender': 'male',
        'position': 'app developer',
        'working shift': 'morning'
      },
      {
        'name': 'Sajjad Rahman',
        'phone': '0171600000',
        'id': '001122',
        'joining date': '1-1-2024',
        'gender': 'male',
        'position': 'app developer',
        'working shift': 'morning'
      },
      {
        'name': 'Sajjad Rahman',
        'phone': '0171600000',
        'id': '001122',
        'joining date': '1-1-2024',
        'gender': 'male',
        'position': 'app developer',
        'working shift': 'morning'
      },
    ];

    return Scaffold(
      appBar: (title == null)
          ? null
          : AppbarDefault(
              appbarName: title,
            ),
      body: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: 30),
          child: Column(
            children: List.generate(
                employeeData.length,
                (index) => Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Card(
                          elevation:
                              0, // Set Card's elevation to 0 to prevent shadow overlap
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              ListTile(
                                leading: CircleAvatar(
                                  child: Icon(Icons.person),
                                ),
                                title:
                                    Text(employeeData[index]['name'] ?? "name"),
                                subtitle: Text(
                                    employeeData[index]['phone'] ?? "phone"),
                                // trailing: Text('Date'),
                              ),
                              Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 25, vertical: 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    //  MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Column(
                                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text('Employee Id: '),
                                          Text('Joining Date: '),
                                          Text('Gender: '),
                                          Text('Position: '),
                                          Text('Working Shift: '),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(employeeData[index]['id'] ??
                                                "null"),
                                            Text(employeeData[index]
                                                    ['joining date'] ??
                                                "null"),
                                            Text(employeeData[index]
                                                    ['gender'] ??
                                                "null"),
                                            Text(employeeData[index]
                                                    ['position'] ??
                                                "null"),
                                            Text(employeeData[index]
                                                    ['working shift'] ??
                                                "null"),
                                          ]

                                          /* [
                                      Text('Leave: '),
                                      Text('Duration: '),
                                      Text('Leave Date: '),
                                      Text('Leave Balance: '),
                                      Text('Reason: '),
                                    ], */
                                          ),
                                    ],
                                  )),
                              /* ButtonBar(
                          alignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            TextButton(
                              onPressed: () {
                                print("Approve");
                              },
                              child: Text('Approve'),
                              style: ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.green),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                AppMethods.showAlertPop(
                                    context,
                                    Text(
                                      "Are you sure?",
                                      textAlign: TextAlign.center,
                                    ),
                                    Container(
                                      width: AppVars.screenSize.width * 0.9,
                                      child: Text(
                                        "Do you want to delete this request?\n\nEmployee Name:Sajjad\nReason:this",
                                        textAlign: TextAlign.center,
                                        //maxLines: 3,
                                        // overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    () {},
                                    () {});
                                print("Reject");
                              },
                              child: Text('Reject'),
                              style: ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.red),
                              ),
                            ),
                            /* TextButton(
                              onPressed: () {
                                print("Edit");
                              },
                              child: Text('Edit'),
                              style: ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.blue),
                              ),
                            ), */
                          ],
                        ), */
                            ],
                          ),
                        ),
                      ),
                    )),
          )),
    );
  }
}
