import 'package:flutter/material.dart';
import 'package:hrms_app/view/widgets/appbar_default_widget.dart';

class UsersPage extends StatelessWidget {
  final String? title;
  const UsersPage({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (title == null)
          ? null
          : AppbarDefault(
              appbarName: title,
            ),
      body: Center(
        child: Text("Users_page"),
      ),
    );
  }
}
