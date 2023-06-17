import 'package:atan_app/app/modules/beranda/controllers/beranda_controller.dart';
import 'package:atan_app/app/util/color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lottie/lottie.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../berandaBos/controllers/beranda_bos_controller.dart';
import '../controllers/tugas_controller.dart';

class TugasView extends GetView<TugasController> {
  const TugasView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final home = Get.put(BerandaBosController());
    final homeC = Get.put(BerandaController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.only(
          left: 3.w,
          right: 3.w,
          top: 1.h,
        ),
        child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            stream: home.berandaBos(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: Lottie.asset('assets/animation/loading.json',
                        height: 145));
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
                              fontSize: 12.sp,
                              color: HexColor("#0B0C2B"),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 1.h),
                          Text(
                            "Lihat Update Pekerjaan Anda",
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: HexColor("#0B0C2B"),
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
                  StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      stream: homeC.tugas(data.get('divisi')),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                              child: Lottie.asset(
                                  'assets/animation/loading.json',
                                  height: 145));
                        }
                        var dataFoto = snapshot.data!;
                        if (dataFoto.docs.isEmpty) {
                          return Padding(
                              padding: EdgeInsets.only(top: 20.h),
                              child: Center(
                                child: Column(
                                  children: [
                                    Lottie.asset('assets/animation/noData.json',
                                        width: 35.w),
                                    // SizedBox(height: 2.h),
                                    Text("Belum Ada Tugas yang Diunggah",
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          color: grey1,
                                        ))
                                  ],
                                ),
                              ));
                        }
                        return ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.only(top: 0.000001),
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              Map<String, dynamic> dataList =
                                  snapshot.data!.docs[index].data();

                              return Padding(
                                padding: EdgeInsets.only(
                                  bottom: 2.h,
                                ),
                                child: Material(
                                  child: InkWell(
                                    onTap: () {},
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          right: 4.w, left: 4.w),
                                      height: 72.h,
                                      decoration: BoxDecoration(
                                        color: HexColor("#BFC0D2"),
                                        borderRadius:
                                            BorderRadius.circular(16.sp),
                                      ),
                                      child: Column(
                                        children: [
                                          ClipRRect(
                                              borderRadius: BorderRadius.only(
                                                  topLeft:
                                                      Radius.circular(16.sp),
                                                  topRight:
                                                      Radius.circular(16.sp)),
                                              child: dataList['photo'] != ''
                                                  ? Image.network(
                                                      "${dataList['photo']}",
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
                                                              EdgeInsets.only(
                                                                  top: 25.h),
                                                          child: Icon(
                                                              PhosphorIcons
                                                                  .cameraSlashBold,
                                                              color:
                                                                  bluePrimary,
                                                              size: 55.sp),
                                                        ),
                                                        SizedBox(height: 2.h),
                                                        Text(
                                                          "Belum Ada Foto",
                                                          style: TextStyle(
                                                              color:
                                                                  bluePrimary,
                                                              fontSize: 13.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                        SizedBox(height: 1.h),
                                                        Text(
                                                          "Segera Unggah Progres Pesanan ${dataList['Nama Pemesan']}",
                                                          style: TextStyle(
                                                              color:
                                                                  bluePrimary,
                                                              fontSize: 10.sp),
                                                        ),
                                                        SizedBox(height: 1.h),
                                                        Text(
                                                          "Untuk Ditampilkan Disini",
                                                          style: TextStyle(
                                                              color:
                                                                  bluePrimary,
                                                              fontSize: 10.sp),
                                                        )
                                                      ],
                                                    )),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: 3.h,
                                                right: 5.w,
                                                left: 5.w),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    dataList['photo'] != ''
                                                        ? Text(
                                                            "${data['name']}",
                                                            style: TextStyle(
                                                                fontSize: 12.sp,
                                                                color: HexColor(
                                                                    "#0B0C2B"),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          )
                                                        : Text(''),
                                                    SizedBox(
                                                      height: 1.h,
                                                    ),
                                                    dataList['photo'] != ''
                                                        ? Text(
                                                            "${data['divisi']}",
                                                            style: TextStyle(
                                                                fontSize: 12.sp,
                                                                color: HexColor(
                                                                    "#0B0C2B"),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          )
                                                        : Text(''),
                                                  ],
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 1.8.h),
                                                  child: dataList['photo'] != ''
                                                      ? Text(
                                                          "${dataList['photoDateTime']}",
                                                          style: TextStyle(
                                                              fontSize: 10.sp,
                                                              color: HexColor(
                                                                  "#0B0C2B"),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        )
                                                      : Text(''),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                right: 5.w, left: 5.w),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 1.5.h,
                                                ),
                                                Row(
                                                  children: [
                                                    dataList['photo'] != ''
                                                        ? Container(
                                                            height: 0.5.h,
                                                            width: 73.w,
                                                            color: bluePrimary,
                                                          )
                                                        : Text(''),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 1.5.h,
                                                ),
                                                dataList['photo'] != ''
                                                    ? Text(
                                                        "Pesanan ${dataList['Nama Pemesan']}",
                                                        style: TextStyle(
                                                            fontSize: 12.sp,
                                                            color: HexColor(
                                                                "#0B0C2B"),
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      )
                                                    : Text(''),
                                                SizedBox(
                                                  height: 1.h,
                                                ),
                                                dataList['photo'] != ''
                                                    ? Text(
                                                        "${dataList['detail']}",
                                                        style: TextStyle(
                                                            fontSize: 12.sp,
                                                            color: HexColor(
                                                                "#0B0C2B"),
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      )
                                                    : Text(''),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            });
                      }),
                ],
              );
            }),
      ),
    );
  }
}
