import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hrms_app/controller/employee_shift_controller.dart';
import 'package:hrms_app/utils/app_variables/api_links.dart';
import 'package:provider/provider.dart';
import '../../../../utils/app_variables/app_vars.dart';
import '../../../widgets/appbar_default_widget.dart';

class ShiftConfigView extends StatelessWidget {
  final String? title;
  final int? id;
  const ShiftConfigView({super.key, this.title, this.id});

  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<EmployeeShiftController>(context, listen: false);
    double rowHeight = 0.05;

    /*  List<TableRow> shiftInfoWidgets = [];
    List<TableRow> breakInfoWidgets = [];
    data.forEach((key, value) {
      if (key.contains("Break")) {
        breakInfoWidgets.add(TableRow(children: [
          Container(
            height: AppVars.screenSize.height * rowHeight,
            child: Text(
              key,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          Container(
              height: AppVars.screenSize.height * rowHeight,
              child: Text(value, style: Theme.of(context).textTheme.bodyMedium))
        ]));
      } else {
        shiftInfoWidgets.add(TableRow(children: [
          Container(
              height: AppVars.screenSize.height * rowHeight,
              child: Text(key, style: Theme.of(context).textTheme.bodyMedium)),
          Container(
              height: AppVars.screenSize.height * rowHeight,
              child: Text(value, style: Theme.of(context).textTheme.bodyMedium))
        ]));
      }
    }); */
    return Scaffold(
      appBar: (title != null)
          ? AppbarDefault(
              appbarName: title,
              isShowLeading: false,
              isShowNotification: false,
            )
          : null,
      body: (id == null)
          ? Container(
              height: AppVars.screenSize.height,
              child: Center(
                child: Text("no id found"),
              ),
            )
          : FutureBuilder(
              future: provider.loadShiftById(ApiLinks.employeeShiftLink, id!),
              builder: (ctx, snap) => (snap.connectionState ==
                      ConnectionState.waiting)
                  ? SizedBox(
                      height: AppVars.screenSize.height * 0.6,
                      child: Center(child: CircularProgressIndicator()))
                  : (!snap.hasData)
                      ? Text("No data available")
                      : Container(
                          height: AppVars.screenSize.height,
                          width: double.infinity,
                          color: Colors.white,
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Shift Information",
                                style:
                                    Theme.of(context).textTheme.headlineLarge,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Table(children: [
                                TableRow(children: [
                                  Container(
                                      height:
                                          AppVars.screenSize.height * rowHeight,
                                      child: Text("Shift Name",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium)),
                                  Container(
                                      height:
                                          AppVars.screenSize.height * rowHeight,
                                      child: Text(
                                          snap.data!.shift.shiftName ?? "",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium))
                                ]),
                                TableRow(children: [
                                  Container(
                                      height:
                                          AppVars.screenSize.height * rowHeight,
                                      child: Text("Shift Start Time",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium)),
                                  Container(
                                      height:
                                          AppVars.screenSize.height * rowHeight,
                                      child: Text(
                                          snap.data!.shiftStartTime ?? "",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium))
                                ]),
                                TableRow(children: [
                                  Container(
                                      height:
                                          AppVars.screenSize.height * rowHeight,
                                      child: Text("Shift End Time",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium)),
                                  Container(
                                      height:
                                          AppVars.screenSize.height * rowHeight,
                                      child: Text(snap.data!.shiftEndTime ?? "",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium))
                                ]),
                                TableRow(children: [
                                  Container(
                                      height:
                                          AppVars.screenSize.height * rowHeight,
                                      child: Text("Default Shift",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium)),
                                  Container(
                                      height:
                                          AppVars.screenSize.height * rowHeight,
                                      child: Text(snap.data!.defaultShift ?? "",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium))
                                ]),
                                TableRow(children: [
                                  Container(
                                      height:
                                          AppVars.screenSize.height * rowHeight,
                                      child: Text("Grace Time",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium)),
                                  Container(
                                      height:
                                          AppVars.screenSize.height * rowHeight,
                                      child: Text(snap.data!.gracePeriod ?? "",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium))
                                ])
                              ]),
                              Container(
                                  margin: EdgeInsets.symmetric(vertical: 5),
                                  child: Text("Break Information",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineLarge)),
                              Table(children: [
                                TableRow(children: [
                                  Container(
                                      height:
                                          AppVars.screenSize.height * rowHeight,
                                      child: Text("Break Start Time",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium)),
                                  Container(
                                      height:
                                          AppVars.screenSize.height * rowHeight,
                                      child: Text(
                                          snap.data!.breakStartTime ?? "",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium))
                                ]),
                                TableRow(children: [
                                  Container(
                                      height:
                                          AppVars.screenSize.height * rowHeight,
                                      child: Text("Break End Time",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium)),
                                  Container(
                                      height:
                                          AppVars.screenSize.height * rowHeight,
                                      child: Text(snap.data!.breakEndTime ?? "",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium))
                                ]),
                              ]),
                              SizedBox(
                                height: 10,
                              ),
                              RichText(
                                  textAlign: TextAlign.left,
                                  text: TextSpan(children: [
                                    TextSpan(
                                        text: "Total Working Hours: ",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .fontSize)),
                                    TextSpan(
                                        text: snap.data!.totalWorkingHour,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .fontSize))
                                  ]))
                            ],
                          ),
                        ),
            ),
    );
  }
}
