import 'package:flutter/material.dart';
import 'package:hrms_app/view/widgets/appbar_default_widget.dart';

class LogoutPage extends StatelessWidget {
  final String? title;
  const LogoutPage({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (title != null)
          ? AppbarDefault(
              appbarName: title,
            )
          : null,
      body: Center(
        child: Text("Logout_page"),
      ),
    );
  }
}
