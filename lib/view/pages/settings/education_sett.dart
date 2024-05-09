import 'package:flutter/material.dart';
import 'package:hrms_app/view/widgets/appbar_default_widget.dart';

class EducationSettings extends StatelessWidget {
  final String? title;
  const EducationSettings({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: (title != null)
            ? AppbarDefault(
                appbarName: title,
                isShowLeading: false,
                isShowNotification: false,
              )
            : null,
        body: Center(
          child: Text("new page"),
        ));
  }
}
