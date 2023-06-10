import 'package:atan_app/app/modules/beranda/controllers/beranda_controller.dart';
import 'package:atan_app/app/util/color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../util/Loading.dart';
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          top: 6,
        ),
        child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            stream: home.berandaBos(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Loading();
              }
              var data = snapshot.data!;
              return Column(
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
                            "Halo ${data.get('name')}",
                            style: TextStyle(
                              fontSize: 19,
                              color: HexColor("#0B0C2B"),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 1.h),
                          Text(
                            "Lihat Update Pekerjaan Pegawai Anda",
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
                        child: ClipOval(
                          child: Image.network(
                            data.get('photoUrl'),
                            height: 45,
                            width: 45,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5.h),
                  Row(
                    children: [
                      Text(
                        "Daftar Progres Pegawai",
                        style: TextStyle(
                          fontSize: 30,
                          color: HexColor("#0B0C2B"),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 3.h),
                  SingleChildScrollView(
                    child: SizedBox(
                      height: 70.h,
                      child: ContainedTabBarView(
                          tabs: [
                            Text(
                              "Selesai",
                              style: TextStyle(
                                fontSize: 20,
                                color: bluePrimary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              "Dalam Proses",
                              style: TextStyle(
                                fontSize: 20,
                                color: HexColor("#0B0C2B"),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                          tabBarProperties: TabBarProperties(
                              height: 5.h,
                              indicatorColor: bluePrimary,
                              indicatorWeight: 6.0,
                              labelColor: bluePrimary,
                              unselectedLabelColor: Colors.grey[400]),
                          views: [
                            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                                stream: home.tugasPegDone(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Loading();
                                  }

                                  var dataPictProses = snapshot.data!;
                                  return SingleChildScrollView(
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        padding: const EdgeInsets.only(
                                            top: 0.000001),
                                        itemCount: snapshot.data!.docs.length,
                                        itemBuilder: (context, index) {
                                          Map<String, dynamic> dataPoto =
                                              snapshot.data!.docs[index].data();

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
                                                    color: HexColor("#BFC0D2"),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25),
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius:
                                                            const BorderRadius
                                                                    .only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        25),
                                                                topRight: Radius
                                                                    .circular(
                                                                        25)),
                                                        child:
                                                            dataPoto['photo'] !=
                                                                    ''
                                                                ? Image.network(
                                                                    "${dataPoto['photo']}",
                                                                    width: 90.w,
                                                                  )
                                                                : Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Padding(
                                                                        padding:
                                                                            EdgeInsets.only(top: 25.h),
                                                                        child: Icon(
                                                                            PhosphorIcons
                                                                                .cameraSlashBold,
                                                                            color:
                                                                                bluePrimary,
                                                                            size:
                                                                                90),
                                                                      ),
                                                                      SizedBox(
                                                                          height:
                                                                              2.h),
                                                                      Text(
                                                                        "Belum Ada Foto",
                                                                        style: TextStyle(
                                                                            color:
                                                                                bluePrimary,
                                                                            fontSize:
                                                                                20,
                                                                            fontWeight:
                                                                                FontWeight.w500),
                                                                      ),
                                                                      SizedBox(
                                                                          height:
                                                                              1.h),
                                                                      Text(
                                                                        "${dataPoto['Divisi']} Belum Mengunggah Progress",
                                                                        style: TextStyle(
                                                                            color:
                                                                                bluePrimary,
                                                                            fontSize:
                                                                                15),
                                                                      ),
                                                                      SizedBox(
                                                                          height:
                                                                              1.h),
                                                                      Text(
                                                                        "Untuk Pesanan ${dataPoto['Nama Pemesan']}",
                                                                        style: TextStyle(
                                                                            color:
                                                                                bluePrimary,
                                                                            fontSize:
                                                                                15),
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
                                                            Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                dataPoto['photo'] !=
                                                                        ''
                                                                    ? Padding(
                                                                        padding:
                                                                            EdgeInsets.only(top: 2.h),
                                                                        child:
                                                                            Text(
                                                                          "${dataPoto['Divisi']}",
                                                                          style: TextStyle(
                                                                              fontSize: 25,
                                                                              color: HexColor("#0B0C2B"),
                                                                              fontWeight: FontWeight.w500),
                                                                        ),
                                                                      )
                                                                    : const Text(
                                                                        ''),
                                                              ],
                                                            ),
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      top: 2.h),
                                                              child: dataPoto[
                                                                          'photo'] !=
                                                                      ''
                                                                  ? Text(
                                                                      "${dataPoto['photoDateTime']}",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              18,
                                                                          color: HexColor(
                                                                              "#0B0C2B"),
                                                                          fontWeight:
                                                                              FontWeight.w500),
                                                                    )
                                                                  : const Text(
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
                                                            Row(
                                                              children: [
                                                                dataPoto['photo'] !=
                                                                        ''
                                                                    ? Container(
                                                                        height:
                                                                            0.5.h,
                                                                        width:
                                                                            72.w,
                                                                        color:
                                                                            bluePrimary,
                                                                      )
                                                                    : const Text(
                                                                        ''),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 1.5.h,
                                                            ),
                                                            dataPoto['photo'] !=
                                                                    ''
                                                                ? Text(
                                                                    "Pesanan ${dataPoto['Nama Pemesan']}",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            20,
                                                                        color: HexColor(
                                                                            "#0B0C2B"),
                                                                        fontWeight:
                                                                            FontWeight.w400),
                                                                  )
                                                                : Text(''),
                                                            SizedBox(
                                                              height: 1.h,
                                                            ),
                                                            dataPoto['photo'] !=
                                                                    ''
                                                                ? Text(
                                                                    "${dataPoto['detail']}",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            20,
                                                                        color: HexColor(
                                                                            "#0B0C2B"),
                                                                        fontWeight:
                                                                            FontWeight.w400),
                                                                  )
                                                                : const Text(
                                                                    ''),
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
                            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                                stream: home.tugasPegProses(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Loading();
                                  }
                                  var dataPict = snapshot.data!;
                                  return SingleChildScrollView(
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        padding: EdgeInsets.only(top: 0.h),
                                        itemCount: snapshot.data!.docs.length,
                                        itemBuilder: (context, index) {
                                          Map<String, dynamic> dataPoto =
                                              snapshot.data!.docs[index].data();

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
                                                    color: HexColor("#BFC0D2"),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25),
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius:
                                                            const BorderRadius
                                                                    .only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        25),
                                                                topRight: Radius
                                                                    .circular(
                                                                        25)),
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
                                                                      top:
                                                                          25.h),
                                                              child: Icon(
                                                                  PhosphorIcons
                                                                      .cameraSlashBold,
                                                                  color:
                                                                      bluePrimary,
                                                                  size: 90),
                                                            ),
                                                            SizedBox(
                                                                height: 2.h),
                                                            Text(
                                                              "Belum Ada Foto",
                                                              style: TextStyle(
                                                                  color:
                                                                      bluePrimary,
                                                                  fontSize: 20,
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
                                                                  fontSize: 15),
                                                            ),
                                                            SizedBox(
                                                                height: 1.h),
                                                            Text(
                                                              "Untuk Pesanan ${dataPoto['Nama Pemesan']}",
                                                              style: TextStyle(
                                                                  color:
                                                                      bluePrimary,
                                                                  fontSize: 15),
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
                                                            Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: const [
                                                                Text(''),
                                                              ],
                                                            ),
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      top: 2.h),
                                                              child: const Text(
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
                                                            Row(
                                                              children: const [
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
              );
            }),
      ),
    );
  }
}
