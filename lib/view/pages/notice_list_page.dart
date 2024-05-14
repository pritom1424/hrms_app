import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../utils/app_colors/app_colors.dart';
import '../../utils/app_variables/app_vars.dart';
import '../../utils/app_variables/image_paths.dart';
import '../widgets/appbar_default_widget.dart';

class NoticeListPage extends StatelessWidget {
  final String? title;
  const NoticeListPage({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    Widget getListTile(String title, String subtitle) {
      return Container(
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
            boxShadow: [
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
        padding: EdgeInsets.all(5),
        child: ListTile(
          onTap: () => () {},
          leading: CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage(ImagePath.splashLogoPath),
          ),
          title: Text(
            title,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          subtitle: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /*  const Divider(
                thickness: 2.2,
                color: Colors.black12,
              ), */
              Text(
                subtitle,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ],
          ),
          titleTextStyle: Theme.of(context).textTheme.labelMedium,
          subtitleTextStyle: Theme.of(context).textTheme.bodySmall,
        ),
      );
    }

    return Scaffold(
        appBar: (title == null)
            ? null
            : AppbarDefault(
                appbarName: title,
              ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            children: List.generate(
                AppVars.noticeData.length,
                (index) => getListTile(
                    AppVars.noticeData[index].entries.toList()[0].value,
                    AppVars.noticeData[index].entries.toList()[1].value)),
          ),
        )

        /* 
      Container(
        child: Row(
          children: [
            ,
            Column(
              children: [Text("title"), Divider(), Text("content")],
            )
          ],
        ),
      ), */
        );
  }
}
