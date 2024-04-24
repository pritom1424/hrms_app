import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hrms_app/utils/app_variables/image_paths.dart';
import 'package:hrms_app/view/widgets/appbar_default_widget.dart';

class NoticeListPage extends StatelessWidget {
  final String? title;
  const NoticeListPage({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: (title == null)
            ? null
            : AppbarDefault(
                appbarName: title,
              ),
        body: ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage(ImagePath.splashLogoPath),
          ),
          title: Text(
            "Scheduled meeting with Managing Director Sir regarding website",
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          subtitle: Text(
            "Access to the office premises will now require the use of security badges. All employees must ensure they have their badges with them at all times.",
            overflow: TextOverflow.ellipsis,
            maxLines: 3,
          ),
          titleTextStyle: Theme.of(context).textTheme.headlineLarge,
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
