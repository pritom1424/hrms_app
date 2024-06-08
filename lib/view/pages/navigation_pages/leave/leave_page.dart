import 'package:flutter/material.dart';
import 'package:hrms_app/controller/leave_controller.dart';
import 'package:hrms_app/model/hrms_leave_list_model.dart';
import 'package:hrms_app/utils/app_colors/app_colors.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../utils/app_methods/app_methods.dart';
import '../../../../utils/app_variables/app_vars.dart';
import '../../../widgets/appbar_default_widget.dart';

class LeaveCards extends StatefulWidget {
  final String? title;
  const LeaveCards({super.key, this.title});

  @override
  State<LeaveCards> createState() => _LeaveCardsState();
}

class _LeaveCardsState extends State<LeaveCards>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);

    super.initState();
  }

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }

  Widget pendingRequests(List<LeaveListDatum> data) {
    final prov = Provider.of<LeaveController>(context, listen: false);
    return Column(
      children: List.generate(
          data.length,
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
                          title: Text(data[index].employeeName ?? ""),
                          subtitle: Text(AppMethods()
                              .dateOfBirthFormat(data[index].updatedAt)),
                        ),
                        Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 25, vertical: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text('Leave Type: '),
                                    Text("Leave From"),
                                    Text("Leave To"),
                                    Text('Duration: '),
                                    Text('Reason: '),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Text(data[index].leaveType ?? ""),
                                    Text(data[index].fromDate ?? ""),
                                    Text(data[index].toDate ?? ""),
                                    Text(data[index].numberOfDays ?? ""),
                                    Text(
                                      data[index].leaveReason ?? "",
                                    ),
                                  ],
                                ),
                              ],
                            )),
                        ButtonBar(
                          alignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            TextButton(
                              onPressed: () async {
                                await AppMethods().showAlertPop(
                                    context,
                                    Text(
                                      "Are you sure?",
                                      textAlign: TextAlign.center,
                                    ),
                                    Container(
                                      width: AppVars.screenSize.width * 0.9,
                                      child: Text(
                                        "Do you want to approve this request?\n\nEmployee Name:${data[index].employeeName}\nReason:${data[index].leaveReason}",
                                        textAlign: TextAlign.center,
                                        //maxLines: 3,
                                        // overflow: TextOverflow.ellipsis,
                                      ),
                                    ), () async {
                                  if (data[index].id != null) {
                                    final message = await prov
                                        .approveLeave(data[index].id!);
                                    if (mounted) {
                                      AppMethods().snackBar(message, context,
                                          Appcolors.deepGreenColor);
                                    }
                                    setState(() {});
                                  } else {
                                    AppMethods().snackBar(
                                        "something went wrong", context);
                                  }
                                  //  Navigator.of(context).pop();
                                }, () {
                                  //Navigator.of(context).pop();
                                });
                              },
                              child: Text('Approve'),
                              style: ButtonStyle(
                                foregroundColor: WidgetStateProperty.all<Color>(
                                    Colors.white),
                                backgroundColor: WidgetStateProperty.all<Color>(
                                    Colors.green),
                              ),
                            ),
                            TextButton(
                              onPressed: () async {
                                await AppMethods().showAlertPop(
                                    context,
                                    Text(
                                      "Are you sure?",
                                      textAlign: TextAlign.center,
                                    ),
                                    Container(
                                      width: AppVars.screenSize.width * 0.9,
                                      child: Text(
                                        "Do you want to delete this request?\n\nEmployee Name:${data[index].employeeName}\nReason:${data[index].leaveReason}",
                                        textAlign: TextAlign.center,
                                        //maxLines: 3,
                                        // overflow: TextOverflow.ellipsis,
                                      ),
                                    ), () async {
                                  if (data[index].id != null) {
                                    final message =
                                        await prov.cancelLeave(data[index].id!);
                                    AppMethods().snackBar(message, context);
                                    setState(() {});
                                  } else {
                                    AppMethods().snackBar(
                                        "something went wrong", context);
                                  }

                                  //  Navigator.of(context).pop();
                                }, () {
                                  // Navigator.of(context).pop();
                                });
                              },
                              child: Text('Reject'),
                              style: ButtonStyle(
                                foregroundColor: WidgetStateProperty.all<Color>(
                                    Colors.white),
                                backgroundColor:
                                    WidgetStateProperty.all<Color>(Colors.red),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )),
    );
  }

  Widget historyTab(List<LeaveListDatum> data) {
    return Column(
      children: List.generate(
          data.length,
          (index) => Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
                      Text(
                        Bidi.stripHtmlIfNeeded(data[index].status!).trim(),
                        style: TextStyle(
                            color: (Bidi.stripHtmlIfNeeded(data[index].status!)
                                        .trim()
                                        .toLowerCase() ==
                                    "cancelled")
                                ? Colors.red
                                : Appcolors.deepGreenColor),
                      )
                    ],
                  ),
                ),
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<LeaveController>(context, listen: false);
    return Scaffold(
      appBar: (widget.title == null)
          ? null
          : AppbarDefault(
              appbarName: widget.title,
            ),
      body: FutureBuilder(
        future: prov.getLeaveList(),
        builder: (ctx, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!snap.hasData) {
            return Center(
              child: Text("no data found!"),
            );
          }
          print("snap data ${snap.data}");

          List<LeaveListDatum> pendingList = snap.data!.data
              .where(
                (element) =>
                    Bidi.stripHtmlIfNeeded(element.status!)
                        .trim()
                        .toLowerCase() ==
                    "pending",
              )
              .toList();

          List<LeaveListDatum> historyList = snap.data!.data
              .where(
                (element) =>
                    Bidi.stripHtmlIfNeeded(element.status!)
                        .trim()
                        .toLowerCase() !=
                    "pending",
              )
              .toList();

          return Container(
            height: AppVars.screenSize.height,
            child: Column(
              children: [
                TabBar(
                  controller: _tabController,
                  tabs: const [
                    Tab(
                        child: Text(
                      'Pending Request',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                    Tab(
                      child: Text(
                        'History',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      SingleChildScrollView(
                          child: (pendingList.isEmpty)
                              ? Container(
                                  height: AppVars.screenSize.height * 0.6,
                                  child: Center(
                                    child: Text("No pending request!"),
                                  ),
                                )
                              : pendingRequests(pendingList)),
                      SingleChildScrollView(
                        child: (historyList.isEmpty)
                            ? Container(
                                height: AppVars.screenSize.height * 0.6,
                                child: Center(
                                  child: Text("No history available!"),
                                ),
                              )
                            : historyTab(historyList),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
