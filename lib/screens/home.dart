import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wiqr/controllers/create_qr_code_controller.dart';
import 'package:wiqr/helpers/kColors.dart';
import 'package:wiqr/screens/create_qr_code.dart';
import 'package:wiqr/screens/my_qr_codes.dart';
import 'package:wiqr/screens/scan_qr_code.dart';
import 'package:wiqr/widgets/neumorphic_card_widget.dart';

class Home extends StatelessWidget {
  Home({super.key});

  CreateQrCodeController con = Get.put(CreateQrCodeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KColor.scaffoldColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Container(
          margin: EdgeInsets.only(top: 35.h),
          child: Image.asset(
            "assets/images/wiqr_logo_text_only.png",
            scale: 3,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 50.w),
        child: Column(
          children: [
            SizedBox(
              height: 40.h,
            ),
            NeumorphicCardWidget(
              onTap: () {
                Get.to(() => ScanQrCode(),
                    transition: Transition.fadeIn,
                    curve: Curves.easeInOut,
                    duration: Duration(milliseconds: 700));
              },
              title: "Scan Wi-Fi\nQR Code",
              iconName: "qr-scan",
            ),
            SizedBox(
              height: 50.h,
            ),
            NeumorphicCardWidget(
              onTap: () {
                Get.to(() => CreateQrCode(),
                    transition: Transition.fadeIn,
                    curve: Curves.easeInOut,
                    duration: Duration(milliseconds: 700));
              },
              title: "Create Wi-Fi\nQR Code",
              iconName: "barcode-scanner",
            ),
            SizedBox(
              height: 50.h,
            ),
            NeumorphicCardWidget(
              onTap: () {
                Get.to(() => MyQrCode(),
                    transition: Transition.fadeIn,
                    curve: Curves.easeInOut,
                    duration: Duration(milliseconds: 700));
              },
              title: "My QR Codes",
              iconName: "folder",
            ),
            SizedBox(
              height: 50.h,
            ),
          ],
        ),
      ),
    );
  }
}
