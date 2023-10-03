import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wiqr/controllers/create_qr_code_controller.dart';
import 'package:wiqr/helpers/kColors.dart';
import 'package:wiqr/screens/qr_generated.dart';
import 'package:wiqr/widgets/my_text_field.dart';

class CreateQrCode extends StatelessWidget {
  CreateQrCode({super.key});

  CreateQrCodeController con = Get.find<CreateQrCodeController>();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    return GestureDetector(
      onTap: () {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
      },
      child: Scaffold(
        backgroundColor: KColor.scaffoldColor,
        bottomSheet: Container(
          color: KColor.scaffoldColor,
          height: 120.h,
          width: Get.width,
          padding: EdgeInsets.all(
            25.sp,
          ),
          child: GestureDetector(
            onTap: () {
              // Get.to(QrGenerated());
              con.generateQr();
            },
            child: Neumorphic(
              style: NeumorphicStyle(
                boxShape: NeumorphicBoxShape.roundRect(
                  BorderRadius.circular(20),
                ),
                intensity: 1,
                shadowLightColorEmboss: Colors.grey,
                depth: 7,
                color: KColor.primaryColor.withOpacity(0.7),
              ),
              padding: EdgeInsets.all(
                12.h,
              ),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "Generate",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Container(
              color: KColor.scaffoldColor,
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
              "Create Wi-Fi QR Code",
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
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 20.h,
                ),
                MyTextField(
                  hint: "Enter Wi-Fi name",
                  title: "Wi-Fi Name",
                  controller: con.ssidController,
                ),
                Obx(
                  () => con.selectedSecurityType.value == SecurityTypes.NONE
                      ? Container()
                      : Column(
                          children: [
                            SizedBox(height: 30.h),
                            MyTextField(
                              hint: "Enter Wi-Fi Password",
                              title: "Wi-Fi Password",
                              controller: con.passwordController,
                            ),
                          ],
                        ),
                ),
                SizedBox(
                  height: 50.h,
                ),
                GestureDetector(
                  onTap: () {
                    con.showInfo.value = !con.showInfo.value;
                  },
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Text(
                          "Security Type",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: KColor.greyColor,
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Icon(
                          Icons.info_outline,
                          color: KColor.greyColor,
                          size: 18.sp,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Obx(
                      () => Expanded(
                        flex: 1,
                        child: NeumorphicRadio(
                          onChanged: (v) {
                            con.selectedSecurityType.value = v!;
                          },
                          value: SecurityTypes.WPA,
                          groupValue: con.selectedSecurityType.value,
                          padding: EdgeInsets.all(10.h),
                          style: NeumorphicRadioStyle(
                            intensity: 0.6,
                            boxShape: NeumorphicBoxShape.roundRect(
                              BorderRadius.circular(15),
                            ),
                            selectedDepth: -7,
                            unselectedDepth: 7,
                            selectedColor:
                                KColor.primaryColor.withOpacity(0.01),
                            unselectedColor:
                                KColor.primaryColor.withOpacity(0.01),
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "WPA/WPA2",
                              style: TextStyle(
                                fontSize: 15.sp,
                                color: KColor.greyColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15.w,
                    ),
                    Obx(
                      () => Expanded(
                        flex: 1,
                        child: NeumorphicRadio(
                          onChanged: (v) {
                            con.selectedSecurityType.value = v!;
                          },
                          value: SecurityTypes.WEP,
                          groupValue: con.selectedSecurityType.value,
                          padding: EdgeInsets.all(10.h),
                          style: NeumorphicRadioStyle(
                            intensity: 0.6,
                            boxShape: NeumorphicBoxShape.roundRect(
                              BorderRadius.circular(15),
                            ),
                            selectedDepth: -7,
                            unselectedDepth: 7,
                            selectedColor:
                                KColor.primaryColor.withOpacity(0.01),
                            unselectedColor:
                                KColor.primaryColor.withOpacity(0.01),
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "WEP",
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w500,
                                color: KColor.greyColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15.w,
                    ),
                    Obx(
                      () => Expanded(
                        flex: 1,
                        child: NeumorphicRadio(
                          onChanged: (v) {
                            con.selectedSecurityType.value = v!;
                          },
                          value: SecurityTypes.NONE,
                          groupValue: con.selectedSecurityType.value,
                          padding: EdgeInsets.all(10.h),
                          style: NeumorphicRadioStyle(
                            intensity: 0.6,
                            boxShape: NeumorphicBoxShape.roundRect(
                              BorderRadius.circular(15),
                            ),
                            selectedDepth: -7,
                            unselectedDepth: 7,
                            selectedColor:
                                KColor.primaryColor.withOpacity(0.01),
                            unselectedColor:
                                KColor.primaryColor.withOpacity(0.01),
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "None",
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w500,
                                color: KColor.greyColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20..h,
                ),
                Obx(
                  () => con.showInfo.value
                      ? Column(
                          children: [
                            Text(
                              "WPA/WPA2: Modern and secure encryption; common in most networks.",
                              style: TextStyle(
                                color: KColor.greyMediumColor,
                                fontWeight: FontWeight.w300,
                                fontSize: 12.sp,
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Text(
                              "WEP: Older and less secure; use only if necessary for legacy devices.",
                              style: TextStyle(
                                color: KColor.greyMediumColor,
                                fontWeight: FontWeight.w300,
                                fontSize: 12.sp,
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Text(
                              "None: No password; avoid for private networks due to security risks.",
                              style: TextStyle(
                                color: KColor.greyMediumColor,
                                fontWeight: FontWeight.w300,
                                fontSize: 12.sp,
                              ),
                            ),
                          ],
                        )
                      : Container(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

  // style: NeumorphicStyle(
  //         boxShape: NeumorphicBoxShape.roundRect(
  //           BorderRadius.circular(20),
  //         ),
  //         intensity: 0.6,
  //         shadowLightColorEmboss: Colors.white,
  //         // shadowLightColorEmboss: Colors.grey,
  //         depth: -7,
  //         color: KColor.primaryColor.withOpacity(0.01),
  //       ),
