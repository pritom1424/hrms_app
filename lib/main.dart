import 'package:flutter/material.dart';
import 'controller/employee_data_controller.dart';
import 'view/pages/splash_page_2.dart';
import 'package:provider/provider.dart';

import 'utils/app_colors/app_colors.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      Provider<EmployeeDataController>(
        create: (_) => EmployeeDataController(),
      )
    ],
    child: const MyApp(),
  ));
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
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 20),
            ),
            textTheme: const TextTheme(
                //menu item
                labelSmall:
                    TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                labelMedium:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                headlineLarge:
                    TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                headlineMedium:
                    TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                headlineSmall:
                    TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                titleLarge:
                    TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                titleMedium:
                    TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                /*   bodyLarge:
                    TextStyle(fontSize: 25, fontWeight: FontWeight.normal), */
                /*   bodyMedium:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.normal), */
                bodySmall:
                    TextStyle(fontSize: 14, fontWeight: FontWeight.normal))
//        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            // useMaterial3: true,
            ),
        home: SplashPage2() //SplashScreen(),
        );
  }
}
