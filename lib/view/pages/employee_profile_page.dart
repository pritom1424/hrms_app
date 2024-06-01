import 'package:flutter/material.dart';
import 'package:hrms_app/controller/employee_profile_controller.dart';
import 'package:hrms_app/model/employee_profile_model.dart';
import 'package:hrms_app/utils/app_methods/app_methods.dart';
import 'package:hrms_app/utils/app_variables/api_links.dart';
import 'package:hrms_app/utils/app_variables/user_credential.dart';
import 'package:provider/provider.dart';
import '../../utils/app_variables/app_vars.dart';
import '../../utils/app_variables/image_paths.dart';
import '../widgets/appbar_default_widget.dart';

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
    final prov = Provider.of<EmployeeProfileController>(context);

    // form vars
    EdgeInsetsGeometry contentPadding = const EdgeInsets.only(left: 60);

    Color borderColor = const Color.fromARGB(255, 189, 183, 183);
    double borderWidth = 1;

    //font related
    TextStyle textStyle =
        const TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
    TextStyle textStyleVal =
        const TextStyle(fontSize: 18, fontWeight: FontWeight.normal);

    // profile
    TextStyle profileNameTextStyle =
        const TextStyle(fontSize: 25, fontWeight: FontWeight.bold);
    TextStyle profileDesignationTextStyle = const TextStyle(
        fontSize: 18, color: Colors.grey, fontWeight: FontWeight.bold);

    Widget officialTabWidget(HrmsEmployeeProfileModel eprofile) {
      List<String> formDataTab2 = [
        "Employee ID",
        "Employee Code",
        "Shift",
        "Shift Date",
        "Joining Date",
        "Confirmation Date"
      ];
      List<String?> values = [
        eprofile.officeInformation.employeeId,
        eprofile.employeeCode,
        eprofile.officeInformation.shiftId,
        AppMethods().dateOfBirthFormat(eprofile.officeInformation.shiftDate),
        AppMethods().dateOfBirthFormat(eprofile.officeInformation.joiningDate),
        AppMethods()
            .dateOfBirthFormat(eprofile.officeInformation.confirmationDate),
      ];

      return Column(
        children: List.generate(
            formDataTab2.length,
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
                      Flexible(
                        child: Container(
                          alignment: Alignment.centerLeft,
                          padding: contentPadding,
                          child: Text(
                            formDataTab2[index],
                            style: textStyle,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          padding: contentPadding,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            values[index] ?? "",
                            overflow: TextOverflow.ellipsis,
                            style: textStyleVal,
                            maxLines: 1,
                          ),
                        ),
                      )
                    ],
                  ),
                )),
      );
    }

    Widget personalTabWidget(HrmsEmployeeProfileModel eprofile) {
      List<String> formDataTab1 = [
        "Date of Birth",
        "Gender",
        "Father Name",
        "Mother Name",
        "Nationality",
        eprofile.idType ?? "Id Type",
        "Permanent Address",
        "Present Address"
      ];
      List<String?> values = [
        AppMethods().dateOfBirthFormat(eprofile.dateOfBirth),
        eprofile.gender,
        eprofile.employeeFather,
        eprofile.employeeMother,
        eprofile.nationality,
        eprofile.idNumber,
        eprofile.presentAddress,
        eprofile.permanentAddress
      ];

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
                          alignment: Alignment.centerLeft,
                          padding: contentPadding,
                          child: Text(
                            formDataTab1[index],
                            //  textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: textStyle,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerLeft,
                          padding: contentPadding,
                          child: Text(
                            values[index] ?? "",
                            //  textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: textStyleVal,
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
      body: (UserCredential.userid == null)
          ? Center(
              child: Text("No Id Found!"),
            )
          : FutureBuilder(
              future: prov.getEmployeeProfile(
                  ApiLinks.employeeProfileLink, UserCredential.userid!),
              builder: (context, snap) {
                if (snap.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (!snap.hasData) {
                  return FutureBuilder(
                      future: prov.getAdminProfile(
                          ApiLinks.employeeProfileLink, UserCredential.userid!),
                      builder: (ctx, snapAdmin) => (snapAdmin.hasData)
                          ? Container(
                              height: AppVars.screenSize.height,
                              width: double.infinity,
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                      backgroundImage: AssetImage(
                                          ImagePath.proPicPlaceholderPath),
                                      radius: 50,
                                    ),
                                    Text(
                                      snapAdmin.data!.name ?? "",
                                      style: profileNameTextStyle,
                                    ),
                                    Text(
                                      snapAdmin.data!.email ?? "",
                                      style: profileDesignationTextStyle,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : SizedBox.shrink());
                }
                print("image ${snap.data!.image}");
                return Container(
                  height: AppVars.screenSize.height,
                  width: double.infinity,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundImage: (snap.data!.image != null)
                              ? NetworkImage(
                                      "https://hrms.szamantech.com/storage/employee/${snap.data!.image}")
                                  as ImageProvider
                              : AssetImage(ImagePath.proPicPlaceholderPath),
                          radius: 50,
                        ),
                        Text(
                          snap.data!.employeeName ?? "",
                          style: profileNameTextStyle,
                        ),
                        Text(
                          snap.data!.officeInformation.designation ?? "",
                          style: profileDesignationTextStyle,
                        ),
                        TabBar(
                            tabAlignment: TabAlignment.fill,
                            labelStyle: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
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
                              children: [
                                officialTabWidget(snap.data!),
                                personalTabWidget(snap.data!)
                              ]),
                        )
                      ],
                    ),
                  ),
                );
              }),
    );
  }
}
