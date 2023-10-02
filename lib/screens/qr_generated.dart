import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:wiqr/controllers/create_qr_code_controller.dart';
import 'package:wiqr/helpers/kColors.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:wiqr/main.dart';
import 'package:wiqr/models/qr_code_model.dart';
import 'package:wiqr/screens/home.dart';
import 'package:wiqr/widgets/color_selector_widget.dart';
import 'package:wiqr/widgets/my_rounded_button.dart';

class QrGenerated extends StatelessWidget {
  QrGenerated({super.key});

  CreateQrCodeController con = Get.find<CreateQrCodeController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KColor.scaffoldColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Container(
            margin: EdgeInsets.only(top: 15.h, left: 30.w),
            child: Icon(
              Icons.arrow_back_ios,
              color: KColor.greyColor,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Container(
          margin: EdgeInsets.only(top: 15.h),
          child: Text(
            "QR Code",
            style: TextStyle(
              color: KColor.greyColor,
              fontWeight: FontWeight.bold,
              fontSize: 25.sp,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 25.w),
        child: Column(
          children: [
            SizedBox(
              height: 40.h,
            ),
            RepaintBoundary(
              key: globalKey,
              child: Container(
                width: Get.width,
                height: Get.width * 0.8,
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
                    child: Obx(
                      () => PrettyQrView.data(
                        data: con.qr.codeData!,
                        decoration: PrettyQrDecoration(
                          shape: PrettyQrSmoothSymbol(
                            roundFactor: 0.6,
                            color: HexColor(con.selectedColor.value),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50.h,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Color",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: KColor.greyColor,
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Container(
              width: Get.width,
              height: 60.h,
              child: ListView.builder(
                clipBehavior: Clip.none,
                itemCount: con.colorList.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Obx(
                    () => ColorSelectorWidget(
                      value: con.colorList[index],
                      groupValue: con.selectedColor.value,
                      onSelect: (v) {
                        con.selectedColor.value = con.colorList[index];
                        con.qr.color = con.colorList[index];
                        print(con.qr.codeData);
                      },
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 50.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyRoundedButton(
                    onTap: () {
                      con.saveQr();
                      // Get.back();
                    },
                    iconName: 'open-folder'),
                MyRoundedButton(
                    onTap: () {
                      Get.offAll(() => Home());
                    },
                    iconName: 'home'),
                MyRoundedButton(
                    onTap: () {
                      con.captureWidget();
                    },
                    iconName: 'download-file'),
                MyRoundedButton(
                    onTap: () {
                      con.share();
                    },
                    iconName: 'share'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
