import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wiqr/helpers/kColors.dart';

class MyRoundedButton extends StatelessWidget {
  VoidCallback onTap;
  String iconName;
  String subTitle;
  MyRoundedButton({
    super.key,
    required this.onTap,
    required this.iconName,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NeumorphicButton(
          onPressed: () {
            onTap();
          },
          padding: EdgeInsets.all(10.h),
          style: NeumorphicStyle(
            boxShape: NeumorphicBoxShape.circle(),
            intensity: 0.7,
            shadowLightColorEmboss: Colors.grey,
            depth: 7,
            color: KColor.primaryColor.withOpacity(0.01),
          ),
          child: Container(
            height: 47.h,
            width: 47.h,
            child: Padding(
              padding: EdgeInsets.all(10.h),
              child: Image.asset(
                "assets/images/${iconName}.png",
                color: KColor.primaryColor,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 15.h,
        ),
        Text(
          subTitle,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: KColor.greyMediumColor,
            fontWeight: FontWeight.w300,
            fontSize: 12.sp,
          ),
        ),
      ],
    );
  }
}
