import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../app_variables/app_vars.dart';
import 'package:dio/dio.dart';

class AppMethods {
  // we will use this function to shift focus from one text field to another text field
  // we are using to avoid duplications of code
  /* static void fieldFocusChange(
      BuildContext context, FocusNode current, FocusNode nextFocus) {
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  } */

  String dateTimeToTimeString(TimeOfDay timeOfDay) {
    final now = DateTime.now();
    return DateFormat.jm().format(DateTime(
        now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute));
  }

  TimeOfDay dateStringToTimeOfDay(String? timeString) {
    if (timeString == null || timeString.isEmpty) {
      return TimeOfDay.now();
    }
    List<String> parts = timeString.split(' '); // Split the string by space
    String timePart = parts[0]; // Get the time part (e.g., "5:00")
    List<String> timeParts =
        timePart.split(':'); // Split the time part by colon

    int hour = int.parse(timeParts[0]); // Parse the hour part
    int minute = int.parse(timeParts[1]); // Parse the minute part

    if (parts[1].toLowerCase() == 'pm' && hour != 12) {
      hour +=
          12; // Convert hour to 24-hour format if it's PM and not already 12 PM
    } else if (parts[1].toLowerCase() == 'am' && hour == 12) {
      hour = 0; // Convert 12 AM to 0 (midnight) in 24-hour format
    }

    return TimeOfDay(hour: hour, minute: minute);
  }

  String? stripLink(String htmlString) {
    if (htmlString.isEmpty || htmlString == "") {
      return null;
    }
    RegExp regex = RegExp(r'https?://[^\s"]+\.(jpg|png)');
    String? imageUrl = regex.stringMatch(htmlString);

    return imageUrl;
  }

  Future<String?> testLink(String url) async {
    Dio dio = Dio();
    if (url.isEmpty) {
      return null;
    }
    final response = await dio.get(url);
    if (response.statusCode == 200) {
      return url;
    }
    return null;
  }

  int? employeeCodeToId(String employeeCode) {
    return int.tryParse(RegExp(r'\d+').firstMatch(employeeCode)!.group(0)!);
  }

  String idToemployeeCode(int employeeId) {
    String paddedId = employeeId.toString().padLeft(4, '0');

    return 'SZT-$paddedId';
  }

  ////
  String dateOfBirthFormat(DateTime? dateTime) {
    DateTime currentDate = DateTime.now();
    if (dateTime != null) {
      currentDate = dateTime;
    }
    String formattedDate = DateFormat('yyyy-MM-dd').format(currentDate);
    return formattedDate;
  }

  String timeIn24Hour(DateTime? dateTime, TimeOfDay tDay) {
    DateTime currentDate = DateTime.now();
    if (dateTime != null) {
      currentDate = DateTime(
          dateTime.year, dateTime.month, dateTime.day, tDay.hour, tDay.minute);
    }

    String formatteDate = DateFormat('HH:mm').format(currentDate);
    return formatteDate;
  }

  // generic toast message imported from toast package
  // we will utilise this for showing errors or success messages
  /*  static toastMessage(String message){
    Fluttertoast.showToast(
        msg: message,
    backgroundColor: Colors.black,
      textColor: Colors.white,
    );
  } */
  Future<void> showAlertPop(
      BuildContext context,
      Widget titleWidget,
      Widget contentWidget,
      void Function()? yesFunction,
      void Function()? noFunction) {
    return showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: titleWidget,
              /* insetPadding: EdgeInsets.symmetric(
                  horizontal: 10, vertical: 24), */ //const Text("Are you sure?"),
              content:
                  contentWidget /* Container(
                  width: AppVars.screenSize.width,
                  height: AppVars.screenSize.width * 0.1,
                  child:
                      contentWidget)  */
              ,
              alignment: Alignment.center,
              titleTextStyle: Theme.of(context).textTheme.titleLarge,
              actionsPadding:
                  EdgeInsets.only(left: 3, right: 3, top: 5, bottom: 20),

              contentTextStyle: TextStyle(
                  fontSize: 18,
                  color: const Color.fromARGB(255, 121, 119, 119)),
              actionsAlignment: MainAxisAlignment.center,
              actions: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        // padding: EdgeInsets.only(left: 0,right: ),
                        minimumSize: Size(AppVars.screenSize.width * 0.3,
                            AppVars.screenSize.height * 0.04),
                        backgroundColor: Colors.blueAccent,
                        foregroundColor: Colors.white),
                    onPressed: () {
                      Navigator.of(context).pop(true);
                      if (yesFunction != null) {
                        yesFunction();
                      }
                    },
                    child: const Text("Yes")),
                if (noFunction != null)
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        //padding: EdgeInsets.all(0),
                        minimumSize: Size(AppVars.screenSize.width * 0.3,
                            AppVars.screenSize.height * 0.04),
                        /* backgroundColor: Colors.blueAccent,
                        foregroundColor: Colors.white */
                      ),
                      onPressed: () {
                        noFunction();
                        Navigator.of(context).pop(false);
                      },
                      child: const Text("No"))
              ],
            ));
  }

  // we will utilise this for showing errors or success messages
  snackBar(String message, BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(backgroundColor: Colors.red, content: Text(message)));
  }
}
