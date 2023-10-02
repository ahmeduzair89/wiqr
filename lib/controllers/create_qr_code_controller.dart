import 'dart:io';
import 'dart:typed_data';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:saver_gallery/saver_gallery.dart';
import 'package:share_plus/share_plus.dart';
import 'package:wiqr/helpers/utils.dart';
import 'package:wiqr/main.dart';
import 'package:wiqr/models/qr_code_model.dart';
import 'package:wiqr/screens/qr_generated.dart';
import 'dart:ui' as ui; // Import the dart:ui library

enum SecurityTypes {
  WPA,
  WEP,
  NONE,
}

class CreateQrCodeController extends GetxController {
  Rx<SecurityTypes> selectedSecurityType = SecurityTypes.WPA.obs;
  TextEditingController ssidController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxString selectedColor = "#1E1E24".obs;
  GetStorage box = GetStorage();
  List myQrCodes = [];
  late QrCodeModel qr;
  List<String> colorList = [
    "#1E1E24",
    "#21A179",
    "#6247AA",
    "#79ADDC",
    "#104547",
    "#B92736",
    "#554640",
    "#3A405A",
    "#AA4465",
    "#6247AA",
    "#6247AA",
    "#104F55",
    "#E1DD8F",
  ];

  generateQr() {
    if (ssidController.text.isEmpty) {
      Utils.showErrorToast("Please enter Wi-Fi Name");
      return;
    }

    if (selectedSecurityType.value != SecurityTypes.NONE &&
        passwordController.text.isEmpty) {
      Utils.showErrorToast("Please enter Wi-Fi Password");
      return;
    }
    qr = QrCodeModel(
      codeData:
          "WIFI:T:${selectedSecurityType.value.name};S:${ssidController.text.trim()};P:${passwordController.text};;",
      createdOn: DateTime.now().millisecondsSinceEpoch,
      id: Utils.generateId(),
      ssid: ssidController.text,
      password: passwordController.text,
      encryption: selectedSecurityType.value.name,
    );
    Get.to(
      () => QrGenerated(),
      transition: Transition.fadeIn,
      curve: Curves.easeInOut,
      duration: Duration(milliseconds: 700),
    );
  }

  Future<Uint8List> captureWidget() async {
    await Future.delayed(
        Duration(milliseconds: 500)); // Wait for 500 milliseconds
    ui.Image image = await captureWidgetAsImage();
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);

    Uint8List pngBytes = byteData!.buffer.asUint8List();

    late bool statuses;
    if (Platform.isAndroid) {
      final deviceInfoPlugin = DeviceInfoPlugin();
      final deviceInfo = await deviceInfoPlugin.androidInfo;
      final sdkInt = deviceInfo.version.sdkInt;

      statuses =
          sdkInt < 29 ? await Permission.storage.request().isGranted : true;
    } else {
      statuses = await Permission.photosAddOnly.request().isGranted;
    }
    statuses = await (Platform.isAndroid
            ? Permission.storage
            : Permission.photosAddOnly)
        .request()
        .isGranted;
    final result = await SaverGallery.saveImage(
      pngBytes,
      quality: 100,
      name: "${Utils.generateId()}.png",
      androidRelativePath: "Pictures/WiQr",
      androidExistNotSave: false,
    );
    debugPrint(result.toString());

    Utils.showSuccessToast("QR Code Saved To Photos Successfully");
    return pngBytes;
  }

  Future<ui.Image> captureWidgetAsImage() async {
    RenderRepaintBoundary boundary =
        globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage(pixelRatio: 3.0);
    return image;
  }

  share() async {
    ui.Image image = await captureWidgetAsImage();
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);

    Uint8List pngBytes = byteData!.buffer.asUint8List();
    Share.shareXFiles(
        [XFile.fromData(pngBytes, mimeType: 'png', name: Utils.generateId())],
        text: 'Joing The Wifi Network Now By Scanning This QR Code');
  }

  shareSavedQrcode(Uint8List image) {
    Share.shareXFiles(
        [XFile.fromData(image, mimeType: 'png', name: Utils.generateId())],
        text: 'Joing The Wifi Network Now By Scanning This QR Code');
  }

  saveQr() async {
    try {
      var myQrCodesJson = box.read("MY_QR_CODES");

      if (myQrCodesJson == null) {
        box.write("MY_QR_CODES", []);
        myQrCodesJson = [];
      }

      bool alreadyContains = myQrCodesJson
          .where((element) => QrCodeModel.fromJson(element).id == qr.id)
          .toList()
          .isNotEmpty;
      if (alreadyContains) {
        getMyQrCodes();
        Utils.showSuccessToast("QR code saved already");

        return;
      }
      EasyLoading.show();
      await Future.delayed(
          Duration(milliseconds: 500)); // Wait for 500 milliseconds
      ui.Image image = await captureWidgetAsImage();
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);

      Uint8List pngBytes = byteData!.buffer.asUint8List();
      qr.qrImage = pngBytes;

      myQrCodesJson.add(qr.toJson());
      box.remove("MY_QR_CODES");
      box.write("MY_QR_CODES", myQrCodesJson);
      myQrCodes.add(qr);

      EasyLoading.dismiss();

      Utils.showSuccessToast("QR code saved successfully");
    } catch (e) {
      EasyLoading.dismiss();

      print(e.toString());
    }
  }

  getMyQrCodes() {
    final data = box.read("MY_QR_CODES");
    if (data != null) {
      myQrCodes.clear();
      for (int i = 0; i < data.length; i++) {
        myQrCodes.add(QrCodeModel.fromJson(data[i]));
      }
    }
  }

  @override
  void onInit() {
    getMyQrCodes();
    // TODO: implement onInit
    super.onInit();
  }
}
