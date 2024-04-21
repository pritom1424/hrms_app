import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hrms_app/view/pages/home_page.dart';

class SplasScreen extends StatefulWidget {
  SplasScreen({super.key});

  @override
  State<SplasScreen> createState() => _SplasScreenState();
}

class _SplasScreenState extends State<SplasScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (ctx) => HomePage()));
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size scSize = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
            //   height: GenericVars.scSize.height,
            width: double.infinity,
            child: Center(
                child: Image.asset(
                    "assets/images/dummy_splash_logo.png") //Text("Splash Screen"),
                )));
  }
}
