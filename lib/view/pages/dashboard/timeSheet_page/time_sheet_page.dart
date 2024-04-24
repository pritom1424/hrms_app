import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hrms_app/view/widgets/appbar_default_widget.dart';

class TimeSheetPage extends StatelessWidget {
  final String? title;
  const TimeSheetPage({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (title == null)
          ? null
          : AppbarDefault(
              appbarName: title,
            ),
      body: Center(
        child: Text("TimeSheet"),
      ),
    );
  }
}
