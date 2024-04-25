import 'package:flutter/material.dart';
import 'package:hrms_app/utils/app_methods/app_methods.dart';
import 'package:hrms_app/utils/app_variables/app_vars.dart';
import 'package:hrms_app/view/widgets/appbar_default_widget.dart';

class EmployeePage extends StatelessWidget {
  final String? title;
  const EmployeePage({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (title == null)
          ? null
          : AppbarDefault(
              appbarName: title,
            ),
      body: SingleChildScrollView(
          child: Column(
        children: List.generate(
            10,
            (index) => Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3), // changes position of shadow
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
                            title: Text('Employee Name'),
                            subtitle: Text('Phone'),
                            // trailing: Text('Date'),
                          ),
                          Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                //  MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
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
                                  /* Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text('Leave: '),
                                      Text('Duration: '),
                                      Text('Leave Date: '),
                                      Text('Leave Balance: '),
                                      Text('Reason: '),
                                    ],
                                  ), */
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
