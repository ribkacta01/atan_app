import 'package:atan_app/app/routes/app_pages.dart';
import 'package:atan_app/app/util/color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lottie/lottie.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../berandaBos/controllers/beranda_bos_controller.dart';
import '../controllers/keranjang_controller.dart';
import 'package:intl/intl.dart' show DateFormat;

class KeranjangView extends GetView<KeranjangController> {
  const KeranjangView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final home = Get.put(BerandaBosController());
    final cartC = Get.put(KeranjangController());
    cartC.filteredData.clear();
    final dateFormatterDefault = DateFormat('d MMMM yyyy', 'id-ID');
    return Scaffold(
        backgroundColor: Colors.white,
        body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            stream: home.berandaBos(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // return const Loading();
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
                              width: 11.w,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 3.h),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 8.sp),
                          child: Container(
                            decoration: BoxDecoration(
                                color: HexColor("#0B0C2B"),
                                borderRadius: BorderRadius.circular(18.sp)),
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
                          icon: Icon(
                            PhosphorIcons.slidersHorizontal,
                            color: bluePrimary,
                          ),
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
                                      if ((value as PickerDateRange).endDate !=
                                          null) {
                                        controller.pickRangeDate(
                                            value.startDate!, value.endDate!);
                                        Get.back();
                                      } else {
                                        Get.dialog(Dialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(18.sp)),
                                          backgroundColor: bluePrimary,
                                          child: Container(
                                            width: 50.w,
                                            height: 68.h,
                                            child: Column(
                                              children: [
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 5.h),
                                                    child: Lottie.asset(
                                                        'assets/animation/alert.json')),
                                                SizedBox(
                                                  height: 3.h,
                                                ),
                                                Text(
                                                  "Terjadi Kesalahan!",
                                                  style: TextStyle(
                                                    fontSize: 20.sp,
                                                    color: white,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 1.5.h,
                                                ),
                                                Text(
                                                  "Pilih tanggal jangkauan\n(Senin-Sabtu, dsb)\n(tekan tanggal dua kali \nuntuk memilih tanggal yang sama)",
                                                  style: TextStyle(
                                                    fontSize: 15.sp,
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
                                                BorderRadius.circular(18.sp)),
                                        backgroundColor: grey1,
                                        child: Container(
                                          width: 55.w,
                                          height: 28.h,
                                          child: Column(
                                            children: [
                                              Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 2.h),
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
                    StreamBuilder<List<DocumentSnapshot<Map<String, dynamic>>>>(
                        stream: cartC.cart(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (snapshot.data == null ||
                              snapshot.data!.length == 0) {
                            return Padding(
                              padding: EdgeInsets.only(top: 33.h),
                              child: Center(
                                child: Column(
                                  children: [
                                    Lottie.asset('assets/animation/noData.json',
                                        width: 28.w),
                                    Text(
                                      "Belum Ada Pesanan",
                                      style: TextStyle(
                                          fontSize: 10.sp,
                                          color: redError,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }

                          cartC.allData.assignAll(snapshot.data!);
                          return Obx(
                            () => ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                padding:
                                    EdgeInsets.only(top: 1.5.h, bottom: 1.5.h),
                                itemCount: cartC.filteredData.isEmpty
                                    ? cartC.allData.length
                                    : cartC.filteredData.length,
                                itemBuilder: (context, index) {
                                  var data = cartC.filteredData.isEmpty
                                      ? cartC.allData[index].data()!
                                      : cartC.filteredData[index].data()!;

                                  return Padding(
                                    padding: EdgeInsets.only(bottom: 2.h),
                                    child: Material(
                                      child: InkWell(
                                        onTap: () {
                                          Get.toNamed(Routes.ITEM_PESANAN_KRY,
                                              arguments: data);
                                        },
                                        child: Container(
                                          // margin: EdgeInsets.only(left: 12, right: 12),
                                          height: 11.h,
                                          width: 304.w,
                                          decoration: BoxDecoration(
                                            color: generateRandomColor(),
                                            borderRadius:
                                                BorderRadius.circular(16.sp),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left: 0.8.w, bottom: 0.1.h),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              14.sp)),
                                                  height: 8.5.h,
                                                  width: 8.5.h,
                                                  child: Center(
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.all(1.w),
                                                      child: Icon(
                                                          PhosphorIcons
                                                              .dotsThreeOutlineFill,
                                                          size: 25.sp,
                                                          color: bluePrimary),
                                                    ),
                                                  ),
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 2.5.h, right: 5),
                                                      child: Text(data['nama'],
                                                          style: TextStyle(
                                                            fontSize: 13.sp,
                                                            color: white,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          )),
                                                    ),
                                                    SizedBox(height: 1.5.h),
                                                    Text(
                                                        '${dateFormatterDefault.format(DateTime.parse(data['date']))}',
                                                        style: TextStyle(
                                                          fontSize: 13.sp,
                                                          color: white,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        )),
                                                  ],
                                                ),
                                                SizedBox(width: 2.w),
                                                IconButton(
                                                    enableFeedback: true,
                                                    hoverColor: Colors.amber,
                                                    onPressed: () {
                                                      Get.toNamed(
                                                          Routes
                                                              .ITEM_PESANAN_KRY,
                                                          arguments: data);
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
                ),
              );
            }));
  }
}
