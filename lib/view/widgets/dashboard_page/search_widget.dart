import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../../utils/app_colors/app_colors.dart';
import '../../../utils/app_variables/app_strings.dart';

class SearcWidget extends StatefulWidget {
  const SearcWidget({super.key});

  @override
  State<SearcWidget> createState() => _SearcWidgetState();
}

class _SearcWidgetState extends State<SearcWidget> {
  TextEditingController textEditingController = TextEditingController();
  bool didShowList = true;
  @override
  void initState() {
    // _speech = stt.SpeechToText();

    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    //currentSearchItems.clear();
    textEditingController.dispose();
    didShowList = false;
    //GenericVars.currentSearchString = "";
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    onSubmitted: (value) {
                      didShowList = true;
                      textEditingController.text =
                          textEditingController.text.trim();
                      /* GenericVars.currentSearchString =
                                    textEditingController.text; */
                      FocusScopeNode currentFocus = FocusScope.of(context);
                      if (!currentFocus.hasPrimaryFocus) {
                        currentFocus.unfocus();
                      }

                      setState(() {});
                    },
                    controller: textEditingController,
                    style: const TextStyle(
                        fontSize: 18,
                        color: Color.fromARGB(255, 105, 102, 102)),
                    /*   onChanged: (value) {
                                textEditingController.clear();
                                textEditingController.text = value;
                              }, */
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Appcolors.searchbarBgColor,
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                width: 1, color: Appcolors.searchbarBgColor)),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 5),
                        hintText: AppStrings.searchPlaceholderText,
                        /*  suffixIcon: AvatarGlow(
                                    glowRadiusFactor: 0.1,
                                    animate: _isListening,
                                    glowColor: (didGlow)
                                        ? Theme.of(context).primaryColor
                                        : Colors.white,
                                    duration: const Duration(milliseconds: 2000),
                                    // repeatPauseDuration: const Duration(milliseconds: 100),
                                    repeat: true,
                                    child: IconButton(
                                      onPressed: _listen,
                                      icon:
                                          Icon(_isListening ? Icons.mic : Icons.mic_none),
                                    ),
                                  ), */
                        prefixIcon: IconButton(
                            onPressed: () {
                              didShowList = true;
                              textEditingController.text =
                                  textEditingController.text.trim();
                              /*   GenericVars.currentSearchString =
                                            textEditingController.text; */
                              FocusScopeNode currentFocus =
                                  FocusScope.of(context);
                              if (!currentFocus.hasPrimaryFocus) {
                                currentFocus.unfocus();
                              }

                              setState(() {});
                              /* Navigator.of(context).push(MaterialPageRoute(
                                            builder: (ctx) => SearchToNewPage(
                                                textEditingController.text))); */
                            },
                            icon: const Icon(Icons.search)),
                        hintStyle: const TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.normal),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                width: 1, color: Appcolors.searchbarBgColor))),
                  ),
                ),
                /*  SizedBox(
                  width: 20,
                ),
                CircleAvatar(
                  backgroundColor: Appcolors.searchbarBgColor,
                  radius: 23,
                  child: IconButton(
                      onPressed: () {},
                      alignment: Alignment.centerLeft,
                      icon: const Icon(
                        Icons.list,
                        size: 30,
                        color: Colors.black,
                      )),
                ) */
              ],
            )),
        (didShowList) ? Container() /*main body */ : const SizedBox.shrink(),
      ],
    );
  }
}
