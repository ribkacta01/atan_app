import 'package:atan_app/app/modules/beranda/controllers/beranda_controller.dart';
import 'package:atan_app/app/util/color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:dotted_dashed_line/dotted_dashed_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lottie/lottie.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

import '../controllers/beranda_bos_controller.dart';

class BerandaBosView extends GetView<BerandaBosController> {
  const BerandaBosView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final home = Get.put(BerandaBosController());
    // ignore: unused_local_variable
    final homeC = Get.put(BerandaController());
    return Scaffold(
        backgroundColor: Colors.white,
        body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: home.berandaBos(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: Lottie.asset('assets/animation/loading.json',
                      height: 145));
            }
            var data = snapshot.data!;
            return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
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
                                color: HexColor("#0B0C2B"),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 1.h),
                            Text(
                              "Pantau Pekerjaan Pegawai Anda",
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: HexColor("#0B0C2B"),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              "Daftar Tugas",
                              style: TextStyle(
                                fontSize: 18.sp,
                                color: HexColor("#0B0C2B"),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 3.w),
                          child: ClipOval(
                            child: Image.network(
                              data.get('photoUrl'),
                              width: 11.w,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 2.h),
                    SingleChildScrollView(
                      physics: NeverScrollableScrollPhysics(),
                      child: Container(
                        height: 200.h,
                        child: ContainedTabBarView(
                            tabs: [
                              Text(
                                "Selesai",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: bluePrimary,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                "Dalam Proses",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: HexColor("#0B0C2B"),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                            tabBarViewProperties: const TabBarViewProperties(
                                physics: NeverScrollableScrollPhysics()),
                            tabBarProperties: TabBarProperties(
                                height: 4.h,
                                indicatorColor: bluePrimary,
                                indicatorWeight: 5.0,
                                labelColor: bluePrimary,
                                unselectedLabelColor: Colors.grey[400]),
                            views: [
                              StreamBuilder<
                                      QuerySnapshot<Map<String, dynamic>>>(
                                  stream: home.tugasPegDone(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Center(
                                          child: Lottie.asset(
                                              'assets/animation/loading.json',
                                              height: 145));
                                    }

                                    return SingleChildScrollView(
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          padding: const EdgeInsets.only(
                                              top: 0.000001),
                                          itemCount: snapshot.data!.docs.length,
                                          itemBuilder: (context, index) {
                                            Map<String, dynamic> dataPoto =
                                                snapshot.data!.docs[index]
                                                    .data();

                                            return Padding(
                                              padding: EdgeInsets.only(
                                                top: 2.h,
                                              ),
                                              child: Material(
                                                child: InkWell(
                                                  onTap: () {},
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                        right: 4.w, left: 4.w),
                                                    height: 43.h,
                                                    decoration: BoxDecoration(
                                                      color:
                                                          HexColor("#BFC0D2"),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16.sp),
                                                    ),
                                                    child: Column(
                                                      children: [
                                                        ClipRRect(
                                                            borderRadius: BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        16.sp),
                                                                topRight: Radius
                                                                    .circular(
                                                                        16.sp)),
                                                            child: Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      top: 2.h),
                                                              child: InkWell(
                                                                onTap: () {
                                                                  Get.dialog(
                                                                      Dialog(
                                                                    shape: RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(16.sp)),
                                                                    child:
                                                                        ClipRRect(
                                                                      borderRadius:
                                                                          BorderRadius.all(
                                                                              Radius.circular(16.sp)),
                                                                      child: Container(
                                                                          width: 85.w,
                                                                          child: Image.network(
                                                                            "${dataPoto['photo']}",
                                                                            fit:
                                                                                BoxFit.cover,
                                                                          )),
                                                                    ),
                                                                  ));
                                                                },
                                                                child:
                                                                    ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              16.sp)),
                                                                  child:
                                                                      Container(
                                                                    width: 78.w,
                                                                    height:
                                                                        25.h,
                                                                    child: Image
                                                                        .network(
                                                                      "${dataPoto['photo']}",
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            )),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 1.h,
                                                                  right: 5.w,
                                                                  left: 5.w),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Padding(
                                                                    padding: EdgeInsets
                                                                        .only(
                                                                            top:
                                                                                2.h),
                                                                    child: Text(
                                                                      "${dataPoto['Divisi']}",
                                                                      style: TextStyle(
                                                                          fontSize: 12
                                                                              .sp,
                                                                          color: HexColor(
                                                                              "#0B0C2B"),
                                                                          fontWeight:
                                                                              FontWeight.w500),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsets
                                                                        .only(
                                                                            top:
                                                                                2.h),
                                                                    child: Text(
                                                                      "${dataPoto['photoDateTime']}",
                                                                      style: TextStyle(
                                                                          fontSize: 10
                                                                              .sp,
                                                                          color: HexColor(
                                                                              "#0B0C2B"),
                                                                          fontWeight:
                                                                              FontWeight.w500),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        top: 1.5
                                                                            .h,
                                                                        bottom:
                                                                            1.5.h),
                                                                child:
                                                                    DottedDashedLine(
                                                                  height: 0,
                                                                  width: 100.w,
                                                                  axis: Axis
                                                                      .horizontal,
                                                                  dashColor:
                                                                      grey2,
                                                                  dashSpace: 5,
                                                                ),
                                                              ),
                                                              Text(
                                                                "Pesanan ${dataPoto['Nama Pemesan']}",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12.sp,
                                                                    color: HexColor(
                                                                        "#0B0C2B"),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                              SizedBox(
                                                                  height: 1.h),
                                                              Text(
                                                                "${dataPoto['detail']}",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        10.sp,
                                                                    color: HexColor(
                                                                        "#0B0C2B"),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          }),
                                    );
                                  }),
                              StreamBuilder<
                                      QuerySnapshot<Map<String, dynamic>>>(
                                  stream: home.tugasPegProses(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Center(
                                          child: Lottie.asset(
                                              'assets/animation/loading.json',
                                              height: 145));
                                    }

                                    return SingleChildScrollView(
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          padding: EdgeInsets.only(top: 0.h),
                                          itemCount: snapshot.data!.docs.length,
                                          itemBuilder: (context, index) {
                                            Map<String, dynamic> dataPoto =
                                                snapshot.data!.docs[index]
                                                    .data();

                                            return Padding(
                                              padding: EdgeInsets.only(
                                                top: 2.h,
                                              ),
                                              child: Material(
                                                child: InkWell(
                                                  onTap: () {},
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                        right: 4.w, left: 4.w),
                                                    height: 70.h,
                                                    decoration: BoxDecoration(
                                                      color:
                                                          HexColor("#BFC0D2"),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16.sp),
                                                    ),
                                                    child: Column(
                                                      children: [
                                                        ClipRRect(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                                  topLeft: Radius
                                                                      .circular(16
                                                                          .sp),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          16.sp)),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        top: 25
                                                                            .h),
                                                                child: Icon(
                                                                    PhosphorIcons
                                                                        .cameraSlashBold,
                                                                    color:
                                                                        bluePrimary,
                                                                    size:
                                                                        55.sp),
                                                              ),
                                                              SizedBox(
                                                                  height: 2.h),
                                                              Text(
                                                                "Belum Ada Foto",
                                                                style: TextStyle(
                                                                    color:
                                                                        bluePrimary,
                                                                    fontSize:
                                                                        12.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                              SizedBox(
                                                                  height: 1.h),
                                                              Text(
                                                                "${dataPoto['Divisi']} Belum Mengunggah Progress",
                                                                style: TextStyle(
                                                                    color:
                                                                        bluePrimary,
                                                                    fontSize:
                                                                        10.sp),
                                                              ),
                                                              SizedBox(
                                                                  height: 1.h),
                                                              Text(
                                                                "Untuk Pesanan ${dataPoto['Nama Pemesan']}",
                                                                style: TextStyle(
                                                                    color:
                                                                        bluePrimary,
                                                                    fontSize:
                                                                        10.sp),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 1.h,
                                                                  right: 5.w,
                                                                  left: 5.w),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              const Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(''),
                                                                ],
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        top: 2
                                                                            .h),
                                                                child:
                                                                    const Text(
                                                                        ''),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  right: 5.w,
                                                                  left: 5.w),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              SizedBox(
                                                                height: 1.5.h,
                                                              ),
                                                              const Row(
                                                                children: [
                                                                  Text(''),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 1.5.h,
                                                              ),
                                                              const Text(''),
                                                              SizedBox(
                                                                height: 1.h,
                                                              ),
                                                              const Text(''),
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          }),
                                    );
                                  }),
                            ]),
                      ),
                    )
                  ],
                ));
          },
        ));
  }
}
