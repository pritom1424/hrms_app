// loginForm widget

import 'package:flutter/material.dart';

import 'package:hrms_app/controller/hrms_auth_controller.dart';
import 'package:hrms_app/utils/app_colors/app_colors.dart';
import 'package:hrms_app/utils/app_methods/app_methods.dart';
import 'package:hrms_app/utils/app_variables/app_strings.dart';
import 'package:hrms_app/utils/app_variables/app_vars.dart';
import 'package:hrms_app/utils/app_variables/image_paths.dart';

import 'package:hrms_app/view/pages/root_nav_page.dart';
import 'package:hrms_app/view/widgets/appbar_default_widget.dart';

import 'package:provider/provider.dart';

class LoginForm extends StatefulWidget {
  final String? title;
  final bool? isLogOut;
  const LoginForm({super.key, this.title, this.isLogOut});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  /* final emailFocusNode = FocusNode();

  final passwordFocusNode = FocusNode(); */

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  Color actionButtonBgColor = const Color.fromARGB(255, 68, 156, 204);
  Color actionButtonFgColor = Colors.white;
  final _formInfoKey = GlobalKey<FormState>();

  @override
  void initState() {
    print("init login");

    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passController.dispose();
/*     emailFocusNode.dispose();
    passwordFocusNode.dispose(); */
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (widget.title == null)
          ? null
          : AppbarDefault(
              appbarName: widget.title,
            ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Container(
              height: AppVars.screenSize.height * 0.8,
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Form(
                key: _formInfoKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Image.asset(
                      ImagePath.splashLogoPath,
                      width: AppVars.screenSize.width * 0.6, // Adjust as needed
                      height: AppVars.screenSize.height * 0.06,
                    ),
                    const SizedBox(height: 50),
                    TextFormField(
                      //focusNode: emailFocusNode,
                      controller: emailController,
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.normal),
                      //autofocus: false,
                      enabled: true,
                      decoration: const InputDecoration(
                        errorBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 0.3)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 0.3)),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 0.3)),
                        hintText: 'Email',
                        labelText: 'Email',
                        labelStyle: TextStyle(fontSize: 18, color: Colors.grey),
                        prefixIcon:
                            Icon(Icons.lock_open_rounded, color: Colors.grey),
                        /*    suffixIcon: InkWell(
                            onTap: () {
                              _obSecurePassword.value = !_obSecurePassword.value;
                            },
                            child: Icon(_obSecurePassword.value
                                ? Icons.visibility_off_outlined
                                : Icons.visibility)), */
                      ),
                      validator: (value) {
                        if (value != null && value == "") {
                          return AppStrings.emailErrorText;
                        }
                        return null;
                      },
                      /*   onChanged: (value) {
                        //  provider.setPassword(value);
                      }, */
                      // passwordFocusNode: passwordFocusNode,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      // focusNode: passwordFocusNode,
                      controller: passController,
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.normal),
                      autofocus: false,
                      obscureText: true,
                      obscuringCharacter: "*",
                      decoration: const InputDecoration(
                        errorBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 0.3)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 0.3)),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 0.3)),
                        hintText: 'Password',
                        labelText: 'Password',
                        labelStyle: TextStyle(fontSize: 18, color: Colors.grey),
                        prefixIcon:
                            Icon(Icons.lock_open_rounded, color: Colors.grey),
                        /* suffixIcon: InkWell(
                            onTap: () {
                              _obSecurePassword.value = !_obSecurePassword.value;
                            },
                            child: Icon(_obSecurePassword.value
                                ? Icons.visibility_off_outlined
                                : Icons.visibility)), */
                      ),
                      validator: (value) {
                        if (value != null && value == "") {
                          return AppStrings.passErrorText;
                        }
                        return null;
                      },
                      /*  onChanged: (value) {
                        //  provider.setPassword(value);
                      }, */
                    ),
                    const SizedBox(height: 50),
                    // LoginButtonWidget(),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                          ),
                          backgroundColor: Appcolors.assignButtonColor,
                          foregroundColor: actionButtonFgColor),
                      onPressed: () async {
                        if (_formInfoKey.currentState == null) {
                          return;
                        }
                        if (_formInfoKey.currentState!.validate()) {
                          _formInfoKey.currentState!.save();
                          final result = await Provider.of<HrmsAuthController>(
                                  context,
                                  listen: false)
                              .Authenticate(
                                  emailController.text, passController.text);

                          if (result) {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (ctx) => RootNavPage()));
                          } else {
                            AppMethods().snackBar("Login Failed!", context);
                          }
                        }
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    /* TextButton(
                        onPressed: () {},
                        child: const Text("Forgotten Password?")), */
                    /*  const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) => const RegisterPage()));
                      },
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          fixedSize: Size(AppVars.screenSize.width * 0.9,
                              AppVars.screenSize.height * 0.065)),
                      child: const Text(
                        "Create New Account",
                        style: TextStyle(fontSize: 18),
                      ),
                    ) */
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}



// provider

/* class PasswordValidator {
  static bool validate(String value) {
    return value.length >= 6;
  }
} */
