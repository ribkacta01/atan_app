import 'dart:developer';

import 'package:atan_app/app/controller/auth_controller.dart';
import 'package:atan_app/app/controller/fcm_controller.dart';
import 'package:atan_app/app/modules/beranda/views/beranda_view.dart';
import 'package:atan_app/app/modules/berandaBos/views/beranda_bos_view.dart';
import 'package:atan_app/app/modules/keranjang/views/keranjang_view.dart';
import 'package:atan_app/app/modules/olah_data_pegawai/views/olah_data_pegawai_view.dart';
import 'package:atan_app/app/modules/profil/views/profil_view.dart';
import 'package:atan_app/app/modules/profilBos/views/profil_bos_view.dart';
import 'package:atan_app/app/util/Loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lottie/lottie.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../routes/app_pages.dart';
import '../../../util/color.dart';
import '../../../util/string.dart';
import '../../keranjangBos/views/keranjang_bos_view.dart';
import '../../tugas/views/tugas_view.dart';
import '../../tugasBos/views/tugas_bos_view.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final authC = Get.put(AuthController());
    final fcmC = Get.put(FCMController());

    var pages = <Widget>[
      BerandaView(),
      KeranjangView(),
      TugasView(),
      ProfilView(),
    ];

    var pages2 = <Widget>[
      BerandaBosView(),
      KeranjangBosView(),
      TugasBosView(),
      OlahDataPegawaiView(),
      ProfilBosView()
    ];

    return FutureBuilder(
        future: Future.delayed(Duration(seconds: 2)),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Loading();
          }
          return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              stream: authC.getUserRoles(),
              builder: (context, snap) {
                if (snap.connectionState == ConnectionState.waiting) {
                  return const Loading();
                }
                if (snap.hasData) {
                  var roles = snap.data!.get("roles");
                  var email = snap.data!.get("email");

                  log("$roles");
                  if (snap.data!.exists == false) {
                    return Scaffold(
                      backgroundColor: blue1,
                      body: Center(
                        child: Dialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            backgroundColor: grey1,
                            child: SizedBox(
                              width: 350,
                              height: 365,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Lottie.asset('assets/animation/failed.json',
                                      height: 140),
                                  SizedBox(
                                    height: 3.h,
                                  ),
                                  Text(
                                    'LOGIN GAGAL',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: bluePrimary,
                                        fontSize: 25,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  Text(
                                    'Akun tidak ada!',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: bluePrimary,
                                      fontSize: 25,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  Text(
                                    'Hubungi Pemilik Usaha Untuk Aktivasi Akun',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: bluePrimary,
                                      fontSize: 15,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 3.h,
                                  ),
                                  Container(
                                      width: 15.w,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(11),
                                          color: grey1),
                                      child: TextButton(
                                          onPressed: () {
                                            Get.back();
                                            Get.back();
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 11.0, bottom: 11.0),
                                            child: Text(
                                              'OK',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: bluePrimary),
                                            ),
                                          )))
                                ],
                              ),
                            )),
                      ),
                    );
                  }
                  if (authC.auth.currentUser!.email == email) {
                    if (roles != "pemilik_usaha") {
                      if (fcmC.notificationData != null) {
                        // route btm nav khusus notif onclick user
                        return Scaffold(
                          body:
                              Obx(() => pages[controller.currentIndex2.value]),
                          bottomNavigationBar: Container(
                            decoration:
                                BoxDecoration(color: Colors.white, boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(1),
                                  blurRadius: 7,
                                  offset: Offset(0, 4))
                            ]),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                navBarItem2(
                                    context, PhosphorIcons.houseBold, 0),
                                navBarItem2(context,
                                    PhosphorIcons.shoppingCartSimpleBold, 1),
                                navBarItem2(
                                    context, PhosphorIcons.notePencilBold, 2),
                                navBarItem2(context, PhosphorIcons.userBold, 3),
                              ],
                            ),
                          ),
                        );
                      } else {
                        // route normal
                        return Scaffold(
                          body: Obx(() => pages[controller.currentIndex.value]),
                          bottomNavigationBar: Container(
                            decoration:
                                BoxDecoration(color: Colors.white, boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(1),
                                  blurRadius: 7,
                                  offset: Offset(0, 4))
                            ]),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                navBarItem(context, PhosphorIcons.houseBold, 0),
                                navBarItem(context,
                                    PhosphorIcons.shoppingCartSimpleBold, 1),
                                navBarItem(
                                    context, PhosphorIcons.notePencilBold, 2),
                                navBarItem(context, PhosphorIcons.userBold, 3),
                              ],
                            ),
                          ),
                        );
                      }
                    } else {
                      if (fcmC.notificationData != null) {
                        // routes khusus ketika notif tidak null
                        return Scaffold(
                          body:
                              Obx(() => pages2[controller.currentIndex2.value]),
                          bottomNavigationBar: Container(
                            decoration:
                                BoxDecoration(color: Colors.white, boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(1),
                                  blurRadius: 7,
                                  offset: Offset(0, 4))
                            ]),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                navBarItem2(
                                    context, PhosphorIcons.houseBold, 0),
                                navBarItem2(context,
                                    PhosphorIcons.shoppingCartSimpleBold, 1),
                                navBarItem2(
                                    context, PhosphorIcons.notePencilBold, 2),
                                navBarItem2(
                                    context, PhosphorIcons.usersThreeBold, 3),
                                navBarItem2(context, PhosphorIcons.userBold, 4),
                              ],
                            ),
                          ),
                        );
                      } else {
                        // routes normal
                        return Scaffold(
                          body:
                              Obx(() => pages2[controller.currentIndex.value]),
                          bottomNavigationBar: Container(
                            decoration:
                                BoxDecoration(color: Colors.white, boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(1),
                                  blurRadius: 7,
                                  offset: Offset(0, 4))
                            ]),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                navBarItem(context, PhosphorIcons.houseBold, 0),
                                navBarItem(context,
                                    PhosphorIcons.shoppingCartSimpleBold, 1),
                                navBarItem(
                                    context, PhosphorIcons.notePencilBold, 2),
                                navBarItem(
                                    context, PhosphorIcons.usersThreeBold, 3),
                                navBarItem(context, PhosphorIcons.userBold, 4),
                              ],
                            ),
                          ),
                        );
                      }
                    }
                  } else {
                    return Scaffold(
                      backgroundColor: blue1,
                      body: Center(
                        child: Dialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            backgroundColor: grey1,
                            child: SizedBox(
                              width: 350,
                              height: 365,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Lottie.asset('assets/animation/failed.json',
                                      height: 140),
                                  SizedBox(
                                    height: 3.h,
                                  ),
                                  Text(
                                    'LOGIN GAGAL',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: bluePrimary,
                                        fontSize: 25,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  Text(
                                    'Periksa Kembali Akun Anda!',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: bluePrimary,
                                      fontSize: 25,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  Text(
                                    'Hubungi Pemilik Usaha Untuk Aktivasi Akun',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: bluePrimary,
                                      fontSize: 15,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 3.h,
                                  ),
                                  Container(
                                      width: 15.w,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(11),
                                          color: grey1),
                                      child: TextButton(
                                          onPressed: () {
                                            Get.back();
                                            Get.back();
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 11.0, bottom: 11.0),
                                            child: Text(
                                              'OK',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: bluePrimary),
                                            ),
                                          )))
                                ],
                              ),
                            )),
                      ),
                    );
                  }
                } else {
                  return Loading();
                }
              });
        });
  }

  Widget navBarItem(BuildContext context, IconData icon, int index) {
    return GestureDetector(
        onTap: () {
          controller.changePage(index);
        },
        child: SizedBox(
          height: 75,
          child: Obx(
            () => Padding(
              padding: const EdgeInsets.all(11.0),
              child: Container(
                width: 55,
                decoration: (index == controller.currentIndex.value)
                    ? BoxDecoration(
                        color: HexColor("#0B0C2B"),
                        borderRadius: BorderRadius.circular(24))
                    : BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        border:
                            Border.all(color: HexColor("#0B0C2B"), width: 2)),
                child: Icon(
                  icon,
                  color: (index == controller.currentIndex.value ||
                          Get.currentRoute == Routes.BERANDA)
                      ? Colors.white
                      : HexColor("#0B0C2B"),
                ),
              ),
            ),
          ),
        ));
  }

  Widget navBarItem2(BuildContext context, IconData icon, int index) {
    return GestureDetector(
        onTap: () {
          controller.changePage2(index);
        },
        child: SizedBox(
          height: 75,
          child: Obx(
            () => Padding(
              padding: const EdgeInsets.all(11.0),
              child: Container(
                width: 55,
                decoration: (index == controller.currentIndex.value)
                    ? BoxDecoration(
                        color: HexColor("#0B0C2B"),
                        borderRadius: BorderRadius.circular(24))
                    : BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        border:
                            Border.all(color: HexColor("#0B0C2B"), width: 2)),
                child: Icon(
                  icon,
                  color: (index == controller.currentIndex.value ||
                          Get.currentRoute == Routes.BERANDA)
                      ? Colors.white
                      : HexColor("#0B0C2B"),
                ),
              ),
            ),
          ),
        ));
  }
}
