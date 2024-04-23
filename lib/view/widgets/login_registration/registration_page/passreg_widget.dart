import 'package:flutter/material.dart';
import 'package:hrms_app/utils/app_variables/app_vars.dart';

class PasswordRegField extends StatelessWidget {
  PasswordRegField({Key? key, required this.focusNode}) : super(key: key);

  final FocusNode focusNode;
  final ValueNotifier<bool> _obSecurePassword = ValueNotifier<bool>(true);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: _obSecurePassword,
        builder: (context, value, child) {
          return SizedBox(
            height: AppVars.screenSize.height * 0.07,
            child: TextFormField(
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
              autofocus: false,
              obscureText: _obSecurePassword.value,
              focusNode: focusNode,
              obscuringCharacter: "*",
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 0.3)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 0.3)),
                hintText: 'Password',
                labelText: 'Password',
                labelStyle: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
                prefixIcon: const Icon(
                  Icons.lock_open_rounded,
                  color: Colors.grey,
                ),
                suffixIcon: InkWell(
                    onTap: () {
                      _obSecurePassword.value = !_obSecurePassword.value;
                    },
                    child: Icon(_obSecurePassword.value
                        ? Icons.visibility_off_outlined
                        : Icons.visibility)),
              ),
              onChanged: (value) {
                // provider.setPassword(value);
              },
            ),
          );
        });
    /*  return Consumer<RegistrationProvider>(builder: (context, provider, child) {
      return ValueListenableBuilder(
          valueListenable: _obSecurePassword,
          builder: (context, value, child) {
            return SizedBox(
              height: GenericVars.scSize.height * 0.07,
              child: TextFormField(
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                autofocus: false,
                obscureText: _obSecurePassword.value,
                focusNode: focusNode,
                obscuringCharacter: "*",
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 0.3)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 0.3)),
                  hintText: 'Password',
                  labelText: 'Password',
                  labelStyle: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                  prefixIcon: const Icon(
                    Icons.lock_open_rounded,
                    color: Colors.grey,
                  ),
                  suffixIcon: InkWell(
                      onTap: () {
                        _obSecurePassword.value = !_obSecurePassword.value;
                      },
                      child: Icon(_obSecurePassword.value
                          ? Icons.visibility_off_outlined
                          : Icons.visibility)),
                ),
                onChanged: (value) {
                  provider.setPassword(value);
                },
              ),
            );
          });
    }); */
  }
}
