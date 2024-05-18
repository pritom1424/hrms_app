import 'package:flutter/material.dart';
import '../widgets/appbar_default_widget.dart';

class MyWidget extends StatelessWidget {
  final String? title;
  const MyWidget({super.key, this.title});

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
