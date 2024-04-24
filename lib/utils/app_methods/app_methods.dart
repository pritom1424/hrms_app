import 'package:flutter/material.dart';
import 'package:hrms_app/utils/app_variables/app_vars.dart';

class AppMethods {
  // we will use this function to shift focus from one text field to another text field
  // we are using to avoid duplications of code
  static void fieldFocusChange(
      BuildContext context, FocusNode current, FocusNode nextFocus) {
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
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
