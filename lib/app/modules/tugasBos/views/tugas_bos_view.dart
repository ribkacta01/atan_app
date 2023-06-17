import 'package:atan_app/app/routes/app_pages.dart';
import 'package:atan_app/app/util/string.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lottie/lottie.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../util/color.dart';
import '../../../util/notif.dart';
import '../../berandaBos/controllers/beranda_bos_controller.dart';
import '../controllers/tugas_bos_controller.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';

class TugasBosView extends GetView<TugasBosController> {
  TugasBosView({Key? key}) : super(key: key);
  final tugasC = Get.put(TugasBosController());
  @override
  Widget build(BuildContext context) {
    tugasC.filteredData.clear();
    final home = Get.put(BerandaBosController());
    final notifC = Get.put(NotificationController());
    final dateFormatterDefault = DateFormat('d MMMM yyyy', 'id-ID');

    return Scaffold(
        floatingActionButton: Padding(
          padding: EdgeInsets.only(bottom: 0.5.h),
          child: Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              onPressed: () {
                Get.toNamed(Routes.TAMBAH_TUGAS);
              },
              backgroundColor: HexColor("#0B0C2B"),
              child: const Icon(PhosphorIcons.plus),
            ),
          ),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              stream: home.berandaBos(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                      child: Lottie.asset('assets/animation/loading.json',
                          height: 145));
                }
                var data = snapshot.data!;
                return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(
                        decelerationRate: ScrollDecelerationRate.normal),
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
                                  "Daftar Pekerjaan Untuk Pegawai Anda",
                                  style: TextStyle(
                                    fontSize: 12.sp,
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
                                  width: 11.w,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4.h),
                        Row(
                          children: [
                            Text(
                              "Daftar Tugas",
                              style: TextStyle(
                                fontSize: 18.sp,
                                color: HexColor("#0B0C2B"),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              width: 52.w,
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
                                        selectionColor: bluePrimary,
                                        startRangeSelectionColor: bluePrimary,
                                        endRangeSelectionColor: bluePrimary,
                                        rangeSelectionColor:
                                            bluePrimary.withOpacity(0.2),
                                        selectionMode:
                                            DateRangePickerSelectionMode.range,
                                        showActionButtons: true,
                                        onCancel: () => Get.back(),
                                        onSubmit: (value) {
                                          if (value != null) {
                                            if ((value as PickerDateRange)
                                                    .endDate !=
                                                null) {
                                              controller.pickRangeDate(
                                                  value.startDate!,
                                                  value.endDate!);
                                              Get.back();
                                            } else {
                                              Get.dialog(Dialog(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            18.sp)),
                                                backgroundColor: grey1,
                                                child: Container(
                                                  width: 55.w,
                                                  height: 30.h,
                                                  child: Column(
                                                    children: [
                                                      Lottie.asset(
                                                          'assets/animation/alert.json',
                                                          width: 28.w),
                                                      SizedBox(
                                                        height: 1.h,
                                                      ),
                                                      Text(
                                                        "Terjadi Kesalahan!",
                                                        style: TextStyle(
                                                            fontSize: 15.sp,
                                                            color: bluePrimary,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                      SizedBox(
                                                        height: 1.5.h,
                                                      ),
                                                      Center(
                                                        child: Text(
                                                          "Pilih tanggal jangkauan\n(Senin-Sabtu, dsb)\n(tekan tanggal dua kali \nuntuk memilih tanggal yang sama)",
                                                          style: TextStyle(
                                                            fontSize: 8.sp,
                                                            color: bluePrimary,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ));
                                            }
                                          } else {
                                            Get.dialog(Dialog(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          18.sp)),
                                              backgroundColor: grey1,
                                              child: Container(
                                                width: 55.w,
                                                height: 28.h,
                                                child: Column(
                                                  children: [
                                                    Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 2.h),
                                                        child: Lottie.asset(
                                                            'assets/animation/alert.json',
                                                            width: 25.w)),
                                                    SizedBox(
                                                      height: 3.h,
                                                    ),
                                                    Text(
                                                      "Terjadi Kesalahan!",
                                                      style: TextStyle(
                                                        fontSize: 15.sp,
                                                        color: bluePrimary,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 1.5.h,
                                                    ),
                                                    Text(
                                                      "Tanggal Belum Dipilih",
                                                      style: TextStyle(
                                                        fontSize: 10.sp,
                                                        color: bluePrimary,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 2.h,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ));
                                          }
                                        },
                                      ),
                                    ),
                                  ));
                                },
                                icon: Icon(
                                  PhosphorIcons.slidersHorizontal,
                                  color: HexColor("#0B0C2B"),
                                )),
                          ],
                        ),
                        StreamBuilder<
                                List<DocumentSnapshot<Map<String, dynamic>>>>(
                            stream: tugasC.tugas(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                    child: Lottie.asset(
                                        'assets/animation/loading.json',
                                        height: 145));
                              }

                              if (!snapshot.hasData ||
                                  snapshot.data!.length == 0) {
                                return Padding(
                                    padding: EdgeInsets.only(top: 33.h),
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
                                                color: grey1,
                                              ))
                                        ],
                                      ),
                                    ));
                              }

                              tugasC.allData.assignAll(snapshot.data!);
                              for (var doc in tugasC.allData) {
                                tugasC.uniqueNames.add(doc['Nama Pemesan']);
                              }

                              return SingleChildScrollView(
                                physics: const NeverScrollableScrollPhysics(),
                                child: Container(
                                  height: 70.h,
                                  child: ContainedTabBarView(
                                    tabs: [
                                      Text(
                                        "Dalam Proses",
                                        style: TextStyle(
                                          fontSize: 11.sp,
                                          color: bluePrimary,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        "Selesai",
                                        style: TextStyle(
                                          fontSize: 11.sp,
                                          color: HexColor("#0B0C2B"),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                    tabBarViewProperties:
                                        const TabBarViewProperties(
                                            physics:
                                                NeverScrollableScrollPhysics()),
                                    tabBarProperties: TabBarProperties(
                                        height: 4.h,
                                        indicator: ContainerTabIndicator(
                                            width: 30.w,
                                            height: 3.5.h,
                                            radius:
                                                BorderRadius.circular(14.sp),
                                            color: grey1),
                                        indicatorColor: grey1,
                                        indicatorWeight: 5.0,
                                        labelColor: bluePrimary,
                                        unselectedLabelColor: Colors.grey[400]),
                                    views: [
                                      SingleChildScrollView(
                                        child: Obx(() => ListView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            padding: EdgeInsets.only(top: 0.h),
                                            itemCount:
                                                tugasC.filteredData.isEmpty
                                                    ? tugasC.uniqueNames.length
                                                    : tugasC.uniqueNames.length,
                                            itemBuilder: (context, index) {
                                              final name = tugasC.uniqueNames
                                                  .elementAt(index);
                                              final docs = snapshot.data!.where(
                                                  (doc) =>
                                                      doc['Nama Pemesan'] ==
                                                          name &&
                                                      doc['Status'] ==
                                                          'Belum Selesai');

                                              final doc = docs.isNotEmpty
                                                  ? docs.first
                                                  : null;

                                              if (doc != null) {
                                                return GestureDetector(
                                                    onTap: () {
                                                      tugasC.toggleExpanded(
                                                          index);
                                                    },
                                                    child: Obx(
                                                      () => AnimatedContainer(
                                                        duration:
                                                            const Duration(
                                                                milliseconds:
                                                                    100),
                                                        margin: EdgeInsets.only(
                                                            left: 2.w,
                                                            right: 2.w,
                                                            top: 1.h),
                                                        height: tugasC.isChanged
                                                                    .value ==
                                                                index
                                                            ? 65.h
                                                            : 10.h,
                                                        width: 304.w,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: randomColor(),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      16.sp),
                                                        ),
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 0.8.w,
                                                                top: 2.h,
                                                                bottom: 0.1.h),
                                                        child: Column(
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceAround,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Column(
                                                                  children: [
                                                                    Text(
                                                                        "Pesanan ${doc['Nama Pemesan']}",
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              12.sp,
                                                                          color:
                                                                              white,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                        )),
                                                                    SizedBox(
                                                                        height:
                                                                            1.5.h),
                                                                    Text(
                                                                        "Tenggat : ${dateFormatterDefault.format(DateTime.parse(doc['Tanggal Tenggat']))}",
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              10.sp,
                                                                          color:
                                                                              white,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                        )),
                                                                  ],
                                                                ),
                                                                Column(
                                                                  children: [
                                                                    Padding(
                                                                      padding: EdgeInsets.only(
                                                                          top: 0.4
                                                                              .h,
                                                                          bottom:
                                                                              0.3.h),
                                                                      child: Text(
                                                                          "${doc['Status']}",
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                12.sp,
                                                                            color:
                                                                                Colors.yellow,
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
                                                                visible: tugasC
                                                                            .isChanged
                                                                            .value ==
                                                                        index &&
                                                                    tugasC
                                                                        .isVisible
                                                                        .value,
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    const SizedBox(
                                                                      height:
                                                                          40,
                                                                    ),
                                                                    TextButton(
                                                                      child:
                                                                          Text(
                                                                        "Ubah Ke Selesai",
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              13.sp,
                                                                          color:
                                                                              bluePrimary,
                                                                          fontWeight:
                                                                              FontWeight.w800,
                                                                        ),
                                                                      ),
                                                                      onPressed:
                                                                          () async {
                                                                        await tugasC.editStatus(docs, 'Selesai').then((value) => notifC.sendNotificationToAllUser(
                                                                            tugasSelesaiTitle,
                                                                            tugasSelesaiMessage,
                                                                            berandaView));
                                                                      },
                                                                    ),
                                                                    SizedBox(
                                                                        height:
                                                                            5.h),
                                                                    Container(
                                                                      height:
                                                                          35.h,
                                                                      child: StreamBuilder<
                                                                              QuerySnapshot<Map<String, dynamic>>>(
                                                                          stream: tugasC.tugasDiv(doc['Nama Pemesan']),
                                                                          builder: (context, snapshot) {
                                                                            if (snapshot.connectionState ==
                                                                                ConnectionState.waiting) {
                                                                              return Center(
                                                                                child: Lottie.asset('assets/animation/loading.json', height: 145),
                                                                              );
                                                                            }

                                                                            return Scrollbar(
                                                                              child: ListView.builder(
                                                                                  shrinkWrap: true,
                                                                                  physics: const BouncingScrollPhysics(decelerationRate: ScrollDecelerationRate.normal),
                                                                                  padding: EdgeInsets.only(top: 0.1.h, bottom: 0.1.h),
                                                                                  itemCount: snapshot.data!.docs.length,
                                                                                  itemBuilder: (context, index) {
                                                                                    Map<String, dynamic> listTugas = snapshot.data!.docs[index].data();

                                                                                    return Padding(
                                                                                      padding: EdgeInsets.only(top: 3.h, left: 2.h, right: 2.h, bottom: 1.h),
                                                                                      child: Row(
                                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                                                        textDirection: TextDirection.ltr,
                                                                                        children: [
                                                                                          Column(
                                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                                                            children: [
                                                                                              Text(
                                                                                                "${listTugas['Divisi']}",
                                                                                                style: TextStyle(
                                                                                                  fontSize: 10.sp,
                                                                                                  color: white,
                                                                                                  fontWeight: FontWeight.w500,
                                                                                                ),
                                                                                              ),
                                                                                              SizedBox(height: 0.5.h),
                                                                                              Text(
                                                                                                "${listTugas['Keterangan']}",
                                                                                                style: TextStyle(
                                                                                                  fontSize: 8.sp,
                                                                                                  color: white,
                                                                                                  fontWeight: FontWeight.w400,
                                                                                                ),
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                          Icon(
                                                                                            PhosphorIcons.circleBold,
                                                                                            size: 10.sp,
                                                                                            color: HexColor("#0B0C2B"),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    );
                                                                                  }),
                                                                            );
                                                                          }),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ));
                                              } else {
                                                return SizedBox();
                                              }
                                            })),
                                      ),
                                      SingleChildScrollView(
                                        child: Obx(() => ListView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            padding: EdgeInsets.only(top: 0.h),
                                            itemCount:
                                                tugasC.filteredData.isEmpty
                                                    ? tugasC.uniqueNames.length
                                                    : tugasC.uniqueNames.length,
                                            itemBuilder: (context, index) {
                                              final name = tugasC.uniqueNames
                                                  .elementAt(index);
                                              final docs = tugasC
                                                      .filteredData.isEmpty
                                                  ? snapshot.data?.where(
                                                      (doc) =>
                                                          doc['Nama Pemesan'] ==
                                                              name &&
                                                          doc['Status'] ==
                                                              'Selesai')
                                                  : tugasC.filteredData.where(
                                                      (doc) =>
                                                          doc['Nama Pemesan'] ==
                                                              name &&
                                                          doc['Status'] ==
                                                              'Selesai');
                                              final doc = docs!.isNotEmpty
                                                  ? docs.first
                                                  : null;

                                              if (doc != null) {
                                                return Padding(
                                                    padding: EdgeInsets.only(
                                                        bottom: 0.1.h),
                                                    child: Container(
                                                      margin: EdgeInsets.only(
                                                          left: 2.w,
                                                          right: 2.w,
                                                          top: 1.h),
                                                      height: 10.h,
                                                      width: 304.w,
                                                      decoration: BoxDecoration(
                                                        color: brick,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    16.sp),
                                                      ),
                                                      padding: EdgeInsets.only(
                                                          left: 0.8.w,
                                                          top: 2.h,
                                                          bottom: 0.1.h),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Column(
                                                            children: [
                                                              Text(
                                                                  "Pesanan ${doc['Nama Pemesan']}",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        12.sp,
                                                                    color:
                                                                        white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  )),
                                                              SizedBox(
                                                                  height:
                                                                      1.5.h),
                                                              Text(
                                                                  "Tenggat : ${dateFormatterDefault.format(DateTime.parse(doc['Tanggal Tenggat']))}",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        10.sp,
                                                                    color:
                                                                        white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  )),
                                                            ],
                                                          ),
                                                          Column(
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .only(
                                                                  top: 1.5.h,
                                                                ),
                                                                child: Text(
                                                                    "${doc['Status']}",
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          12.sp,
                                                                      color:
                                                                          white,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w800,
                                                                    )),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ));
                                              } else {
                                                return SizedBox.shrink();
                                              }
                                            })),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ],
                    ));
              }),
        ));
  }
}
