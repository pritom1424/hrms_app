import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../widgets/appbar_default_widget.dart';
import 'package:hrms_app/model/hrms_leave_list_model.dart';

class NewsfeedPage extends StatelessWidget {
  final String? title;
  final List<LeaveListDatum> data;
  const NewsfeedPage({super.key, this.title, required this.data});

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> newsFeedData = [
      {
        "title": "Application for Join",
        "subtitle":
            "Access to the office premises will now require the use of security badges.",
        //"status": "Approved",
        "date": "4-25-2024"
      },
      {
        "title": "Application for leave",
        "subtitle":
            "Access to the office premises will now require the use of security badges.",
        //"status": "Approved",
        "date": "4-25-2024"
      },
      {
        "title": "Application for Bonus",
        "subtitle":
            "Access to the office premises will now require the use of security badges.",
        //"status": "Rejected",
        "date": "4-25-2024"
      },
      {
        "title": "Application for Loan",
        "subtitle":
            "Access to the office premises will now require the use of security badges.",
        // "status": "Rejected",
        "date": "4-25-2024"
      }
    ];
    return Scaffold(
      appBar: (title == null)
          ? null
          : AppbarDefault(
              appbarName: title,
            ),
      body: SingleChildScrollView(
        child: (data.isEmpty)
            ? Center(
                child: Text("no data available!"),
              )
            : Column(
                children: List.generate(
                    data.length,
                    (index) => Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: ListTile(
                            title: Text(
                              data[index].employeeName ?? "",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(data[index].leaveReason ?? ""),
                            trailing: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                /* Padding(
                            padding: EdgeInsets.only(left: 5),
                            child: Text(
                              "Status",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                          ),
                          Text(
                            newsFeedData[index]['status']!,
                            style: TextStyle(
                                color: newsFeedData[index]['status']!
                                        .contains("Approved")
                                    ? Colors.green
                                    : Colors.red,
                                fontWeight: FontWeight.bold),
                          ), */
                                Text(
                                  Bidi.stripHtmlIfNeeded(data[index].status!)
                                      .trim(),
                                  style: TextStyle(
                                      color: (Bidi.stripHtmlIfNeeded(
                                                      data[index].status!)
                                                  .trim()
                                                  .toLowerCase() ==
                                              "cancelled")
                                          ? Color(0xFF2A6D2C)
                                          : Colors.red),
                                )
                              ],
                            ),
                          ),
                        )),
              ),
      ),
    );
  }
}
