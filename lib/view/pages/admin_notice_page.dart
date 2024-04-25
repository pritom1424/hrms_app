import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hrms_app/view/widgets/appbar_default_widget.dart';

class AdminNoticePage extends StatelessWidget {
  final String? title;
  const AdminNoticePage({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    List<String> noticeData = [
      "Sajjad Applied for Sim",
      "Md Bipul Applied for sick leave",
      "Md. Alamin applied for loan",
      "Md. Sadat applied for bonus"
    ];

    TextStyle titleTextStyle = const TextStyle(
        fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black);
    return Scaffold(
      appBar: (title != null)
          ? AppbarDefault(
              appbarName: title,
            )
          : null,
      body: SingleChildScrollView(
        child: Column(
          children: List.generate(
              noticeData.length,
              (index) => Container(
                    margin: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromARGB(66, 173, 163, 163),
                            /*  offset: Offset(
                  4.0,
                  4.0,
                ), */
                            blurRadius: 5,
                            spreadRadius: 1,
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 0.5, color: Colors.white)),
                    padding: const EdgeInsets.all(5),
                    child: ListTile(
                      onTap: () {},
                      leading: const Icon(CupertinoIcons.envelope_open),
                      title: Text(noticeData[index]),
                      titleTextStyle: titleTextStyle,
                    ),
                  )),
        ),
      ),
    );
  }
}
