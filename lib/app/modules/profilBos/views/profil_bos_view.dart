import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../controller/auth_controller.dart';
import '../controllers/profil_bos_controller.dart';

class ProfilBosView extends GetView<ProfilBosController> {
  const ProfilBosView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final authC = Get.put(AuthController());
    return AnnotatedRegion(
        value: SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark,
            statusBarColor: Colors.transparent),
        child: Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 6,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                textDirection: TextDirection.ltr,
                children: [
                  SizedBox(height: 8.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Halo Bos",
                            style: TextStyle(
                              fontSize: 19,
                              color: HexColor("#0B0C2B"),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 1.h),
                          Text(
                            "Halaman Profil Anda",
                            style: TextStyle(
                              fontSize: 19,
                              color: HexColor("#0B0C2B"),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                          padding: const EdgeInsets.only(right: 0),
                          child: IconButton(
                              onPressed: () {
                                authC.logout();
                              },
                              icon: Icon(
                                PhosphorIcons.signOut,
                                color: HexColor("#D90000"),
                              ))),
                    ],
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: ClipOval(
                          child: Container(
                            child: Image.asset(
                              "assets/images/cool2.png",
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Text(
                        "Bosque",
                        style: TextStyle(
                          fontSize: 30,
                          color: HexColor("#0B0C2B"),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Text(
                        "Pemilik Usaha",
                        style: TextStyle(
                          fontSize: 18,
                          color: HexColor("#0B0C2B"),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 0.5.h,
                      ),
                      Text(
                        "lulusyuk@emailku.com",
                        style: TextStyle(
                          fontSize: 15,
                          color: HexColor("#0B0C2B"),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 2.5.h,
                      ),
                      SizedBox(
                        width: 40.w,
                        height: 4.h,
                        child: InkWell(
                          onTap: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Text(
                                  "Edit Profil",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: HexColor("#0B0C2B"),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 6, right: 5),
                                child: Icon(
                                  PhosphorIcons.pencilSimple,
                                  size: 20,
                                  color: HexColor("#0B0C2B"),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )));
  }
}
