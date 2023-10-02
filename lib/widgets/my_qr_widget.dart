import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:wiqr/helpers/kColors.dart';
import 'package:wiqr/models/qr_code_model.dart';

class MyQrCodeWidget extends StatelessWidget {
  QrCodeModel model;
  VoidCallback callback;
  MyQrCodeWidget({
    super.key,
    required this.model,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170.h,
      padding: EdgeInsets.symmetric(vertical: 15.h),
      child: GestureDetector(
        onTap: () {},
        child: Stack(
          children: [
            Container(
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
                child: Row(children: [
                  PrettyQrView.data(
                    data: model.codeData!,
                    decoration: PrettyQrDecoration(
                      shape: PrettyQrSmoothSymbol(
                        roundFactor: 0.6,
                        // color: HexColor(con.selectedColor.value),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Container(
                    width: Get.width * 0.43,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${model.ssid}",
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: KColor.greyColor,
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Encription: ${model.encryption}",
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: KColor.greyColor,
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Text(
                              "Password: ${model.password}",
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: KColor.greyColor,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ]),
              ),
            ),
            Positioned(
              right: 20.w,
              top: 20.h,
              child: GestureDetector(
                onTap: () {
                  callback();
                },
                child: Container(
                  height: 20.h,
                  width: 20.h,
                  child: Image.asset(
                    "assets/images/share.png",
                    color: KColor.primaryColor,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
