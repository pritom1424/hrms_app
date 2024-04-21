import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hrms_app/utils/app_variables/app_vars.dart';
import 'package:hrms_app/view/widgets/app_drawer/custom_app_drawer.dart';
import 'package:hrms_app/view/widgets/appbar_default_widget.dart';
import 'package:hrms_app/view/widgets/navbar_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedNavIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppVars.screenSize = MediaQuery.of(context).size;
    List<Widget> navViews() {
      return [
        //dashboard
        Center(
          child: Text(
              AppVars.navBarData[_selectedNavIndex].entries.toList()[0].key),
        ),
        //employee list
        Center(
          child: Text(
              AppVars.navBarData[_selectedNavIndex].entries.toList()[0].key),
        ),
        // users
        Center(
          child: Text(
              AppVars.navBarData[_selectedNavIndex].entries.toList()[0].key),
        ),

        // settings
        Center(
          child: Text(
              AppVars.navBarData[_selectedNavIndex].entries.toList()[0].key),
        ),
        //logout
        Center(
          child: Text(
              AppVars.navBarData[_selectedNavIndex].entries.toList()[0].key),
        ),
      ];
    }

    void onNavigationTap(int index) {
      setState(() {
        _selectedNavIndex = index;
      });
    }

    return SafeArea(
      child: Scaffold(
        appBar: const AppbarDefault(),
        drawer: const CustomAppDrawer(),
        bottomNavigationBar: NavBarWidget(
          currentIndex: _selectedNavIndex,
          onTap: onNavigationTap,
        ),
        body: navViews()[_selectedNavIndex],
      ),
    );
  }
}
