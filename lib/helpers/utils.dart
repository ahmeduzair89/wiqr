import 'package:cuid2/cuid2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:motion_toast/motion_toast.dart';

class Utils {
  static generateId() {
    final cc = cuidConfig(length: 30);
    return cc.gen();
  }

  static showSuccessToast(String message) {
    MotionToast.success(
      width: Get.width * 0.9,
      height: 100.h,
      title: Text(
        "Success",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      description: Text(
        message,
      ),
      padding: EdgeInsets.all(20),
    ).show(Get.context!);
  }

  static showErrorToast(String message) {
    MotionToast.error(
      width: Get.width * 0.9,
      height: 100.h,
      title: Text(
        "Error",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      description: Text(
        message,
      ),
      padding: EdgeInsets.all(20),
    ).show(Get.context!);
  }
}
