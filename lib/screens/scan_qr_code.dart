import 'dart:typed_data';

import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:wiqr/controllers/create_qr_code_controller.dart';
import 'package:wiqr/controllers/scan_qr_code_controller.dart';
import 'package:wiqr/helpers/kColors.dart';
import 'package:wiqr/main.dart';
import 'package:wiqr/screens/qr_generated.dart';
import 'package:wiqr/widgets/my_text_field.dart';

class ScanQrCode extends StatefulWidget {
  ScanQrCode({super.key});

  @override
  State<ScanQrCode> createState() => _ScanQrCodeState();
}

class _ScanQrCodeState extends State<ScanQrCode> {
  ScanQrCodeController con = Get.put(ScanQrCodeController());
  String scannedSSID = "";
  MobileScannerController scannerController = MobileScannerController(
    detectionSpeed: DetectionSpeed.unrestricted,
    facing: CameraFacing.back,
    torchEnabled: false,
  );
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    con.dispose();
    scannerController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: GestureDetector(
        onTap: () {
          SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
        },
        child: Scaffold(
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
                "Scan QR Code",
                style: TextStyle(
                  color: KColor.greyColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 25.sp,
                ),
              ),
            ),
            centerTitle: true,
          ),
          body: GestureDetector(
            onTap: () {
              SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              margin: EdgeInsets.only(bottom: 35.h),
              child: Column(
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        // openWifiConnectModal(WiFi.fromNative(
                        //     {"ssid": "MrWick", "password": "newpas\$1290"}));
                        // onTap();
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
                          child: Container(
                            child: Obx(
                              () => con.requestingPermission.value
                                  ? SizedBox.shrink()
                                  : con.hasPermission.value
                                      ? Container(
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15)),
                                            child: MobileScanner(
                                              // fit: BoxFit.contain,
                                              controller: scannerController,
                                              onDetect: (capture) {
                                                if (capture
                                                        .barcodes.isNotEmpty &&
                                                    capture.barcodes[0]
                                                            .format ==
                                                        BarcodeFormat.qrCode) {
                                                  if (capture
                                                          .barcodes[0].wifi !=
                                                      null) {
                                                    if (!Get
                                                        .isBottomSheetOpen!) {
                                                      print("SSID" +
                                                          capture.barcodes[0]
                                                              .wifi!.ssid!);

                                                      scannedSSID = capture
                                                          .barcodes[0]
                                                          .wifi!
                                                          .ssid!;
                                                      con.scanned.value = true;
                                                      scannerController.stop();
                                                      openWifiConnectModal(
                                                          capture.barcodes[0]
                                                              .wifi!);
                                                    }
                                                  }
                                                }
                                              },
                                            ),

                                            //  Obx(
                                            //   () => con.scanned.value
                                            //       ? Container(
                                            //           color: Colors.black,
                                            //           alignment: Alignment.center,
                                            //         )
                                            //       : MobileScanner(
                                            //           // fit: BoxFit.contain,
                                            //           controller: scannerController,
                                            //           onDetect: (capture) {
                                            //             if (capture.barcodes
                                            //                     .isNotEmpty &&
                                            //                 capture.barcodes[0]
                                            //                         .format ==
                                            //                     BarcodeFormat
                                            //                         .qrCode) {
                                            //               if (capture.barcodes[0]
                                            //                       .wifi !=
                                            //                   null) {
                                            //                 if (!Get
                                            //                     .isBottomSheetOpen!) {
                                            //                   print("SSID" +
                                            //                       capture
                                            //                           .barcodes[0]
                                            //                           .wifi!
                                            //                           .ssid!);

                                            //                   scannedSSID = capture
                                            //                       .barcodes[0]
                                            //                       .wifi!
                                            //                       .ssid!;
                                            //                   con.scanned.value =
                                            //                       true;
                                            //                   openWifiConnectModal(
                                            //                       scannedSSID);
                                            //                 }
                                            //               }
                                            //             }
                                            //           },
                                            //         ),
                                            // ),
                                          ),
                                        )
                                      : GestureDetector(
                                          onTap: () {
                                            con.requestCameraPermission();
                                          },
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Please allow camera permission to scan QR Code",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: KColor.greyColor,
                                                  fontSize: 16.sp,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 20.h,
                                              ),
                                              Text(
                                                "Try Again",
                                                style: TextStyle(
                                                  color: KColor.primaryColor,
                                                  fontSize: 18.sp,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              )
                                            ],
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  openWifiConnectModal(WiFi wifi) {
    Get.bottomSheet(
      WillPopScope(
        onWillPop: () async {
          con.scanned.value = false;
          scannerController.start();
          return true;
        },
        child: SizedBox(
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(
                    height: 30.h,
                  ),
                  Text(
                    "Connect to Wi-Fi",
                    style: TextStyle(
                      color: KColor.greyColor,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Text(
                    wifi.ssid.toString(),
                    style: TextStyle(
                      color: KColor.greyColor,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Lottie.asset(
                    "assets/anim/wifi_anim.json",
                    height: 220.h,
                    width: 220.h,
                    frameRate: FrameRate(120),
                    repeat: false,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    // color: KColor.scaffoldColor,
                    // height: 150.h,
                    width: Get.width,
                    padding: EdgeInsets.only(
                      left: 25.sp,
                      right: 25.sp,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        con.connectToWifi(wifi);
                      },
                      child: Neumorphic(
                        style: NeumorphicStyle(
                          boxShape: NeumorphicBoxShape.roundRect(
                            BorderRadius.circular(15),
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
                            "Connect",
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
                  SizedBox(
                    height: 20.h,
                  )
                ],
              ),
              Positioned(
                right: 30.w,
                top: 30.h,
                child: GestureDetector(
                  onTap: () {
                    con.scanned.value = false;
                    scannerController.start();

                    Get.back();
                  },
                  child: Container(
                    height: 30.h,
                    width: 30.h,
                    child: Icon(
                      Icons.close,
                      color: KColor.greyColor,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      enableDrag: false,
      backgroundColor: Color(0xffEBEDF8),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25.0),
        ),
      ),
      isDismissible: false,
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
