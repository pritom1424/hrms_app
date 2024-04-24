import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hrms_app/utils/app_variables/app_vars.dart';
import 'package:hrms_app/utils/app_variables/image_paths.dart';
import 'package:hrms_app/view/widgets/appbar_default_widget.dart';

class EmployeeProfilePage extends StatefulWidget {
  final String id;
  final String? title;

  const EmployeeProfilePage({super.key, required this.id, this.title});

  @override
  State<EmployeeProfilePage> createState() => _EmployeeProfilePageState();
}

class _EmployeeProfilePageState extends State<EmployeeProfilePage>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, String> formDataTab1 = {
      "Working Shift": "Regular",
      "Joining Date": "01.06.2021",
      "Gender": "Male",
      "Position": "Sr. App Developer",
      "General info1": "Demo info1",
      "General info2": "Demo info2s",
    };
    Map<String, String> formDataTab2 = {
      "Employee Name": "Regular",
      "Joining Date": "01.06.2021",
      "Gender": "Male",
      "Date of birth": "05.08.1998",
      "General info1": "Demo info1",
      "General info2": "Demo info2s",
    };
    // form vars
    EdgeInsetsGeometry contentPadding = const EdgeInsets.all(8);

    Color borderColor = const Color.fromARGB(255, 189, 183, 183);
    double borderWidth = 1;

    //font related
    TextStyle textStyle =
        const TextStyle(fontSize: 18, fontWeight: FontWeight.normal);

    // profile
    TextStyle profileNameTextStyle =
        const TextStyle(fontSize: 25, fontWeight: FontWeight.bold);
    TextStyle profileDesignationTextStyle = const TextStyle(
        fontSize: 18, color: Colors.grey, fontWeight: FontWeight.bold);

    Widget officialTabWidget() {
      return Column(
        children: List.generate(
            formDataTab1.length,
            (index) => Container(
                  height: AppVars.screenSize.height * 0.06,
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              width: borderWidth, color: borderColor))),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          padding: contentPadding,
                          child: Text(
                            formDataTab1.entries.toList()[index].key,
                            textAlign: TextAlign.center,
                            style: textStyle,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: contentPadding,
                          child: Text(
                            formDataTab1.entries.toList()[index].value,
                            textAlign: TextAlign.center,
                            style: textStyle,
                          ),
                        ),
                      )
                    ],
                  ),
                )),
      );
    }

    Widget personalTabWidget() {
      return Column(
        children: List.generate(
            formDataTab1.length,
            (index) => Container(
                  height: AppVars.screenSize.height * 0.06,
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              width: borderWidth, color: borderColor))),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          padding: contentPadding,
                          child: Text(
                            formDataTab2.entries.toList()[index].key,
                            textAlign: TextAlign.center,
                            style: textStyle,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: contentPadding,
                          child: Text(
                            formDataTab2.entries.toList()[index].value,
                            textAlign: TextAlign.center,
                            style: textStyle,
                          ),
                        ),
                      )
                    ],
                  ),
                )),
      );
    }

    return Scaffold(
      appBar: (widget.title == null)
          ? null
          : AppbarDefault(
              appbarName: widget.title,
            ),
      body: Container(
        height: AppVars.screenSize.height,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(ImagePath.proPicPath),
              radius: 50,
            ),
            Text(
              "Sajjad Hossen",
              style: profileNameTextStyle,
            ),
            Text(
              "Sr. Developer",
              style: profileDesignationTextStyle,
            ),
            TabBar(
                tabAlignment: TabAlignment.fill,
                labelStyle:
                    TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                controller: tabController,
                isScrollable: false,
                tabs: const [
                  Tab(
                    icon: Text('Official'),
                  ),
                  Tab(
                    icon: Text('Personal'),
                  ),
                ]),
            Container(
              height: AppVars.screenSize.height * 0.6,
              width: double.infinity,
              child: TabBarView(
                  controller: tabController,
                  children: [officialTabWidget(), personalTabWidget()]),
            )
          ],
        ),
      ),
    );
  }
}
