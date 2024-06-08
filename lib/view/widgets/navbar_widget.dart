import 'package:flutter/material.dart';
import '../../utils/app_colors/app_colors.dart';
import '../../utils/app_variables/app_vars.dart';

class NavBarWidget extends StatelessWidget {
  final int currentIndex;
  final void Function(int)? onTap;
  const NavBarWidget({super.key, required this.currentIndex, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Appcolors.navbarBgColor,
      unselectedItemColor: Appcolors.navbarAppUnSelectColor,
      selectedItemColor: Appcolors.navbarAppSelectColor,
      showUnselectedLabels: true,
      showSelectedLabels: true,
      currentIndex: currentIndex,
      iconSize: 22,
      onTap: onTap, //_onItemTapped
      items: List.generate(
          AppVars.navBarData.length,
          (index) => BottomNavigationBarItem(
              icon: Icon(
                AppVars.navBarData[index].entries.toList()[0].value,
              ),
              label: AppVars.navBarData[index].entries.toList()[0].key)),
    ));
  }
}
