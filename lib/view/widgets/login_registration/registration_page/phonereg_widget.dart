import 'package:flutter/material.dart';
import '../../../../utils/app_methods/app_methods.dart';
import '../../../../utils/app_variables/app_vars.dart';

class PhoneRegField extends StatelessWidget {
  final FocusNode focusNode, passwordFocusNode;
  const PhoneRegField(
      {Key? key, required this.focusNode, required this.passwordFocusNode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppVars.screenSize.height * 0.07,
      child: TextFormField(
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
        autofocus: false,
        keyboardType: TextInputType.number,
        focusNode: focusNode,
        decoration: const InputDecoration(
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 0.3)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 0.3)),
            hintText: 'Phone',
            labelText: 'Phone',
            labelStyle: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
            prefixIcon: Icon(
              Icons.phone,
              color: Colors.grey,
            )),
        onFieldSubmitted: (value) {
          AppMethods.fieldFocusChange(context, focusNode, passwordFocusNode);
        },
        onChanged: (value) {
          print(value);
          // provider.setPhone(value);
        },
      ),
    );

    /* Consumer<RegistrationProvider>(builder: (context, provider, child) {
      return SizedBox(
        height: GenericVars.scSize.height * 0.07,
        child: TextFormField(
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
          autofocus: false,
          keyboardType: TextInputType.number,
          focusNode: focusNode,
          decoration: const InputDecoration(
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 0.3)),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 0.3)),
              hintText: 'Phone',
              labelText: 'Phone',
              labelStyle: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
              prefixIcon: Icon(
                Icons.phone,
                color: Colors.grey,
              )),
          onFieldSubmitted: (value) {
            Utils.fieldFocusChange(context, focusNode, passwordFocusNode);
          },
          onChanged: (value) {
            print(value);
            provider.setPhone(value);
          },
        ),
      );
    }); */
  }
}
