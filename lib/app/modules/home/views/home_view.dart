import 'dart:developer';

import 'package:atan_app/app/controller/auth_controller.dart';
import 'package:atan_app/app/modules/beranda/views/beranda_view.dart';
import 'package:atan_app/app/modules/berandaBos/views/beranda_bos_view.dart';
import 'package:atan_app/app/modules/keranjang/views/keranjang_view.dart';
import 'package:atan_app/app/modules/olah_data_pegawai/views/olah_data_pegawai_view.dart';
import 'package:atan_app/app/modules/profil/views/profil_view.dart';
import 'package:atan_app/app/modules/profilBos/views/profil_bos_view.dart';
import 'package:atan_app/app/util/Loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../routes/app_pages.dart';
import '../../keranjangBos/views/keranjang_bos_view.dart';
import '../../tugas/views/tugas_view.dart';
import '../../tugasBos/views/tugas_bos_view.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final authC = Get.put(AuthController());
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

    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: authC.getUserRoles(),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Loading();
          }
          if (snap.hasData) {
            var roles = snap.data!.get("roles");
            log("$roles");
            if (roles != "pemilik_usaha") {
              return Scaffold(
                body: Obx(() => pages[controller.currentIndex.value]),
                bottomNavigationBar: Container(
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(1),
                        blurRadius: 7,
                        offset: Offset(0, 4))
                  ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      navBarItem(context, PhosphorIcons.houseBold, 0),
                      navBarItem(
                          context, PhosphorIcons.shoppingCartSimpleBold, 1),
                      navBarItem(context, PhosphorIcons.notePencilBold, 2),
                      navBarItem(context, PhosphorIcons.userBold, 3),
                    ],
                  ),
                ),
              );
            } else {
              return Scaffold(
                body: Obx(() => pages2[controller.currentIndex.value]),
                bottomNavigationBar: Container(
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(1),
                        blurRadius: 7,
                        offset: Offset(0, 4))
                  ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      navBarItem(context, PhosphorIcons.houseBold, 0),
                      navBarItem(
                          context, PhosphorIcons.shoppingCartSimpleBold, 1),
                      navBarItem(context, PhosphorIcons.notePencilBold, 2),
                      navBarItem(context, PhosphorIcons.usersThreeBold, 3),
                      navBarItem(context, PhosphorIcons.userBold, 4),
                    ],
                  ),
                ),
              );
            }
          } else {
            return Loading();
          }
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
}
