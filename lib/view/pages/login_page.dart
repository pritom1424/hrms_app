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
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  Color actionButtonBgColor = const Color.fromARGB(255, 68, 156, 204);
  Color actionButtonFgColor = Colors.white;
  final _formInfoKey = GlobalKey<FormState>();

  @override
  void initState() {
    if (widget.isLogOut != null) {
      if (widget.isLogOut == true) {
        Provider.of<HrmsAuthController>(context, listen: false).logout();
      }
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passController.dispose();
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
                    Container(
                      color: Appcolors.assignButtonColor,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          ImagePath.logoPath,
                          width: AppVars.screenSize.width *
                              0.6, // Adjust as needed
                          height: AppVars.screenSize.height * 0.06,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
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
                            Icon(Icons.email_outlined, color: Colors.grey),
                      ),
                      validator: (value) {
                        if (value != null && value == "") {
                          return AppStrings.emailErrorText;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
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
                      ),
                      validator: (value) {
                        if (value != null && value == "") {
                          return AppStrings.passErrorText;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 50),
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
                        FocusScope.of(context).unfocus();
                        if (_formInfoKey.currentState == null) {
                          return;
                        }
                        if (_formInfoKey.currentState!.validate()) {
                          _formInfoKey.currentState!.save();
                          final prov = Provider.of<HrmsAuthController>(context,
                              listen: false);
                          prov.setLoading(true);
                          final result = await prov.Authenticate(
                              emailController.text, passController.text);

                          prov.setLoading(false);

                          if (result) {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (ctx) => RootNavPage()));
                          } else {
                            AppMethods().snackBar(
                                AppStrings.loginErrorMessage, context);
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
                    Consumer<HrmsAuthController>(builder: (ctx, snap, ch) {
                      if (snap.isLoading) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: Appcolors.contentColorPurple,
                          ),
                        );
                      } else {
                        return SizedBox.shrink();
                      }
                    })
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
