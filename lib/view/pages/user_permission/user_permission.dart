import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../../utils/app_variables/app_vars.dart';
import '../../widgets/appbar_default_widget.dart';

class UserPermission extends StatelessWidget {
  final String? title;
  const UserPermission({super.key, this.title});

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
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "User Permission",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Checkbox(value: false, onChanged: (val) {}),
                      Text("Employee")
                    ],
                  ),
                ),
                SizedBox(
                    height: AppVars.screenSize.height * 0.06,
                    child: VerticalDivider(
                      color: Colors.black54,
                    )),
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Checkbox(value: false, onChanged: (val) {}),
                          Text("Create")
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(value: false, onChanged: (val) {}),
                          Text("Update")
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                    height: AppVars.screenSize.height * 0.06,
                    child: VerticalDivider(
                      color: Colors.black54,
                    )),
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Checkbox(value: false, onChanged: (val) {}),
                          Text("View")
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(value: false, onChanged: (val) {}),
                          Text("Delete")
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
            Divider(
              thickness: 0.4,
            ),
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Checkbox(value: false, onChanged: (val) {}),
                      Text("Settings")
                    ],
                  ),
                ),
                SizedBox(
                    height: AppVars.screenSize.height * 0.06,
                    child: VerticalDivider(
                      color: Colors.black54,
                    )),
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Checkbox(value: false, onChanged: (val) {}),
                          Text("Create")
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(value: false, onChanged: (val) {}),
                          Text("Update")
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                    height: AppVars.screenSize.height * 0.06,
                    child: VerticalDivider(
                      color: Colors.black54,
                    )),
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Checkbox(value: false, onChanged: (val) {}),
                          Text("View")
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(value: false, onChanged: (val) {}),
                          Text("Delete")
                        ],
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
