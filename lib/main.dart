import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:wiqr/screens/create_qr_code.dart';
import 'package:wiqr/screens/home.dart';
import 'package:wiqr/helpers/kColors.dart';
import 'package:wiqr/screens/qr_generated.dart';
import 'package:wiqr/screens/splash.dart';

GlobalKey globalKey = GlobalKey();

void main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: "WiQR",
          home: child,
          builder: EasyLoading.init(),
        );
      },
      child: Splash(),
    );
  }

  void configLoading() {
    EasyLoading.instance
      ..loadingStyle = EasyLoadingStyle.light
      ..radius = 25
      ..indicatorSize = 100
      ..contentPadding = EdgeInsets.zero
      ..indicatorWidget = Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          boxShadow: [],
          borderRadius: BorderRadius.all(
            Radius.circular(25),
          ),
          color: Colors.white,
        ),
        alignment: Alignment.center,
        child: Container(
          child: CircularProgressIndicator(
            color: KColor.primaryColor,
          ),
        ),
      )
      ..indicatorColor = KColor.primaryColor.withOpacity(0.3)
      ..maskType = EasyLoadingMaskType.custom
      ..maskColor = KColor.primaryColor.withOpacity(0.3);
  }
}
