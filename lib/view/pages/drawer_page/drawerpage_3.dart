import 'package:flutter/material.dart';
import 'package:hrms_app/view/widgets/appbar_default_widget.dart';

class DrawerPage3 extends StatelessWidget {
  final String? title;
  const DrawerPage3({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (title != null)
          ? AppbarDefault(
              appbarName: title,
            )
          : null,
      body: const Center(
        child: Text("drawer page 3"),
      ),
    );
  }
}
