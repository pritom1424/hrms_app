import 'package:flutter/material.dart';
import 'package:hrms_app/view/widgets/appbar_default_widget.dart';

class EmployeePage extends StatelessWidget {
  final String? title;
  const EmployeePage({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (title != null)
          ? AppbarDefault(
              appbarName: title,
            )
          : null,
      body: Center(
        child: Text("Emplyee_page"),
      ),
    );
  }
}
