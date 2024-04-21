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
    List<Widget> _navViews() {
      return [
        //dashboard
        const Center(
          child: Text("dashboard"),
        ),
        //employee list
        const Center(
          child: Text("employee list"),
        ),
        // profile
        const Center(
          child: Text("profile"),
        ),
        //logout
        const Center(
          child: Text("log out"),
        )
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
        body: _navViews()[_selectedNavIndex],
      ),
    );
  }
}
