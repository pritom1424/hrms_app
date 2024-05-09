import 'package:flutter/material.dart';

import '../../../widgets/appbar_default_widget.dart';

class FilesPage extends StatelessWidget {
  final String? title;
  const FilesPage({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (title == null)
          ? null
          : AppbarDefault(
              appbarName: title,
            ),
      body: Center(
        child: Text("FilesPage"),
      ),
    );
  }
}
