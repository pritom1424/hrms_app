import 'package:flutter/material.dart';

import 'package:hrms_app/controller/hrms_auth_controller.dart';
import 'package:hrms_app/view/pages/root_nav_page.dart';
import 'package:provider/provider.dart';
import '../../utils/app_colors/app_colors.dart';

import 'login_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final _pageController = PageController(viewportFraction: 1, initialPage: 0);
  int activePage = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size scSize = MediaQuery.of(context).size;
    List<String> images = [
      "assets/images/splash_carousel_1.jpg",
      "assets/images/splash_carousel_2.jpg",
      "assets/images/splash_carousel_3.jpg"
    ];
    List<Widget> indicators(imagesLength, currentIndex) {
      return List<Widget>.generate(imagesLength, (index) {
        return Container(
          margin: EdgeInsets.all(3),
          width: 10,
          height: 10,
          decoration: BoxDecoration(
              color: (currentIndex == index) ? Colors.white : Colors.white24,
              shape: BoxShape.circle),
        );
      });
    }

    return Scaffold(
      body: Container(
        height: scSize.height,
        width: double.infinity,
        color: Color(0xFF242327),
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: scSize.height * 0.6,
              width: double.infinity,
              child: PageView.builder(
                  controller: _pageController,
                  itemCount: images.length,
                  onPageChanged: (page) {
                    setState(() {
                      activePage = page;
                    });
                  },
                  padEnds: false,
                  itemBuilder: (context, pagePos) {
                    return Container(
                      padding:
                          EdgeInsets.only(left: 0, top: kToolbarHeight + 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        child: Image.asset(
                          images[pagePos],
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  }),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: indicators(images.length, activePage)),
            ),
            const Text(
              "Monitor Your Employee with Style",
              style: TextStyle(
                  fontSize: 35,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            const Text(
              "A new way to monitor your employee through the application. anytime and anywhere!",
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Colors.white54,
                  fontWeight: FontWeight.normal,
                  fontSize: 18),
            ),
            const SizedBox(
              height: 40,
            ),
            ElevatedButton(
              onPressed: () async {
                final didLogin = await Provider.of<HrmsAuthController>(context,
                        listen: false)
                    .tryAutoLogin();
                if (!didLogin) {
                  if (context.mounted) {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (ctx) => LoginForm()));
                  }
                } else {
                  if (context.mounted) {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (ctx) => RootNavPage()));
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor:
                      Appcolors.assignButtonColor, //Color(0xFF4F14DE),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0))),
              child: const Text("Get Started"),
            )
          ],
        ),
      ),
    );
  }
}
