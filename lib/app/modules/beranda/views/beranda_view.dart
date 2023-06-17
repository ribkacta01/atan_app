// ignore_for_file: depend_on_referenced_packages

import 'package:atan_app/app/modules/tugas/controllers/tugas_controller.dart';
import 'package:atan_app/app/util/color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../controllers/beranda_controller.dart';
import 'package:intl/intl.dart' show DateFormat;

class BerandaView extends GetView<BerandaController> {
  const BerandaView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final berandaC = Get.put(BerandaController());
    final c = Get.put(TugasController());
    final dateFormatterDefault = DateFormat('d MMMM yyyy', 'id-ID');
    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: berandaC.beranda(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: Lottie.asset('assets/animation/loading.json',
                      height: 145));
            }
            var data = snapshot.data!;
            return SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.only(
                left: 3.w,
                right: 3.w,
                top: 1.h,
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
                            "Selamat datang, ${data.get('name')}",
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: bluePrimary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 1.h),
                          Text(
                            "Daftar Tugas Pekerjaan Anda Disini",
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: bluePrimary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 3.w),
                        child: ClipOval(
                          child: Image.network(
                            data.get('photoUrl'),
                            width: 10.w,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    "Tugas Saya",
                    style: TextStyle(
                      fontSize: 22.sp,
                      color: bluePrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      stream: berandaC.tugas(data.get('divisi')),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                              child: Lottie.asset(
                                  'assets/animation/loading.json',
                                  height: 145));
                        }
                        var dataTgs = snapshot.data!;
                        return SingleChildScrollView(
                          child: Container(
                              margin: EdgeInsets.only(
                                  left: 1.w, right: 1.w, top: 3.h),
                              height: 65.h,
                              width: 304.w,
                              decoration: BoxDecoration(
                                color: HexColor("#BFC0D2"),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: dataTgs.docs.isEmpty
                                  ? Padding(
                                      padding: EdgeInsets.only(top: 25.h),
                                      child: Center(
                                        child: Column(
                                          children: [
                                            Lottie.asset(
                                                'assets/animation/noData.json',
                                                width: 30.w),
                                            // SizedBox(height: 2.h),
                                            Text("Progres Masih Kosong",
                                                style: TextStyle(
                                                  fontSize: 12.sp,
                                                  color: grey2,
                                                ))
                                          ],
                                        ),
                                      ))
                                  : Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Segera Selesaikan Tugasmu!",
                                                style: TextStyle(
                                                  fontSize: 17.sp,
                                                  color: bluePrimary,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 5.h),
                                          SingleChildScrollView(
                                            child: SizedBox(
                                              height: 50.h,
                                              child: ListView.builder(
                                                shrinkWrap: true,
                                                physics:
                                                    const AlwaysScrollableScrollPhysics(),
                                                padding: EdgeInsets.only(
                                                    top: 0.1.h, bottom: 0.1.h),
                                                itemCount:
                                                    snapshot.data!.docs.length,
                                                itemBuilder: (context, index) {
                                                  Map<String, dynamic>
                                                      listData = snapshot
                                                          .data!.docs[index]
                                                          .data();
                                                  return Padding(
                                                    padding:
                                                        EdgeInsets.all(2.w),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          textDirection:
                                                              TextDirection.ltr,
                                                          children: [
                                                            Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    Icon(
                                                                      PhosphorIcons
                                                                          .circleFill,
                                                                      size:
                                                                          6.sp,
                                                                      color:
                                                                          bluePrimary,
                                                                    ),
                                                                    SizedBox(
                                                                        width: 2
                                                                            .w),
                                                                    Text(
                                                                      "${listData['Nama Pemesan']}",
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            12.sp,
                                                                        color: HexColor(
                                                                            "#0B0C2B"),
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                    height:
                                                                        1.h),
                                                                Text(
                                                                  "Tenggat Tugas : ${dateFormatterDefault.format(DateTime.parse(listData['Tanggal Tenggat']))}",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        10.sp,
                                                                    color: HexColor(
                                                                        "#0B0C2B"),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                    height:
                                                                        1.h),
                                                                Text(
                                                                  "${listData['Keterangan']}",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        8.sp,
                                                                    color: HexColor(
                                                                        "#0B0C2B"),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            IconButton(
                                                                onPressed: c
                                                                        .disabledIndexes
                                                                        .contains(
                                                                            index)
                                                                    ? () {}
                                                                    : () {
                                                                        c.uploadImage(
                                                                            '${listData['id']}');
                                                                        c.disableIconButton(
                                                                            index);
                                                                      },
                                                                icon: Icon(
                                                                  c.disabledIndexes
                                                                          .contains(
                                                                              index)
                                                                      ? PhosphorIcons
                                                                          .cameraSlash
                                                                      : PhosphorIcons
                                                                          .camera,
                                                                  size: 16.sp,
                                                                  color: c.disabledIndexes
                                                                          .contains(
                                                                              index)
                                                                      ? grey2
                                                                      : bluePrimary,
                                                                ))
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ))),
                        );
                      }),
                  SizedBox(height: 3.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Riwayat Tugas",
                        style: TextStyle(
                          fontSize: 18.sp,
                          color: HexColor("#0B0C2B"),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        width: 20.w,
                        height: 4.h,
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(PhosphorIcons.slidersHorizontal,
                              color: white))
                    ],
                  ),
                  StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      stream: berandaC.tugasDone(data.get('divisi')),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                              child: Lottie.asset(
                                  'assets/animation/loading.json',
                                  height: 145));
                        }

                        var dataRiwayat = snapshot.data!;
                        if (dataRiwayat.docs.isEmpty) {
                          return Padding(
                              padding: EdgeInsets.only(bottom: 3.h),
                              child: Center(
                                child: Column(
                                  children: [
                                    Lottie.asset('assets/animation/noData.json',
                                        width: 30.w),
                                    // SizedBox(height: 2.h),
                                    Text("Belum Ada Tugas Selesai",
                                        style: TextStyle(
                                          fontSize: 10.sp,
                                          color: grey1,
                                        ))
                                  ],
                                ),
                              ));
                        }
                        return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.only(top: 1.h, bottom: 1.h),
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              Map<String, dynamic> listRiwayat =
                                  snapshot.data!.docs[index].data();

                              return Padding(
                                  padding: EdgeInsets.only(bottom: 1.h),
                                  child: Container(
                                    margin:
                                        EdgeInsets.only(left: 1.w, right: 1.w),
                                    height: 10.h,
                                    width: 304.w,
                                    decoration: BoxDecoration(
                                      color: bluePrimary,
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    padding: EdgeInsets.only(
                                        left: 0.8.w, top: 2.h, bottom: 0.1.h),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Column(
                                          children: [
                                            Text(
                                                "Pesanan ${listRiwayat['Nama Pemesan']}",
                                                style: TextStyle(
                                                  fontSize: 13.sp,
                                                  color: grey1,
                                                  fontWeight: FontWeight.w500,
                                                )),
                                            SizedBox(height: 1.5.h),
                                            Text(
                                                "Tenggat : ${dateFormatterDefault.format(DateTime.parse(listRiwayat['Tanggal Tenggat']))}",
                                                style: TextStyle(
                                                  fontSize: 10.sp,
                                                  color: grey1,
                                                  fontWeight: FontWeight.w500,
                                                )),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                top: 1.5.h,
                                              ),
                                              child: Text(
                                                  "${listRiwayat['Status']}",
                                                  style: TextStyle(
                                                    fontSize: 13.sp,
                                                    color: white,
                                                    fontWeight: FontWeight.w800,
                                                  )),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ));
                            });
                      }),
                ],
              ),
            );
          }),
    );
  }
}
