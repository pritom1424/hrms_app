import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hrms_app/utils/app_variables/app_vars.dart';
import 'package:hrms_app/view/pages/login_page.dart';

class SplashPage2 extends StatefulWidget {
  const SplashPage2({super.key});

  @override
  State<SplashPage2> createState() => _SplashPage2State();
}

class _SplashPage2State extends State<SplashPage2> {
  final _pageController = PageController(viewportFraction: 1, initialPage: 0);
  int activePage = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
        height: AppVars.screenSize.height + kToolbarHeight + 10,
        width: double.infinity,
        color: Color(0xFF242327),
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: AppVars.screenSize.height * 0.6,
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
                      // margin: EdgeInsets.symmetric(horizontal: 5),
                      padding:
                          EdgeInsets.only(left: 0, top: kToolbarHeight + 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        child: Image.asset(
                          images[pagePos],
                          fit: BoxFit.fill,
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
            Text(
              "Monitor Your Employee with Style",
              style: TextStyle(
                  fontSize: 35,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "A new way to monitor your employee through the application. anytime and anywhere!",
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Colors.white54,
                  fontWeight: FontWeight.normal,
                  fontSize: 18),
            ),
            SizedBox(
              height: 40,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (ctx) => LoginForm()));
              },
              child: Text("Get Started"),
              style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Color(0xFF4F14DE),
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0))),
            )
          ],
        ),
      ),
    );
  }
}
