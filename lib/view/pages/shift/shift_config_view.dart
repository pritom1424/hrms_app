import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../../utils/app_variables/app_vars.dart';
import '../../widgets/appbar_default_widget.dart';

class ShiftConfigView extends StatelessWidget {
  final String? title;
  const ShiftConfigView({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    double rowHeight = 0.05;
    Map<String, String> data = {
      "Shift name": "morning shift",
      "Shift Start Time": "11:30",
      "Shift End Time": "19:30",
      "Default Shift": "",
      "Grace Time": "20 min",
      "Break Start Time": "12:30",
      "Break End Time": "14:00",
    };

    List<TableRow> shiftInfoWidgets = [];
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
    });
    return Scaffold(
      appBar: (title != null)
          ? AppbarDefault(
              appbarName: title,
              isShowLeading: false,
              isShowNotification: false,
            )
          : null,
      body: Container(
        height: AppVars.screenSize.height,
        width: double.infinity,
        color: Colors.white,
        margin: EdgeInsets.symmetric(horizontal: 5),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Shift Information",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            SizedBox(
              height: 10,
            ),
            Table(children: shiftInfoWidgets),
            Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                child: Text("Break Information",
                    style: Theme.of(context).textTheme.headlineLarge)),
            Table(children: breakInfoWidgets),
            SizedBox(
              height: 10,
            ),
            RichText(
                textAlign: TextAlign.left,
                text: TextSpan(children: [
                  TextSpan(
                      text: "Total Working Hours",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .fontSize)),
                  TextSpan(
                      text: ": 7 hour 30 min",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize:
                              Theme.of(context).textTheme.bodyMedium!.fontSize))
                ]))
          ],
        ),
      ),
    );
  }
}
