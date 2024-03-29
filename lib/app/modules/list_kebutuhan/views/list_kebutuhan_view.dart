import 'package:atan_app/app/controller/auth_controller.dart';
import 'package:atan_app/app/util/color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lottie/lottie.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart' show DateFormat;
import '../controllers/list_kebutuhan_controller.dart';

class ListKebutuhanView extends GetView<ListKebutuhanController> {
  const ListKebutuhanView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var doc = Get.arguments;
    final dateFormatterDefault = DateFormat('d MMMM yyyy', 'id-ID');
    var docName =
        '${doc['nama']} - ${dateFormatterDefault.format(DateTime.parse(doc['date']))}';

    final authC = Get.put(AuthController());
    final listC = Get.put(ListKebutuhanController());
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(
                decelerationRate: ScrollDecelerationRate.normal),
            padding: EdgeInsets.only(
              left: 3.w,
              right: 3.w,
              top: 1.h,
            ),
            child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                stream: authC.getUserRoles(),
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
                        SizedBox(height: 6.h),
                        IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: const Icon(PhosphorIcons.arrowLeft)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                left: 3.w,
                                right: 3.w,
                                top: 1.h,
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                    "Perencanaan Produksi Anda Disini ",
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: HexColor("#0B0C2B"),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 3.w),
                              child: ClipOval(
                                child: Image.network(
                                  data.get('photoUrl'),
                                  height: 10.w,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 6.h),
                        Padding(
                          padding: EdgeInsets.only(left: 3.w),
                          child: Text(
                            "Daftar Kebutuhan Pesanan",
                            style: TextStyle(
                              fontSize: 22,
                              color: HexColor("#0B0C2B"),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(height: 2.h),
                        StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                            stream: listC.list(docName),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                    child: Lottie.asset(
                                        'assets/animation/loading.json',
                                        height: 145));
                              }
                              if (snapshot.data == null ||
                                  snapshot.data!.docs.isEmpty) {
                                return Padding(
                                    padding: EdgeInsets.only(top: 20.h),
                                    child: Center(
                                      child: Column(
                                        children: [
                                          Lottie.asset(
                                              'assets/animation/noData.json',
                                              width: 28.w),
                                          // SizedBox(height: 2.h),
                                          Text(
                                              "Belum Ada Item yang Ditambahkan",
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
                                  physics: const BouncingScrollPhysics(
                                      decelerationRate:
                                          ScrollDecelerationRate.normal),
                                  padding: EdgeInsets.only(
                                      top: 1.5.h, bottom: 1.5.h),
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (context, index) {
                                    Map<String, dynamic> data =
                                        snapshot.data!.docs[index].data();

                                    return Padding(
                                      padding: EdgeInsets.only(bottom: 2.h),
                                      child: Material(
                                        child: InkWell(
                                          onTap: () {},
                                          child: Container(
                                            // margin: EdgeInsets.only(left: 12, right: 12),
                                            height: 11.h,
                                            width: 304.w,
                                            decoration: BoxDecoration(
                                              color: randomize(),
                                              borderRadius:
                                                  BorderRadius.circular(16.sp),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: 0.8.w,
                                                  right: 3.w,
                                                  bottom: 0.1.h),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    14.sp)),
                                                    height: 8.5.h,
                                                    width: 8.5.h,
                                                    child: Center(
                                                      child: Icon(
                                                        PhosphorIcons.checkBold,
                                                        size: 25.sp,
                                                        color: bluePrimary,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 1.w),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 0.8.h,
                                                        bottom: 1.h),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(height: 1.h),
                                                        Row(
                                                          children: [
                                                            Text(
                                                                "Nama Barang  : ",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      11.sp,
                                                                  color: white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                )),
                                                            SizedBox(
                                                                width: 2.w),
                                                            Text(
                                                                data[
                                                                    'Nama Barang'],
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      11.sp,
                                                                  color: white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                )),
                                                          ],
                                                        ),
                                                        SizedBox(height: 1.h),
                                                        Row(
                                                          children: [
                                                            Text(
                                                                "Jumlah             : ",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      11.sp,
                                                                  color: white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                )),
                                                            SizedBox(
                                                                width: 2.w),
                                                            Text(
                                                                data[
                                                                    'Jumlah Barang'],
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      11.sp,
                                                                  color: white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                )),
                                                          ],
                                                        ),
                                                        SizedBox(height: 1.h),
                                                        Row(
                                                          children: [
                                                            Text(
                                                                "Keterangan      : ",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      11.sp,
                                                                  color: white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                )),
                                                            SizedBox(
                                                                width: 2.w),
                                                            Text(
                                                                data[
                                                                    'Keterangan'],
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      11.sp,
                                                                  color: white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                )),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(width: 2.w),
                                                  IconButton(
                                                      enableFeedback: true,
                                                      onPressed: () {},
                                                      icon: const Icon(
                                                        PhosphorIcons
                                                            .pencilSimpleFill,
                                                        color:
                                                            Colors.transparent,
                                                      )),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                            }),
                      ]);
                })));
  }
}
