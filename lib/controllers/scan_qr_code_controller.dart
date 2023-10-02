import 'dart:async';

import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_p2p_connection/flutter_p2p_connection.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wiqr/helpers/utils.dart';
import 'package:plugin_wifi_connect/plugin_wifi_connect.dart';
import 'package:wiqr/screens/home.dart';

class ScanQrCodeController extends GetxController {
  RxBool hasPermission = false.obs;
  RxBool requestingPermission = true.obs;
  RxBool scanned = false.obs;
  final _flutterP2pConnectionPlugin = FlutterP2pConnection();
  requestCameraPermission() async {
    PermissionStatus status = await Permission.camera.status;
    if (status == PermissionStatus.denied ||
        status == PermissionStatus.permanentlyDenied) {
      PermissionStatus requestStatus = await Permission.camera.request();
      if (requestStatus == PermissionStatus.denied ||
          requestStatus == PermissionStatus.permanentlyDenied) {
        hasPermission.value = false;

        requestingPermission.value = false;

        Utils.showErrorToast(
            "Camera permission is required in order to scan qr code");
      } else {
        hasPermission.value = true;
        requestingPermission.value = false;
      }
    } else {
      hasPermission.value = true;
      requestingPermission.value = false;
    }
  }

  connectToWifi(WiFi wifi) async {
    if (await _flutterP2pConnectionPlugin.checkWifiEnabled() == false) {
      _flutterP2pConnectionPlugin.enableWifiServices();
      return;
    } else {
      bool? connected = false;

      if (wifi.password == null) {
        connected = await PluginWifiConnect.connect(
          wifi.ssid!,
        );
      } else {
        EasyLoading.show();
        try {
          PluginWifiConnect.register();
          connected = await PluginWifiConnect.connectToSecureNetwork(
                  wifi.ssid!, wifi.password!,
                  saveNetwork: true)
              .timeout(Duration(seconds: 4))
              .then((v) {
            PluginWifiConnect.register();

            EasyLoading.dismiss();
            Get.offAll(() => Home());
            return v!;
          });
        } on TimeoutException catch (e) {
          EasyLoading.dismiss();
          Utils.showErrorToast("Failed to connect, invalid credentials");
        } catch (e) {
          EasyLoading.dismiss();
          Utils.showErrorToast("Failed to connect, invalid credentials");
        }
      }

      if (connected!) {
        Get.offAll(() => Home());
      }
    }
    // print(await _flutterP2pConnectionPlugin.enableWifiServices());
  }

  @override
  void onInit() {
    // TODO: implement onInit
    requestCameraPermission();
    super.onInit();
  }
}
