import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hrms_app/view/widgets/appbar_default_widget.dart';

class AttendancePage extends StatelessWidget {
  final String? title;
  const AttendancePage({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarDefault(
        appbarName: title,
      ),
      body: Center(
        child: Text("attendance_page"),
      ),
    );
  }
}
