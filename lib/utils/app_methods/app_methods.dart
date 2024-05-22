import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../app_variables/app_vars.dart';

class AppMethods {
  // we will use this function to shift focus from one text field to another text field
  // we are using to avoid duplications of code
  static void fieldFocusChange(
      BuildContext context, FocusNode current, FocusNode nextFocus) {
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  String dateTimeToTimeString(TimeOfDay timeOfDay) {
    final now = DateTime.now();
    return DateFormat.jm().format(DateTime(
        now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute));
  }

  TimeOfDay dateStringToTimeOfDay(String? timeString) {
    if (timeString == null || timeString.isEmpty) {
      return TimeOfDay.now();
    }
    TimeOfDay resultTime = TimeOfDay(
        hour: int.parse(timeString.split(":")[0]),
        minute: int.parse(timeString.split(":")[1]));

    return resultTime;
  }

  String? stripLink(String htmlString) {
    if (htmlString.isEmpty || htmlString == "") {
      return null;
    }
    RegExp regex = RegExp(r'https?://[^\s"]+\.(jpg|png)');
    String? imageUrl = regex.stringMatch(htmlString);

    return imageUrl;
  }

  static int? employeeCodeToId(String employeeCode) {
    return int.tryParse(RegExp(r'\d+').firstMatch(employeeCode)!.group(0)!);
  }

  ////
  static String dateOfBirthFormat(DateTime? dateTime) {
    DateTime currentDate = DateTime.now();
    if (dateTime != null) {
      currentDate = dateTime;
    }
    String formattedDate = DateFormat('yyyy-MM-dd').format(currentDate);
    return formattedDate;
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
  static Future<void> showAlertPop(
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
}

// we will utilise this for showing errors or success messages
snackBar(String message, BuildContext context) {
  return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(backgroundColor: Colors.red, content: Text(message)));
}
