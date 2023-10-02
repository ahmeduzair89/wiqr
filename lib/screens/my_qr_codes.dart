import 'dart:typed_data';

import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lottie/lottie.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:wiqr/controllers/create_qr_code_controller.dart';
import 'package:wiqr/controllers/scan_qr_code_controller.dart';
import 'package:wiqr/helpers/kColors.dart';
import 'package:wiqr/main.dart';
import 'package:wiqr/screens/qr_generated.dart';
import 'package:wiqr/widgets/my_qr_widget.dart';
import 'package:wiqr/widgets/my_text_field.dart';

class MyQrCode extends StatefulWidget {
  MyQrCode({super.key});

  @override
  State<MyQrCode> createState() => _MyQrCodeState();
}

class _MyQrCodeState extends State<MyQrCode> {
  CreateQrCodeController con = Get.find<CreateQrCodeController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    con.passwordController.clear();
    con.ssidController.clear();
    con.selectedSecurityType.value = SecurityTypes.WPA;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
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
              "My QR Codes",
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
                height: 20.h,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: con.myQrCodes.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return MyQrCodeWidget(
                      callback: () {
                        con.shareSavedQrcode(con.myQrCodes[index].qrImage);
                      },
                      model: con.myQrCodes[index],
                    );
                  },
                ),
              ),
              SizedBox(
                height: 50.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
