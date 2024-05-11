import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../../utils/app_variables/app_vars.dart';
import '../../widgets/appbar_default_widget.dart';

class RoleAssign extends StatefulWidget {
  final String? title;
  const RoleAssign({super.key, this.title});

  @override
  State<RoleAssign> createState() => _RoleAssignState();
}

class _RoleAssignState extends State<RoleAssign> {
  ScrollController _scController = ScrollController();
  List<String> dataList = [
    "Robiul",
    "Tanay",
    "Roni",
    "Partha",
    "Saklain",
    "Nahid"
  ];
  @override
  void dispose() {
    _scController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (widget.title != null)
          ? AppbarDefault(
              appbarName: widget.title,
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
              child: RawScrollbar(
                controller: _scController,
                thumbColor: Colors.blueAccent,
                trackColor: Colors.blueAccent,
                thumbVisibility: true,
                child: ListView(
                    controller: _scController,
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
