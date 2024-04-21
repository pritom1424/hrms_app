import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hrms_app/utils/app_colors/app_colors.dart';

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
          unselectedItemColor: const Color.fromARGB(255, 49, 150, 153),
          selectedItemColor: Appcolors.navbarAppSelectColor,
          showUnselectedLabels: false,
          showSelectedLabels: false,
          currentIndex: currentIndex,
          iconSize: 25,
          onTap: onTap, //_onItemTapped
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.home), label: "home"),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.person_2), label: "employee"),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.profile_circled), label: "profile"),
            BottomNavigationBarItem(icon: Icon(Icons.logout), label: "logout")
          ],
        ),
      ),
    );
  }
}
