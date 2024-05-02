import 'package:flutter/material.dart';

import '../../widgets/appbar_default_widget.dart';

class DrawerPage5 extends StatelessWidget {
  final String? title;
  const DrawerPage5({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (title == null)
          ? null
          : AppbarDefault(
              appbarName: title,
            ),
      body: const Center(
        child: Text("drawer page 5"),
      ),
    );
  }
}
