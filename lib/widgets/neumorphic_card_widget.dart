import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wiqr/helpers/kColors.dart';

class NeumorphicCardWidget extends StatelessWidget {
  VoidCallback onTap;
  String iconName;
  String title;
  NeumorphicCardWidget({
    super.key,
    required this.onTap,
    required this.iconName,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: () {
          onTap();
        },
        child: Container(
          width: Get.width,
          child: Neumorphic(
            style: NeumorphicStyle(
              boxShape: NeumorphicBoxShape.roundRect(
                BorderRadius.circular(20),
              ),
              intensity: 0.7,
              shadowLightColorEmboss: Colors.grey,
              depth: 7,
              color: KColor.primaryColor.withOpacity(0.01),
            ),
            padding: EdgeInsets.all(
              20,
            ),
            child: Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 50.h,
                    width: 50.h,
                    child: Image.asset(
                      'assets/images/${iconName}.png',
                      height: 40.h,
                      fit: BoxFit.cover,
                      color: KColor.primaryColor.withOpacity(0.5),
                    ),
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: KColor.primaryColor.withOpacity(0.6),
                      fontWeight: FontWeight.bold,
                      fontSize: 20.sp,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
