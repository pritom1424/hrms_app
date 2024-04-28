import 'package:flutter/material.dart';

import 'package:hrms_app/utils/app_variables/app_vars.dart';
import 'package:hrms_app/view/pages/add_new_application.dart';
import 'package:hrms_app/view/pages/admin_notice_page.dart';
import 'package:hrms_app/view/pages/calender_page.dart';

import 'package:hrms_app/view/pages/dashboard/attendance_page/attendance_page.dart';
import 'package:hrms_app/view/pages/dashboard/files_page/files_page.dart';
import 'package:hrms_app/view/pages/dashboard/leave_page/leave_page.dart';
import 'package:hrms_app/view/pages/dashboard/organization_page/organization_page.dart';
import 'package:hrms_app/view/pages/dashboard/performance_page/performance_page.dart';
import 'package:hrms_app/view/pages/dashboard/timeSheet_page/time_sheet_page.dart';
import 'package:hrms_app/view/pages/employee_profile_page.dart';
import 'package:hrms_app/view/pages/leave_application.dart';
import 'package:hrms_app/view/pages/notice_list_page.dart';
import 'package:hrms_app/view/pages/notice_page.dart';
import 'package:hrms_app/view/pages/status_page.dart';
import 'package:hrms_app/view/pages/user_table.dart';
import 'package:hrms_app/view/widgets/appbar_default_widget.dart';
import 'package:hrms_app/view/widgets/dashboard_page/dashboard_menu_tile.dart';
import 'package:hrms_app/view/widgets/dashboard_page/search_widget.dart';
import 'package:hrms_app/view/pages/datepicker_page.dart';

class DashboardPage extends StatelessWidget {
  final String? title;
  const DashboardPage({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    List<dynamic> getdashRoutes(int index) {
      return [
        // AdminNoticePage(title: "Admin Notice")
        MyDataTable()
        // AddNewApplicationForm(title: "Add new")
        // LeaveFormPage("Leave Application Form")
        /* PerformancePage(
          title: AppVars.dashboardData[index].entries.toList()[0].key,
        ) */
        ,
        LeaveCards(
          title: AppVars.dashboardData[index].entries.toList()[0].key,
        ),
        /* OrganizationPage(
          title: AppVars.dashboardData[index].entries.toList()[0].key,
        ), */
        LeaveFormPage("Leave Application Form"),
        /* TimeSheetPage(
          title: AppVars.dashboardData[index].entries.toList()[0].key,
        ) */
        // EmployeeProfilePage(id: "id", title: "Employee Profile"),
        AddNewApplicationForm(
          title: "New Application",
        ),
        /* AttendancePage(
          title: AppVars.dashboardData[index].entries.toList()[0].key,
        ), */
        StatusPage(
          title: "Status Page",
        ),
        //CalendarScreen(title: "Calender Page"),
        //datepicker_page
        /* DateTimePickerScreen(), */
        /* FilesPage(
          title: AppVars.dashboardData[index].entries.toList()[0].key,
        ), */
        NoticePage(title: "Notice"),
      ];
    }

    return Scaffold(
      appBar: (title == null)
          ? null
          : AppbarDefault(
              appbarName: title,
            ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SearcWidget(),
            Container(
              height: AppVars.screenSize.height * 0.72,
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 25,
                crossAxisSpacing: 20,
                childAspectRatio: 3 / 2.8,
                children: List.generate(
                    6,
                    (index) => DashboardMenuTile(
                        route: getdashRoutes(index)[index],
                        imagePath: AppVars.dashboardData[index].entries
                            .toList()[0]
                            .value,
                        menuname: AppVars.dashboardData[index].entries
                            .toList()[0]
                            .key)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
