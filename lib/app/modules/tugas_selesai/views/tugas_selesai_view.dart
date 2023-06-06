import 'package:atan_app/app/routes/app_pages.dart';
import 'package:atan_app/app/util/color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../controller/auth_controller.dart';
import '../../../util/Loading.dart';
import '../../berandaBos/controllers/beranda_bos_controller.dart';
import '../controllers/tugas_selesai_controller.dart';

class TugasSelesaiView extends GetView<TugasSelesaiController> {
  const TugasSelesaiView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final done = Get.put(TugasSelesaiController());
    final authC = Get.put(AuthController());
    final home = Get.put(BerandaBosController());

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
                              "Halo, ${data.get('name')}",
                              style: TextStyle(
                                fontSize: 19,
                                color: bluePrimary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 1.h),
                            Text(
                              "Daftar Pekerjaan Untuk Pegawai Anda",
                              style: TextStyle(
                                fontSize: 19,
                                color: bluePrimary,
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
                        )
                      ],
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      "Riwayat Tugas",
                      style: TextStyle(
                        fontSize: 40,
                        color: HexColor("#0B0C2B"),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: TextButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: Text(
                              "Dalam Proses",
                              style: TextStyle(
                                fontSize: 20,
                                color: HexColor("#0B0C2B"),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: HexColor("#0B0C2B"),
                              borderRadius: BorderRadius.circular(20)),
                          height: 3.8.h,
                          width: 25.w,
                          child: Center(
                            child: TextButton(
                              onPressed: () {},
                              child: Text(
                                "Selesai",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20.w,
                          height: 9.h,
                        ),
                        IconButton(
                            onPressed: () {
                              Get.dialog(Dialog(
                                child: Container(
                                  padding: EdgeInsets.all(1.h),
                                  height: 40.h,
                                  child: SfDateRangePicker(
                                    view: DateRangePickerView.year,
                                    selectionMode:
                                        DateRangePickerSelectionMode.range,
                                    showActionButtons: true,
                                    onCancel: () => Get.back(),
                                    onSubmit: (obj) {},
                                  ),
                                ),
                              ));
                            },
                            icon: Icon(
                              PhosphorIcons.slidersHorizontal,
                              color: HexColor("#0B0C2B"),
                            ))
                      ],
                    ),
                    StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                        stream: done.tugasDone(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Loading();
                          }
                          return ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.only(top: 0.h),
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                Map<String, dynamic> listData =
                                    snapshot.data!.docs[index].data();
                                return GestureDetector(
                                    onTap: () {
                                      done.toggleExpanded(index);
                                    },
                                    child: Obx(
                                      () => AnimatedContainer(
                                        duration: Duration(milliseconds: 100),
                                        margin: EdgeInsets.only(
                                            left: 5, right: 5, top: 20),
                                        height: done.isChanged.value == index
                                            ? 50.h
                                            : 10.h,
                                        width: 304.w,
                                        decoration: BoxDecoration(
                                          color: randomColor(),
                                          borderRadius:
                                              BorderRadius.circular(25),
                                        ),
                                        padding: EdgeInsets.only(
                                            left: 0.8.w,
                                            top: 2.h,
                                            bottom: 0.1.h),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Column(
                                                  children: [
                                                    Text(
                                                        "Pesanan ${listData['Nama Pemesan']}",
                                                        style: TextStyle(
                                                          fontSize: 21,
                                                          color: white,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        )),
                                                    SizedBox(height: 1.5.h),
                                                    Text(
                                                        "Tenggat : ${listData['Tanggal Tenggat']}",
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          color: white,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        )),
                                                  ],
                                                ),
                                                Column(
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 0.4.h,
                                                          bottom: 0.3.h),
                                                      child: Text(
                                                          "${listData['Status']}",
                                                          style: TextStyle(
                                                            fontSize: 21,
                                                            color: white,
                                                            fontWeight:
                                                                FontWeight.w800,
                                                          )),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Expanded(
                                              child: Visibility(
                                                visible: done.isChanged.value ==
                                                        index &&
                                                    done.isVisible.value,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    SizedBox(
                                                      height: 40,
                                                    ),
                                                    SizedBox(height: 5.h),
                                                    StreamBuilder<
                                                            QuerySnapshot<
                                                                Map<String,
                                                                    dynamic>>>(
                                                        stream: done.tugasDiv(
                                                            listData[
                                                                'Nama Pemesan']),
                                                        builder: (context,
                                                            snapshot) {
                                                          if (snapshot
                                                                  .connectionState ==
                                                              ConnectionState
                                                                  .waiting) {
                                                            return Loading();
                                                          }
                                                          var dataTgs =
                                                              snapshot.data!;
                                                          return ListView
                                                              .builder(
                                                                  shrinkWrap:
                                                                      true,
                                                                  physics:
                                                                      AlwaysScrollableScrollPhysics(),
                                                                  padding: EdgeInsets.only(
                                                                      top:
                                                                          0.1.h,
                                                                      bottom: 0.1
                                                                          .h),
                                                                  itemCount:
                                                                      snapshot
                                                                          .data!
                                                                          .docs
                                                                          .length,
                                                                  itemBuilder:
                                                                      (context,
                                                                          index) {
                                                                    Map<String,
                                                                            dynamic>
                                                                        listTugas =
                                                                        snapshot
                                                                            .data!
                                                                            .docs[index]
                                                                            .data();
                                                                    return Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          top:
                                                                              10,
                                                                          left:
                                                                              18,
                                                                          right:
                                                                              18,
                                                                          bottom:
                                                                              6),
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.center,
                                                                        textDirection:
                                                                            TextDirection.ltr,
                                                                        children: [
                                                                          Column(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceBetween,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              Text(
                                                                                "${listTugas['Divisi']}",
                                                                                style: TextStyle(
                                                                                  fontSize: 20,
                                                                                  color: white,
                                                                                  fontWeight: FontWeight.w500,
                                                                                ),
                                                                              ),
                                                                              SizedBox(height: 1.h),
                                                                              Text(
                                                                                "${listTugas['Keterangan']}",
                                                                                style: TextStyle(
                                                                                  fontSize: 15,
                                                                                  color: white,
                                                                                  fontWeight: FontWeight.w400,
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          Icon(
                                                                            PhosphorIcons.circleBold,
                                                                            size:
                                                                                15,
                                                                            color:
                                                                                HexColor("#0B0C2B"),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    );
                                                                  });
                                                        }),
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ));
                                ;
                              });
                        })
                  ],
                );
              }),
        ));
  }
}
