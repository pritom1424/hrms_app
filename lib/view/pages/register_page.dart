import 'package:flutter/material.dart';
import 'package:hrms_app/utils/app_variables/app_vars.dart';
import 'package:hrms_app/utils/app_variables/image_paths.dart';
import 'package:hrms_app/view/widgets/login_registration/registration_page/emailreg_widget.dart';
import 'package:hrms_app/view/widgets/login_registration/registration_page/namereg_widget.dart';
import 'package:hrms_app/view/widgets/login_registration/registration_page/passreg_widget.dart';
import 'package:hrms_app/view/widgets/login_registration/registration_page/phonereg_widget.dart';
import 'package:hrms_app/view/widgets/login_registration/registration_page/registerbutton_widget.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailFocusNode = FocusNode();

  final passwordFocusNode = FocusNode();
  final nameFocusNode = FocusNode();
  final phoneFocusNose = FocusNode();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Sign Up",
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Container(
            height: AppVars.screenSize.height * 0.8,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  ImagePath.splashLogoPath,
                  width: AppVars.screenSize.width * 0.6, // Adjust as needed
                  height: AppVars.screenSize.height * 0.06,
                ),
                SizedBox(
                  height: 20,
                ),
                EmailRegField(
                    focusNode: emailFocusNode,
                    passwordFocusNode: nameFocusNode),
                SizedBox(height: 20),
                NameRegField(
                    focusNode: nameFocusNode,
                    passwordFocusNode: phoneFocusNose),
                SizedBox(height: 20),
                PhoneRegField(
                    focusNode: phoneFocusNose,
                    passwordFocusNode: passwordFocusNode),
                SizedBox(
                  height: 20,
                ),
                PasswordRegField(focusNode: passwordFocusNode),
                SizedBox(
                  height: 30,
                ),
                RegButtonWidget(),
                SizedBox(
                  height: 30,
                ),
                InkWell(
                  onTap: () {
                    print("google");
                  },
                  child: Container(
                    height: AppVars.screenSize.height * 0.07,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 0.8,
                        color: Color.fromARGB(255, 218, 236, 252),
                      ),
                      borderRadius: BorderRadius.circular(12),
                      color: Color.fromARGB(255, 218, 236, 252),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 13,
                          backgroundImage:
                              AssetImage("assets/images/google_icon.png"),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Continue With Google",
                          style: TextStyle(fontSize: 18),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    print('facebook');
                  },
                  child: Container(
                    height: AppVars.screenSize.height * 0.07,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 0.8,
                        color: Color.fromARGB(255, 218, 236, 252),
                      ),
                      borderRadius: BorderRadius.circular(12),
                      color: Color.fromARGB(255, 218, 236, 252),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 13,
                          backgroundImage:
                              AssetImage("assets/images/facebook-icon.png"),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Continue With Facebook",
                          style: TextStyle(fontSize: 18),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
