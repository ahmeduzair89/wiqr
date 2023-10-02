import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wiqr/helpers/kColors.dart';

class MyTextField extends StatelessWidget {
  String title;
  String hint;
  TextEditingController controller;

  MyTextField({
    super.key,
    required this.hint,
    required this.title,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // alignment: Alignment.center,

      width: Get.width,
      child: Neumorphic(
        style: NeumorphicStyle(
          boxShape: NeumorphicBoxShape.roundRect(
            BorderRadius.circular(20),
          ),
          intensity: 0.6,
          shadowLightColorEmboss: Colors.white,
          // shadowLightColorEmboss: Colors.grey,
          depth: -7,
          color: KColor.primaryColor.withOpacity(0.01),
        ),
        padding: EdgeInsets.all(
          20,
        ),
        child: Align(
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: KColor.greyColor,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              TextField(
                controller: controller,
                decoration: InputDecoration.collapsed(
                  hintText: hint,
                  hintStyle: TextStyle(
                    color: KColor.greyColor.withOpacity(0.6),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
