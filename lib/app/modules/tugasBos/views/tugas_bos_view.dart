import 'package:atan_app/app/routes/app_pages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../controller/auth_controller.dart';
import '../../../util/Loading.dart';
import '../../../util/color.dart';
import '../../berandaBos/controllers/beranda_bos_controller.dart';
import '../controllers/tugas_bos_controller.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';

class TugasBosView extends GetView<TugasBosController> {
  TugasBosView({Key? key}) : super(key: key);
  final tugasC = Get.put(TugasBosController());
  @override
  Widget build(BuildContext context) {
    final authC = Get.put(AuthController());
    tugasC.filteredData.clear();
    final home = Get.put(BerandaBosController());
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
              child: Icon(PhosphorIcons.plus),
            ),
          ),
        ),
        backgroundColor: Colors.white,
        body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            stream: home.berandaBos(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Loading();
              }
              var data = snapshot.data!;
              return SingleChildScrollView(
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
                                "Selamat datang, ${data.get('name')}",
                                style: TextStyle(
                                  fontSize: 19,
                                  color: HexColor("#0B0C2B"),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 1.h),
                              Text(
                                "Daftar Pekerjaan Untuk Pegawai Anda",
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
                      SizedBox(height: 6.h),
                      Row(
                        children: [
                          Text(
                            "Daftar Tugas",
                            style: TextStyle(
                              fontSize: 40,
                              color: HexColor("#0B0C2B"),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            width: 36.w,
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
                                                            20)),
                                                backgroundColor: bluePrimary,
                                                child: Container(
                                                  width: 350,
                                                  height: 336,
                                                  child: Column(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 20),
                                                        child: Center(
                                                          child: Icon(
                                                            PhosphorIcons
                                                                .xCircle,
                                                            color: white,
                                                            size: 110,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 3.h,
                                                      ),
                                                      Text(
                                                        "Terjadi Kesalahan!",
                                                        style: TextStyle(
                                                          fontSize: 30,
                                                          color: white,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 1.5.h,
                                                      ),
                                                      Text(
                                                        "Pilih tanggal jangkauan\n(Senin-Sabtu, dsb)\n(tekan tanggal dua kali \nuntuk memilih tanggal yang sama)",
                                                        style: TextStyle(
                                                          fontSize: 20,
                                                          color: white,
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
                                          } else {
                                            Get.dialog(Dialog(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              backgroundColor: bluePrimary,
                                              child: Container(
                                                width: 350,
                                                height: 336,
                                                child: Column(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 20),
                                                      child: Icon(
                                                        PhosphorIcons.xCircle,
                                                        color: white,
                                                        size: 110,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 3.h,
                                                    ),
                                                    Center(
                                                      child: Text(
                                                        "Terjadi Kesalahan!",
                                                        style: TextStyle(
                                                          fontSize: 30,
                                                          color: white,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 1.5.h,
                                                    ),
                                                    Center(
                                                      child: Text(
                                                        "Tanggal tidak dipilih",
                                                        style: TextStyle(
                                                          fontSize: 20,
                                                          color: white,
                                                        ),
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
                                        }),
                                  ),
                                ));
                              },
                              icon: Icon(
                                PhosphorIcons.slidersHorizontal,
                                color: HexColor("#0B0C2B"),
                              )),
                        ],
                      ),
                      SingleChildScrollView(
                        child: Container(
                          height: 70.h,
                          child: ContainedTabBarView(
                            tabs: [
                              Text(
                                "Dalam Proses",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: bluePrimary,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                "Selesai",
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
                              unselectedLabelColor: Colors.grey[400],
                            ),
                            views: [
                              FutureBuilder<
                                      List<
                                          DocumentSnapshot<
                                              Map<String, dynamic>>>>(
                                  future: tugasC.tugasProses(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                    if (snapshot.data?.length == 0 ||
                                        snapshot.data == null) {
                                      return Center(
                                        child: Text('KOSONGGGGG'),
                                      );
                                    }

                                    Set<String> uniqueNames = Set<String>();
                                    tugasC.allData.assignAll(snapshot.data!);
                                    for (var doc in tugasC.allData) {
                                      uniqueNames.add(doc['Nama Pemesan']);
                                    }

                                    return SingleChildScrollView(
                                      child: Obx(
                                        () => ListView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            padding: EdgeInsets.only(top: 0.h),
                                            itemCount: tugasC
                                                    .filteredData.isEmpty
                                                ? uniqueNames.length
                                                : tugasC.filteredData.length,
                                            itemBuilder: (context, index) {
                                              var data = tugasC
                                                      .filteredData.isEmpty
                                                  ? tugasC.allData[index]
                                                      .data()!
                                                  : tugasC.filteredData[index]
                                                      .data()!;
                                              if (data.length == 0) {
                                                return Center(
                                                  child: Text('KOSONGGGGG'),
                                                );
                                              }
                                              final name =
                                                  uniqueNames.elementAt(index);
                                              final doc = snapshot.data!
                                                  .firstWhere((doc) =>
                                                      doc['Nama Pemesan'] ==
                                                      name);
                                              // Map<String, dynamic> listData =
                                              //     snapshot.data!.docs[index]
                                              //         .data();
                                              return GestureDetector(
                                                  onTap: () {
                                                    tugasC
                                                        .toggleExpanded(index);
                                                  },
                                                  child: Obx(
                                                    () => AnimatedContainer(
                                                      duration: Duration(
                                                          milliseconds: 100),
                                                      margin: EdgeInsets.only(
                                                          left: 5,
                                                          right: 5,
                                                          top: 20),
                                                      height: tugasC.isChanged
                                                                  .value ==
                                                              index
                                                          ? 68.h
                                                          : 10.h,
                                                      width: 304.w,
                                                      decoration: BoxDecoration(
                                                        color: randomColor(),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(25),
                                                      ),
                                                      padding: EdgeInsets.only(
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
                                                                            21,
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
                                                                            15,
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
                                                                              21,
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
                                                                  SizedBox(
                                                                    height: 40,
                                                                  ),
                                                                  TextButton(
                                                                    child: Text(
                                                                      "Ubah Ke Selesai",
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            20,
                                                                        color:
                                                                            bluePrimary,
                                                                        fontWeight:
                                                                            FontWeight.w800,
                                                                      ),
                                                                    ),
                                                                    onPressed:
                                                                        () {
                                                                      tugasC.editStatus(
                                                                          doc['id'],
                                                                          'Selesai');
                                                                    },
                                                                  ),
                                                                  SizedBox(
                                                                      height:
                                                                          5.h),
                                                                  StreamBuilder<
                                                                          QuerySnapshot<
                                                                              Map<String,
                                                                                  dynamic>>>(
                                                                      stream: tugasC
                                                                          .tugasDiv(doc[
                                                                              'Nama Pemesan']),
                                                                      builder:
                                                                          (context,
                                                                              snapshot) {
                                                                        if (snapshot.connectionState ==
                                                                            ConnectionState.waiting) {
                                                                          return Loading();
                                                                        }
                                                                        var dataTgs =
                                                                            snapshot.data!;
                                                                        return SingleChildScrollView(
                                                                          child: ListView.builder(
                                                                              shrinkWrap: true,
                                                                              physics: AlwaysScrollableScrollPhysics(),
                                                                              padding: EdgeInsets.only(top: 0.1.h, bottom: 0.1.h),
                                                                              itemCount: snapshot.data!.docs.length,
                                                                              itemBuilder: (context, index) {
                                                                                Map<String, dynamic> listTugas = snapshot.data!.docs[index].data();
                                                                                return Padding(
                                                                                  padding: const EdgeInsets.only(top: 20, left: 18, right: 18, bottom: 6),
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
                                                                                        size: 15,
                                                                                        color: HexColor("#0B0C2B"),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                );
                                                                              }),
                                                                        );
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
                                            }),
                                      ),
                                    );
                                  }),
                              StreamBuilder<
                                  List<DocumentSnapshot<Map<String, dynamic>>>>(
                                stream: tugasC.tugasDone(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                  if (snapshot.data?.length == 0 ||
                                      snapshot.data == null) {
                                    return Center(
                                      child: Text('KOSONGGGGG'),
                                    );
                                  }
                                  tugasC.allData.assignAll(snapshot.data!);

                                  return Obx(
                                    () => ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        padding: EdgeInsets.only(top: 0.h),
                                        itemCount: tugasC.filteredData.isEmpty
                                            ? tugasC.allData.length
                                            : tugasC.filteredData.length,
                                        itemBuilder: (context, index) {
                                          var listSelesai = tugasC
                                                  .filteredData.isEmpty
                                              ? tugasC.allData[index].data()!
                                              : tugasC.filteredData[index]
                                                  .data()!;
                                          if (listSelesai.length == 0) {
                                            return Center(
                                              child: Text('KOSONGGGGG'),
                                            );
                                          }

                                          return Padding(
                                              child: Container(
                                                margin: EdgeInsets.only(
                                                    left: 5, right: 5, top: 20),
                                                height: 10.h,
                                                width: 304.w,
                                                decoration: BoxDecoration(
                                                  color: brick,
                                                  borderRadius:
                                                      BorderRadius.circular(25),
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
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Column(
                                                      children: [
                                                        Text(
                                                            "Pesanan ${listSelesai['Nama Pemesan']}",
                                                            style: TextStyle(
                                                              fontSize: 21,
                                                              color: white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            )),
                                                        SizedBox(height: 1.5.h),
                                                        Text(
                                                            "Tenggat : ${dateFormatterDefault.format(DateTime.parse(listSelesai['Tanggal Tenggat']))}",
                                                            style: TextStyle(
                                                              fontSize: 15,
                                                              color: white,
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
                                                              EdgeInsets.only(
                                                            top: 1.5.h,
                                                          ),
                                                          child: Text(
                                                              "${listSelesai['Status']}",
                                                              style: TextStyle(
                                                                fontSize: 21,
                                                                color: white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w800,
                                                              )),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              padding: EdgeInsets.only(
                                                  bottom: 0.1.h));
                                        }),
                                  );
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ));
            }));
  }
}
