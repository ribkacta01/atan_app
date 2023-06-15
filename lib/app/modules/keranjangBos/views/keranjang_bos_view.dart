import 'package:atan_app/app/modules/berandaBos/controllers/beranda_bos_controller.dart';
import 'package:atan_app/app/util/Loading.dart';
import 'package:atan_app/app/util/color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lottie/lottie.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../routes/app_pages.dart';
import '../controllers/keranjang_bos_controller.dart';
import 'package:intl/intl.dart' show DateFormat;

class KeranjangBosView extends GetView<KeranjangBosController> {
  KeranjangBosView({Key? key}) : super(key: key);

  final keranjangC = Get.put(KeranjangBosController());
  @override
  Widget build(BuildContext context) {
    final dateFormatterDefault = DateFormat('d MMMM yyyy', 'id-ID');
    keranjangC.filteredData.clear();
    keranjangC.dateMonthNow();
    final home = Get.put(BerandaBosController());
    return FutureBuilder(
        future: Future.delayed(Duration(seconds: 2)),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Loading();
          }
          return Scaffold(
              floatingActionButton: Padding(
                padding: EdgeInsets.only(bottom: 0.5.h),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: FloatingActionButton(
                    onPressed: () {
                      Get.toNamed(Routes.TAMBAH_PEMESAN);
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
                                Padding(
                                  padding: EdgeInsets.only(right: 3.w),
                                  child: ClipOval(
                                    child: Image.network(
                                      data.get('photoUrl'),
                                      width: 8.w,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 2.5.h),
                            Form(
                              child: Container(
                                  height: 5.h,
                                  width: 90.w,
                                  child: TextFormField(
                                    controller: controller.searchController,
                                    onChanged: (value) =>
                                        keranjangC.searchQuery.add(value),
                                    textCapitalization:
                                        TextCapitalization.sentences,
                                    decoration: InputDecoration(
                                      suffixIcon:
                                          Icon(PhosphorIcons.magnifyingGlass),
                                      iconColor: HexColor("#0B0C2B"),
                                      fillColor: HexColor("#BFC0D2"),
                                      filled: true,
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          borderSide: BorderSide(
                                              color: HexColor("#5B5B6E"),
                                              width: 2)),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          borderSide:
                                              BorderSide(color: Colors.white)),
                                      labelText: "Cari Pesanan...",
                                    ),
                                  )),
                            ),
                            SizedBox(height: 2.5.h),
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(bottom: 8.sp),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: HexColor("#0B0C2B"),
                                        borderRadius:
                                            BorderRadius.circular(15.sp)),
                                    height: 3.5.h,
                                    width: 9.h,
                                    child: Center(
                                      child: TextButton(
                                        onPressed: () {},
                                        child: Text(
                                          "Terbaru",
                                          style: TextStyle(
                                            fontSize: 10.sp,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 60.w,
                                  height: 1.h,
                                ),
                                IconButton(
                                  icon: Icon(PhosphorIcons.slidersHorizontal,
                                      color: bluePrimary),
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
                                              DateRangePickerSelectionMode
                                                  .range,
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
                                                    height: 28.h,
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
                                                              color:
                                                                  bluePrimary,
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
                                                              color:
                                                                  bluePrimary,
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
                                ),
                              ],
                            ),
                            StreamBuilder<
                                    List<
                                        DocumentSnapshot<
                                            Map<String, dynamic>>>>(
                                stream: keranjangC.documentsStream(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Loading();
                                  }
                                  if (snapshot.data?.length == 0 ||
                                      snapshot.data == null) {
                                    return Padding(
                                        padding: EdgeInsets.only(top: 4.h),
                                        child: Center(
                                          child: Column(
                                            children: [
                                              Lottie.asset(
                                                  'assets/animation/search.json',
                                                  width: 25.w),
                                              // SizedBox(height: 2.h),
                                              Text("Pencarian Tidak Ditemukan",
                                                  style: TextStyle(
                                                    fontSize: 10.sp,
                                                    color: grey1,
                                                  ))
                                            ],
                                          ),
                                        ));
                                  }
                                  keranjangC.allData.assignAll(snapshot.data!);
                                  return Obx(
                                    () => ListView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        padding: EdgeInsets.only(
                                            top: 1.5.h, bottom: 1.5.h),
                                        itemCount: keranjangC
                                                .filteredData.isEmpty
                                            ? keranjangC.allData.length
                                            : keranjangC.filteredData.length,
                                        itemBuilder: (context, index) {
                                          var data = keranjangC
                                                  .filteredData.isEmpty
                                              ? keranjangC.allData[index]
                                                  .data()!
                                              : keranjangC.filteredData[index]
                                                  .data()!;
                                          if (data.length == 0) {
                                            return Padding(
                                                padding:
                                                    EdgeInsets.only(top: 33.h),
                                                child: Center(
                                                  child: Column(
                                                    children: [
                                                      Lottie.asset(
                                                          'assets/animation/noData.json',
                                                          width: 30.w),
                                                      // SizedBox(height: 2.h),
                                                      Text("Belum Ada Pesanan",
                                                          style: TextStyle(
                                                            fontSize: 12.sp,
                                                            color: grey1,
                                                          ))
                                                    ],
                                                  ),
                                                ));
                                          }

                                          return Padding(
                                            padding:
                                                EdgeInsets.only(bottom: 2.h),
                                            child: Material(
                                              child: InkWell(
                                                onTap: () {
                                                  Get.toNamed(
                                                      Routes.LIST_KEBUTUHAN,
                                                      arguments: data);
                                                },
                                                child: Container(
                                                  // margin: EdgeInsets.only(left: 12, right: 12),
                                                  height: 11.h,
                                                  width: 304.w,
                                                  decoration: BoxDecoration(
                                                    color: randomBlue(),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16.sp),
                                                  ),
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 0.8.w,
                                                        bottom: 0.1.h),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          decoration: BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          14.sp)),
                                                          height: 8.5.h,
                                                          width: 8.5.h,
                                                          child: Center(
                                                            child: Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      right:
                                                                          1.w,
                                                                      bottom:
                                                                          1.w),
                                                              child: IconButton(
                                                                onPressed: () {
                                                                  keranjangC
                                                                      .delData(
                                                                          '${data['nama']} - ${dateFormatterDefault.format(DateTime.parse(data['date']))}');
                                                                },
                                                                icon: Icon(
                                                                    PhosphorIcons
                                                                        .trashSimple,
                                                                    size: 25.sp,
                                                                    color:
                                                                        bluePrimary),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      top:
                                                                          2.5.h,
                                                                      right:
                                                                          2.w,
                                                                      left:
                                                                          1.w),
                                                              child: Text(
                                                                  data['nama'],
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        12.sp,
                                                                    color:
                                                                        white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                  )),
                                                            ),
                                                            SizedBox(
                                                                height: 1.5.h),
                                                            Text(
                                                                '${dateFormatterDefault.format(DateTime.parse(data['date']))}',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      12.sp,
                                                                  color: white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                )),
                                                          ],
                                                        ),
                                                        SizedBox(width: 2.w),
                                                        IconButton(
                                                            onPressed: () {
                                                              Get.toNamed(
                                                                  Routes
                                                                      .LIST_KEBUTUHAN,
                                                                  arguments:
                                                                      data);
                                                            },
                                                            icon: Icon(
                                                              PhosphorIcons
                                                                  .caretRightBold,
                                                              color: white,
                                                            )),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        }),
                                  );
                                }),
                          ],
                        ));
                  }));
        });
  }
}
