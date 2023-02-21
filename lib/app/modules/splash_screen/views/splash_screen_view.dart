import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';

import '../controllers/splash_screen_controller.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  const SplashScreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
              backgroundColor: HexColor("#0B0C2B"),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Image.asset(
                      "assets/images/logo atan 2.png",
                      height: 45.h,
                      width: 45.w,
                    ),
                  ),
                ],
              )),
        ),
        value: SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.light,
            statusBarColor: Colors.transparent));
  }
}
