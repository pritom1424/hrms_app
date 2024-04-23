import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hrms_app/utils/app_variables/app_vars.dart';
import 'package:hrms_app/utils/app_variables/image_paths.dart';
import 'package:hrms_app/view/pages/root_nav_page.dart';
import 'package:hrms_app/view/widgets/splash_page/splash_logo_animation.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (ctx) => RootNavPage()));
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            //   height: GenericVars.scSize.height,
            width: double.infinity,
            child: Center(
              child: SplashLogoAnimation(imagePath: ImagePath.splashLogoPath),
            )));
  }
}
