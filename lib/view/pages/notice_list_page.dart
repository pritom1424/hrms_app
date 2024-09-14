import 'package:flutter/material.dart';

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
                isShowNotification: false,
                isShowLeading: false,
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
        ));
  }
}
