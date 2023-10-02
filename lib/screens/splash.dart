import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wiqr/helpers/kColors.dart';
import 'package:wiqr/screens/home.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  double logoOpacity = 0.0;
  double taglineOpacity = 0.0;

  @override
  void initState() {
    super.initState();
    Future.delayed(
        Duration(
          seconds: 3,
        ), () {
      Get.offAll(() => Home());
    });

    Future.delayed(Duration(milliseconds: 0), () {
      setState(() {
        logoOpacity = 1.0;
      });
    });

    // Add a delay before fading in the tagline
    Future.delayed(Duration(milliseconds: 1500), () {
      setState(() {
        taglineOpacity = 1.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KColor.scaffoldColor,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedOpacity(
              opacity: logoOpacity,
              duration: Duration(milliseconds: 1500),
              child: Container(
                width: 250.w,
                height: 250.w,
                child: Image.asset(
                  "assets/images/wiqr_logo.png",
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(height: 20),
            AnimatedOpacity(
              opacity: taglineOpacity,
              duration: Duration(milliseconds: 2000),
              child: Text(
                "Create. Scan. Connect!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
