// loginButton

import 'package:flutter/material.dart';
import 'package:hrms_app/utils/app_components/round_button.dart';
//import 'package:provider/provider.dart';

class LoginButtonWidget extends StatelessWidget {
  LoginButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RoundButton(
      title: 'Login',
      loading: false, //provider.loginLoading ? true : false,
      onPress: () {
        /* if (provider.email.isEmpty) {
            // Utils.flushBarErrorMessage('Please enter email', context);
          } else if (AppValidator.emailValidator(provider.email.toString())) {
            // Utils.flushBarErrorMessage('Please enter valid email', context);
          } else if (provider.password.isEmpty) {
            // Utils.flushBarErrorMessage('Please enter password', context);
          } else if (provider.password.length < 6) {
            // Utils.flushBarErrorMessage(
            //     'Please enter 6 digit password', context);
          } else {
            Map data = {
              'email': provider.email.toString(),
              'password': provider.password.toString(),
            };

            // Map data = {
            //   'email' : 'eve.holt@reqres.in',
            //   'password' : 'cityslicka',
            // };

            provider.loginApi(data).then((value) {
              if (value!['code'] == 200) {
                FocusNode().unfocus();
              } else {
                //Utils.flushBarErrorMessage("Try Again", context);
              }
            }).onError((error, stackTrace) {
              // Utils.flushBarErrorMessage(error.toString(), context);
            });
          } */
      },
    );

    /* return Consumer<LoginProvider>(builder: (context, provider, child) {

      
      return RoundButton(
        title: 'Login',
        loading: provider.loginLoading ? true : false,
        onPress: () {
          if (provider.email.isEmpty) {
            // Utils.flushBarErrorMessage('Please enter email', context);
          } else if (AppValidator.emailValidator(provider.email.toString())) {
            // Utils.flushBarErrorMessage('Please enter valid email', context);
          } else if (provider.password.isEmpty) {
            // Utils.flushBarErrorMessage('Please enter password', context);
          } else if (provider.password.length < 6) {
            // Utils.flushBarErrorMessage(
            //     'Please enter 6 digit password', context);
          } else {
            Map data = {
              'email': provider.email.toString(),
              'password': provider.password.toString(),
            };

            // Map data = {
            //   'email' : 'eve.holt@reqres.in',
            //   'password' : 'cityslicka',
            // };

            provider.loginApi(data).then((value) {
              if (value!['code'] == 200) {
                FocusNode().unfocus();
              } else {
                //Utils.flushBarErrorMessage("Try Again", context);
              }
            }).onError((error, stackTrace) {
              // Utils.flushBarErrorMessage(error.toString(), context);
            });
          }
        },
      );
    }); */
  }
}
