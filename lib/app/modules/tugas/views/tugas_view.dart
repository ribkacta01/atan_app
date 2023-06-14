import 'package:atan_app/app/controller/auth_controller.dart';
import 'package:atan_app/app/modules/beranda/controllers/beranda_controller.dart';
import 'package:atan_app/app/util/color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lottie/lottie.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../util/Loading.dart';
import '../../berandaBos/controllers/beranda_bos_controller.dart';
import '../controllers/tugas_controller.dart';

class TugasView extends GetView<TugasController> {
  const TugasView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final c = Get.put(TugasController());
    final authC = Get.put(AuthController());
    final home = Get.put(BerandaBosController());
    final homeC = Get.put(BerandaController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 6,
        ),
        child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            stream: home.berandaBos(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Loading();
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
                            "Lihat Update Pekerjaan Anda",
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
                  StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      stream: homeC.tugas(data.get('divisi')),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Loading();
                        }
                        var dataFoto = snapshot.data!;
                        if (dataFoto.docs.isEmpty) {
                          return Padding(
                              padding: EdgeInsets.only(top: 20.h),
                              child: Center(
                                child: Column(
                                  children: [
                                    Lottie.asset('assets/animation/noData.json',
                                        height: 155),
                                    // SizedBox(height: 2.h),
                                    Text("Belum Ada Tugas yang Diunggah",
                                        style: TextStyle(
                                          fontSize: 18,
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
                                      height: 70.h,
                                      decoration: BoxDecoration(
                                        color: HexColor("#BFC0D2"),
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      child: Column(
                                        children: [
                                          ClipRRect(
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(25),
                                                  topRight:
                                                      Radius.circular(25)),
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
                                                              size: 90),
                                                        ),
                                                        SizedBox(height: 2.h),
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
                                                        SizedBox(height: 1.h),
                                                        Text(
                                                          "Segera Update Progress Pesanan ${dataList['Nama Pemesan']}",
                                                          style: TextStyle(
                                                              color:
                                                                  bluePrimary,
                                                              fontSize: 15),
                                                        ),
                                                        SizedBox(height: 1.h),
                                                        Text(
                                                          "Untuk Ditampilkan Disini",
                                                          style: TextStyle(
                                                              color:
                                                                  bluePrimary,
                                                              fontSize: 15),
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
                                                                fontSize: 25,
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
                                                                fontSize: 20,
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
                                                  padding:
                                                      EdgeInsets.only(top: 2.h),
                                                  child: dataList['photo'] != ''
                                                      ? Text(
                                                          "${dataList['photoDateTime']}",
                                                          style: TextStyle(
                                                              fontSize: 18,
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
                                                            fontSize: 20,
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
                                                            fontSize: 20,
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
