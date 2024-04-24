import 'package:flutter/material.dart';
import 'package:hrms_app/view/widgets/appbar_default_widget.dart';

class DrawerPage4 extends StatelessWidget {
  final String? title;
  const DrawerPage4({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (title == null)
          ? null
          : AppbarDefault(
              appbarName: title,
            ),
      body: const Center(
        child: Text("drawer page 4"),
      ),
    );
  }
}
