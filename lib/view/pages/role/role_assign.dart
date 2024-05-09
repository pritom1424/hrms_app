import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../../utils/app_variables/app_vars.dart';
import '../../widgets/appbar_default_widget.dart';

class RoleAssign extends StatelessWidget {
  final String? title;
  const RoleAssign({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    List<String> dataList = [
      "Robiul",
      "Tanay",
      "Roni",
      "Partha",
      "Saklain",
      "Nahid"
    ];
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
            Row(
              children: [
                Text(
                  "Role: ",
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  "Admin",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            ),
            Text("Employee List"),
            Container(
              height: AppVars.screenSize.height * 0.1,
              width: double.infinity,
              child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: List.generate(
                      dataList.length,
                      (index) => Row(
                            children: [
                              Checkbox(value: false, onChanged: (val) {}),
                              Text(dataList[index])
                            ],
                          ))),
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(0),
                  foregroundColor: Colors.white,
                  backgroundColor: Color(0xFF7A59AD),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                ),
                onPressed: () {},
                child: Text("Save"))
          ],
        ),
      ),
    );
  }
}
