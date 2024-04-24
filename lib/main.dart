import 'package:flutter/material.dart';
import 'package:hrms_app/utils/app_colors/app_colors.dart';
import 'package:hrms_app/view/pages/root_nav_page.dart';
import 'package:hrms_app/view/pages/splash_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          scaffoldBackgroundColor: Appcolors.appBgColor,
          appBarTheme: AppBarTheme(
            backgroundColor: Appcolors.appBarColor,
            titleTextStyle: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
          ),
          textTheme: const TextTheme(
            //menu item
            labelMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
            headlineLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            titleLarge: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          )
//        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          // useMaterial3: true,
          ),
      home: SplashScreen(),
    );
  }
}
