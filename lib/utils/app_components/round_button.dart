import 'package:flutter/material.dart';
import 'package:hrms_app/utils/app_variables/app_vars.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final bool loading;
  final VoidCallback onPress;
  const RoundButton({
    Key? key,
    required this.title,
    this.loading = false,
    required this.onPress,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        height: AppVars.screenSize.height * 0.065,
        width: AppVars.screenSize.width * 0.9,
        decoration: BoxDecoration(
            color: Colors.blueAccent, borderRadius: BorderRadius.circular(10)),
        child: Center(
            child: loading
                ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                : Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  )),
      ),
    );
  }
}
