import 'dart:developer';

import 'package:atan_app/app/modules/berandaBos/views/beranda_bos_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../controller/auth_controller.dart';
import '../../../util/Loading.dart';
import '../controllers/beranda_controller.dart';

class BerandaView extends GetView<BerandaController> {
  const BerandaView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final authC = Get.put(AuthController());

    return Scaffold(
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
                      "Selamat datang, Ribka",
                      style: TextStyle(
                        fontSize: 19,
                        color: HexColor("#0B0C2B"),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      "Daftar Tugas Pekerjaan Anda Disini",
                      style: TextStyle(
                        fontSize: 19,
                        color: HexColor("#0B0C2B"),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: Icon(
                    PhosphorIcons.userCircle,
                    size: 45,
                    color: HexColor("#0B0C2B"),
                  ),
                ),
              ],
            ),
            SizedBox(height: 6.h),
            Text(
              "Tugas Saya",
              style: TextStyle(
                fontSize: 40,
                color: HexColor("#0B0C2B"),
                fontWeight: FontWeight.w600,
              ),
            ),
            Container(
                margin: EdgeInsets.only(left: 5, right: 5, top: 20),
                height: 33.6.h,
                width: 304.w,
                decoration: BoxDecoration(
                  color: HexColor("#BFC0D2"),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          textDirection: TextDirection.ltr,
                          children: [
                            Text(
                              "Pesanan Bapak Tulus",
                              style: TextStyle(
                                fontSize: 22,
                                color: HexColor("#0B0C2B"),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(width: 5.w),
                            Text(
                              "10 Januari 2023",
                              style: TextStyle(
                                fontSize: 15,
                                color: HexColor("#0B0C2B"),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5.h),
                        ListView.builder(
                            shrinkWrap: true,
                            physics: AlwaysScrollableScrollPhysics(),
                            padding: EdgeInsets.only(top: 0.1.h, bottom: 0.1.h),
                            itemCount: 3,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  textDirection: TextDirection.ltr,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Divisi Jahit",
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: HexColor("#0B0C2B"),
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        SizedBox(height: 1.h),
                                        Text(
                                          "Lanjutkan Menjahit",
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: HexColor("#0B0C2B"),
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Icon(
                                      PhosphorIcons.circleBold,
                                      size: 15,
                                      color: HexColor("#0B0C2B"),
                                    ),
                                  ],
                                ),
                              );
                            }),
                      ],
                    ))),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Riwayat Tugas",
                  style: TextStyle(
                    fontSize: 25,
                    color: HexColor("#0B0C2B"),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  width: 20.w,
                  height: 9.h,
                ),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      PhosphorIcons.slidersHorizontal,
                      color: HexColor("#0B0C2B"),
                    ))
              ],
            ),
            ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.only(top: 2, bottom: 5),
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Padding(
                      child: Container(
                        margin: EdgeInsets.only(left: 5, right: 5),
                        height: 10.h,
                        width: 304.w,
                        decoration: BoxDecoration(
                          color: HexColor("#BFC0D2"),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        padding: EdgeInsets.only(
                            left: 0.8.w, top: 2.h, bottom: 0.1.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Text("Pesanan Bapak Tulus",
                                    style: TextStyle(
                                      fontSize: 21,
                                      color: HexColor("#0B0C2B"),
                                      fontWeight: FontWeight.w500,
                                    )),
                                SizedBox(height: 1.5.h),
                                Text("Tenggat : 20 Februari 2023",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: HexColor("#0B0C2B"),
                                      fontWeight: FontWeight.w500,
                                    )),
                              ],
                            ),
                            Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: 0.4.h, bottom: 0.3.h),
                                  child: Text("Belum",
                                      style: TextStyle(
                                        fontSize: 21,
                                        color: HexColor("#0B0C2B"),
                                        fontWeight: FontWeight.w800,
                                      )),
                                ),
                                Text("Selesai",
                                    style: TextStyle(
                                      fontSize: 21,
                                      color: HexColor("#0B0C2B"),
                                      fontWeight: FontWeight.w800,
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
                      padding: EdgeInsets.only(bottom: 1.h));
                }),
          ],
        ),
      ),
    );
  }
}
