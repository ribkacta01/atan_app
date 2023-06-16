import 'package:atan_app/app/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:sizer/sizer.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final authC = Get.put(AuthController());

    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
          statusBarColor: Colors.transparent),
      child: Scaffold(
          backgroundColor: HexColor("#0B0C2B"),
          body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Image.asset(
                    "assets/images/logo_atan.png",
                    height: 25.h,
                    width: 35.w,
                  ),
                ),
                Text(
                  "Selamat Datang Tim Atan!",
                  style: TextStyle(fontSize: 18.sp, color: Colors.white),
                ),
                SizedBox(height: 2.h),
                Text(
                  "Silakan Login Untuk Memulai",
                  style: TextStyle(fontSize: 13.sp, color: Colors.white),
                ),
                SizedBox(
                  height: 2.5.h,
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.only(left: 26.w, right: 26.w),
                    child: ConstrainedBox(
                      constraints:
                          BoxConstraints.tightFor(width: context.width),
                      child: ElevatedButton.icon(
                        label: Padding(
                          padding: EdgeInsets.only(
                            right: 2.w,
                          ),
                          child: Text(
                            "Sign In With Google",
                            style: TextStyle(
                                color: HexColor("#0B0C2B"),
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        icon: Padding(
                            padding: EdgeInsets.only(left: 2.w, right: 2.w),
                            child: Logo(
                              Logos.google,
                              size: 20,
                            )),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: HexColor("#FFFFFF"),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            padding: EdgeInsets.only(top: 10, bottom: 10)),
                        onPressed: () => authC.signInGoogle(),
                      ),
                    ),
                  ),
                ),
              ])),
    );
  }
}
