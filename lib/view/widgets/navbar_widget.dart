import 'package:flutter/material.dart';
import 'package:hrms_app/utils/app_colors/app_colors.dart';
import 'package:hrms_app/utils/app_variables/app_vars.dart';

class NavBarWidget extends StatelessWidget {
  final int currentIndex;
  final void Function(int)? onTap;
  const NavBarWidget({super.key, required this.currentIndex, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
        // margin: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: const Color.fromRGBO(0, 0, 0, 0),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.35),
                  blurRadius: 30,
                  offset: const Offset(0, 10))
            ],
            borderRadius: BorderRadius.circular(30)),
        child: ClipRRect(
          /* borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
          bottomLeft: Radius.circular(30.0),
          bottomRight: Radius.circular(30.0),
        ), */
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Appcolors.navbarBgColor,
            unselectedItemColor: Appcolors.navbarAppUnSelectColor,
            selectedItemColor: Appcolors.navbarAppSelectColor,
            showUnselectedLabels: true,
            showSelectedLabels: true,
            currentIndex: currentIndex,
            iconSize: 30,
            onTap: onTap, //_onItemTapped
            items: List.generate(
                AppVars.navBarData.length,
                (index) => BottomNavigationBarItem(
                    icon: Icon(
                      AppVars.navBarData[index].entries.toList()[0].value,
                    ),
                    label: AppVars.navBarData[index].entries.toList()[0].key)),
          ),
        ));
  }
}
