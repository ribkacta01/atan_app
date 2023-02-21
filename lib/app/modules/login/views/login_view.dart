import 'package:atan_app/app/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:icons_plus/icons_plus.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final authC = Get.put(AuthController());
    final bodyHeight = MediaQuery.of(context).size.height;
    final bodyWidth = MediaQuery.of(context).size.width;
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
                    height: bodyHeight * 0.2,
                    width: bodyWidth * 0.56,
                  ),
                ),
                SizedBox(
                  height: bodyHeight * 0.04,
                ),
                Text(
                  "Selamat Datang Tim Atan!",
                  style: TextStyle(fontSize: 28, color: Colors.white),
                ),
                SizedBox(height: bodyHeight * 0.02),
                Text(
                  "Silakan Login Untuk Memulai",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                SizedBox(
                  height: bodyHeight * 0.037,
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.only(left: 110, right: 110),
                    child: ConstrainedBox(
                      constraints:
                          BoxConstraints.tightFor(width: context.width),
                      child: ElevatedButton.icon(
                        label: Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Text(
                            "Sign In With Google",
                            style: TextStyle(
                                color: HexColor("#0B0C2B"),
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        icon: Padding(
                            padding: const EdgeInsets.only(right: 10.0),
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
