import 'package:flutter/material.dart';
import 'package:hrms_app/view/widgets/appbar_default_widget.dart';

class SettingsPage extends StatelessWidget {
  final String? title;
  const SettingsPage({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (title != null)
          ? AppbarDefault(
              appbarName: title,
            )
          : null,
      body: Center(
        child: Text("Settings_page"),
      ),
    );
  }
}
