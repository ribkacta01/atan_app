import 'package:atan_app/app/controller/auth_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lottie/lottie.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../util/color.dart';
import '../controllers/tambah_pemesan_controller.dart';

class TambahPemesanView extends GetView<TambahPemesanController> {
  const TambahPemesanView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final authC = Get.put(AuthController());
    final addOrderC = Get.put(TambahPemesanController());
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
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
                            icon: Icon(PhosphorIcons.arrowLeft)),
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
                              padding: const EdgeInsets.only(right: 5),
                              child: ClipOval(
                                child: Image.network(
                                  data.get('photoUrl'),
                                  width: 10.w,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.h),
                        Padding(
                          padding: EdgeInsets.only(left: 3.w),
                          child: Text(
                            "Tambahkan Daftar Pesanan",
                            style: TextStyle(
                              fontSize: 15.sp,
                              color: HexColor("#0B0C2B"),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Center(
                            child: Column(children: [
                          Form(
                              key: addOrderC.nameKey.value,
                              child: Container(
                                height: 7.h,
                                width: 82.w,
                                child: TextFormField(
                                  controller: addOrderC.namaEdit,
                                  decoration: InputDecoration(
                                    fillColor: HexColor("#BFC0D2"),
                                    filled: true,
                                    errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(
                                            color: HexColor("#FF0000"))),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(color: grey2)),
                                    hintText: "Nama Pemesan",
                                    errorStyle: TextStyle(
                                        color: Colors.white,
                                        background: Paint()
                                          ..strokeWidth = 16
                                          ..color = HexColor("#FF0000")
                                          ..style = PaintingStyle.stroke
                                          ..strokeJoin = StrokeJoin.round),
                                    helperText: ' ',
                                  ),
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: addOrderC.namaValidator,
                                ),
                              )),
                          SizedBox(
                            height: 2.5.h,
                          ),
                          Form(
                              key: addOrderC.dateKey.value,
                              child: Container(
                                height: 7.h,
                                width: 82.w,
                                child: TextFormField(
                                  readOnly: true,
                                  controller: addOrderC.selectedDate.value
                                          .isAtSameMomentAs(DateTime.now())
                                      ? TextEditingController(text: '')
                                      : addOrderC.dateEdit,
                                  decoration: InputDecoration(
                                    suffixIcon: Padding(
                                      padding: EdgeInsets.only(right: 3.w),
                                      child: IconButton(
                                        onPressed: () {
                                          Get.dialog(Dialog(
                                            child: Container(
                                              padding: EdgeInsets.all(1.h),
                                              height: 40.h,
                                              child: SfDateRangePicker(
                                                view: DateRangePickerView.month,
                                                selectionMode:
                                                    DateRangePickerSelectionMode
                                                        .single,
                                                showActionButtons: true,
                                                onCancel: () => Get.back(),
                                                onSelectionChanged:
                                                    addOrderC.selectDatePesan,
                                                controller: addOrderC
                                                    .datePesanController,
                                                onSubmit: (value) {
                                                  if (value != null) {
                                                    addOrderC.selectDatePesan;
                                                    Get.back();
                                                  }
                                                },
                                              ),
                                            ),
                                          ));
                                        },
                                        icon: Icon(PhosphorIcons.calendar),
                                        color: HexColor("#0B0C2B"),
                                      ),
                                    ),
                                    fillColor: HexColor("#BFC0D2"),
                                    filled: true,
                                    errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(
                                            color: HexColor("#FF0000"))),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(
                                            color: HexColor("#5B5B6E"),
                                            width: 2)),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(
                                            color: HexColor("#BFC0D2"))),
                                    hintText: "Pilih Tanggal Pesanan",
                                    errorStyle: TextStyle(
                                        color: Colors.white,
                                        background: Paint()
                                          ..strokeWidth = 16
                                          ..color = HexColor("#FF0000")
                                          ..style = PaintingStyle.stroke
                                          ..strokeJoin = StrokeJoin.round),
                                    helperText: ' ',
                                  ),
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: addOrderC.dateValidator,
                                ),
                              )),
                          SizedBox(
                            height: 2.5.h,
                          ),
                          Center(
                            child: Column(children: [
                              Form(
                                  key: addOrderC.tenggatKey.value,
                                  child: Container(
                                    height: 7.h,
                                    width: 82.w,
                                    child: TextFormField(
                                      readOnly: true,
                                      controller: addOrderC.selectedDate.value
                                              .isAtSameMomentAs(DateTime.now())
                                          ? TextEditingController(text: '')
                                          : addOrderC.tenggatEdit,
                                      decoration: InputDecoration(
                                        suffixIcon: Padding(
                                          padding: EdgeInsets.only(right: 3.w),
                                          child: IconButton(
                                            onPressed: () {
                                              Get.dialog(Dialog(
                                                child: Container(
                                                  padding: EdgeInsets.all(1.h),
                                                  height: 40.h,
                                                  child: SfDateRangePicker(
                                                    view: DateRangePickerView
                                                        .month,
                                                    selectionMode:
                                                        DateRangePickerSelectionMode
                                                            .single,
                                                    showActionButtons: true,
                                                    onSelectionChanged:
                                                        addOrderC
                                                            .selectDateTenggat,
                                                    controller: addOrderC
                                                        .dateTenggatController,
                                                    onCancel: () => Get.back(),
                                                    onSubmit: (value) {
                                                      if (value != null) {
                                                        addOrderC
                                                            .selectDateTenggat;
                                                        Get.back();
                                                      }
                                                    },
                                                  ),
                                                ),
                                              ));
                                            },
                                            icon: Icon(PhosphorIcons.calendar),
                                            color: HexColor("#0B0C2B"),
                                          ),
                                        ),
                                        fillColor: HexColor("#BFC0D2"),
                                        filled: true,
                                        errorBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            borderSide: BorderSide(
                                                color: HexColor("#FF0000"))),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            borderSide: BorderSide(
                                                color: HexColor("#5B5B6E"),
                                                width: 2)),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            borderSide: BorderSide(
                                                color: HexColor("#BFC0D2"))),
                                        hintText: "Tenggat  Pesanan",
                                        errorStyle: TextStyle(
                                            color: Colors.white,
                                            background: Paint()
                                              ..strokeWidth = 16
                                              ..color = HexColor("#FF0000")
                                              ..style = PaintingStyle.stroke
                                              ..strokeJoin = StrokeJoin.round),
                                        helperText: ' ',
                                      ),
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      validator: addOrderC.tenggatValidator,
                                    ),
                                  )),
                              SizedBox(
                                height: 3.h,
                              ),
                              Container(
                                height: 4.5.h,
                                width: 45.w,
                                decoration: BoxDecoration(
                                    color: HexColor("#0B0C2B"),
                                    borderRadius: BorderRadius.circular(10)),
                                child: TextButton(
                                  onPressed: () {
                                    if (addOrderC.nameKey.value.currentState!.validate() &&
                                        addOrderC.dateKey.value.currentState!
                                            .validate() &&
                                        addOrderC.tenggatKey.value.currentState!
                                            .validate()) {
                                      addOrderC.addPemesan(
                                        addOrderC.namaEdit.text,
                                      );
                                    }
                                  },
                                  child: Text(
                                    "Simpan",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 12.sp),
                                  ),
                                ),
                              ),
                            ]),
                          )
                        ]))
                      ]);
                })));
  }
}
