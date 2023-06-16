import 'package:atan_app/app/controller/auth_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lottie/lottie.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../util/color.dart';
import '../controllers/tambah_tugas_controller.dart';

class TambahTugasView extends GetView<TambahTugasController> {
  const TambahTugasView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final authC = Get.put(AuthController());
    final tambahC = Get.put(TambahTugasController());
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
                                    "Tambahkan Pekerjaan Pegawai ",
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
                                  width: 11.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 6.h),
                        Padding(
                          padding: EdgeInsets.only(left: 3.w),
                          child: Text(
                            "Berikan Tugas",
                            style: TextStyle(
                              fontSize: 18.sp,
                              color: HexColor("#0B0C2B"),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(height: 1.5.h),
                        Center(
                          child: Column(
                            children: [
                              Form(
                                  key: tambahC.nameKey.value,
                                  child: Container(
                                    height: 7.h,
                                    width: 82.w,
                                    child: DropdownSearch<String>(
                                      clearButtonProps: ClearButtonProps(
                                          isVisible: true, color: bluePrimary),
                                      items: tambahC.listTUgas,
                                      onChanged: (value) {
                                        if (value != null) {
                                          tambahC.namaEdit.text = value;
                                        }
                                      },
                                      dropdownDecoratorProps:
                                          DropDownDecoratorProps(
                                        dropdownSearchDecoration:
                                            InputDecoration(
                                          fillColor: grey1,
                                          filled: true,
                                          hintText: "Nama Pemesan",
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              borderSide: BorderSide(
                                                  width: 1,
                                                  color: HexColor("#5B5B6E"))),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              borderSide: BorderSide(
                                                  width: 1, color: grey2)),
                                        ),
                                      ),
                                      popupProps: PopupProps.menu(
                                          showSearchBox: true,
                                          fit: FlexFit.loose,
                                          menuProps: MenuProps(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            backgroundColor: Colors.transparent,
                                            elevation: 0,
                                          ),
                                          containerBuilder:
                                              (context, popupWidget) {
                                            return Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        bottom: 1.h)),
                                                Flexible(
                                                    child: Container(
                                                  child: popupWidget,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                      border: Border.all(
                                                        color:
                                                            HexColor("#BFC0D2"),
                                                        width: 0.3.w,
                                                      )),
                                                ))
                                              ],
                                            );
                                          },
                                          scrollbarProps: const ScrollbarProps(
                                              trackVisibility: true,
                                              trackColor: Colors.black),
                                          constraints: BoxConstraints(
                                            maxHeight: 20.h,
                                          )),
                                    ),
                                  )),
                              SizedBox(height: 1.5.h),
                              Center(
                                  child: Column(
                                children: [
                                  Form(
                                      key: tambahC.dateKey.value,
                                      child: Container(
                                        height: 7.h,
                                        width: 82.w,
                                        child: TextFormField(
                                          readOnly: true,
                                          controller: tambahC.selectedDate.value
                                                  .isAtSameMomentAs(
                                                      DateTime.now())
                                              ? TextEditingController(text: '')
                                              : tambahC.dateEdit,
                                          decoration: InputDecoration(
                                            suffixIcon: Padding(
                                              padding:
                                                  EdgeInsets.only(right: 3.w),
                                              child: IconButton(
                                                onPressed: () {
                                                  Get.dialog(Dialog(
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.all(1.h),
                                                      height: 40.h,
                                                      child: SfDateRangePicker(
                                                        view:
                                                            DateRangePickerView
                                                                .month,
                                                        selectionMode:
                                                            DateRangePickerSelectionMode
                                                                .single,
                                                        showActionButtons: true,
                                                        onCancel: () =>
                                                            Get.back(),
                                                        onSelectionChanged:
                                                            tambahC
                                                                .selectDatePesan,
                                                        controller: tambahC
                                                            .datePesanController,
                                                        onSubmit: (value) {
                                                          if (value != null) {
                                                            tambahC
                                                                .selectDatePesan;
                                                            Get.back();
                                                          }
                                                        },
                                                      ),
                                                    ),
                                                  ));
                                                },
                                                icon: const Icon(
                                                    PhosphorIcons.calendar),
                                                color: HexColor("#0B0C2B"),
                                              ),
                                            ),
                                            fillColor: HexColor("#BFC0D2"),
                                            filled: true,
                                            errorBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                borderSide: BorderSide(
                                                    color:
                                                        HexColor("#FF0000"))),
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
                                                    color:
                                                        HexColor("#BFC0D2"))),
                                            hintText: "Pilih Tanggal Pesanan",
                                            errorStyle: TextStyle(
                                                color: Colors.white,
                                                background: Paint()
                                                  ..strokeWidth = 16
                                                  ..color = HexColor("#FF0000")
                                                  ..style = PaintingStyle.stroke
                                                  ..strokeJoin =
                                                      StrokeJoin.round),
                                            helperText: ' ',
                                          ),
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          validator: tambahC.dateValidator,
                                        ),
                                      )),
                                  SizedBox(height: 1.5.h),
                                  Form(
                                      key: tambahC.tenggatKey.value,
                                      child: Container(
                                        height: 7.h,
                                        width: 82.w,
                                        child: TextFormField(
                                          readOnly: true,
                                          controller: tambahC.selectedDate.value
                                                  .isAtSameMomentAs(
                                                      DateTime.now())
                                              ? TextEditingController(text: '')
                                              : tambahC.tenggatEdit,
                                          decoration: InputDecoration(
                                            suffixIcon: Padding(
                                              padding:
                                                  EdgeInsets.only(right: 3.w),
                                              child: IconButton(
                                                onPressed: () {
                                                  Get.dialog(Dialog(
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.all(1.h),
                                                      height: 40.h,
                                                      child: SfDateRangePicker(
                                                        view:
                                                            DateRangePickerView
                                                                .month,
                                                        selectionMode:
                                                            DateRangePickerSelectionMode
                                                                .single,
                                                        showActionButtons: true,
                                                        onCancel: () =>
                                                            Get.back(),
                                                        onSelectionChanged: tambahC
                                                            .selectDateTenggat,
                                                        controller: tambahC
                                                            .datePesanController,
                                                        onSubmit: (value) {
                                                          if (value != null) {
                                                            tambahC
                                                                .selectDateTenggat;
                                                            Get.back();
                                                          }
                                                        },
                                                      ),
                                                    ),
                                                  ));
                                                },
                                                icon: const Icon(
                                                    PhosphorIcons.calendar),
                                                color: HexColor("#0B0C2B"),
                                              ),
                                            ),
                                            fillColor: HexColor("#BFC0D2"),
                                            filled: true,
                                            errorBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                borderSide: BorderSide(
                                                    color:
                                                        HexColor("#FF0000"))),
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
                                                    color:
                                                        HexColor("#BFC0D2"))),
                                            hintText: "Pilih Tenggat Tugas",
                                            errorStyle: TextStyle(
                                                color: Colors.white,
                                                background: Paint()
                                                  ..strokeWidth = 16
                                                  ..color = HexColor("#FF0000")
                                                  ..style = PaintingStyle.stroke
                                                  ..strokeJoin =
                                                      StrokeJoin.round),
                                            helperText: ' ',
                                          ),
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          validator: tambahC.tenggatValidator,
                                        ),
                                      )),
                                  SizedBox(height: 1.5.h),
                                  Form(
                                      key: tambahC.divKey.value,
                                      child: Container(
                                        height: 7.h,
                                        width: 82.w,
                                        child: DropdownSearch<String>(
                                          clearButtonProps: ClearButtonProps(
                                              isVisible: true,
                                              color: bluePrimary),
                                          items: const [
                                            'Divisi Jahit',
                                            'Divisi Cetak',
                                            'Divisi Desain',
                                            'Divisi QA & Packing'
                                          ],
                                          onChanged: (value) {
                                            if (value != null) {
                                              tambahC.divEdit.text = value;
                                            }
                                          },
                                          dropdownDecoratorProps:
                                              DropDownDecoratorProps(
                                            dropdownSearchDecoration:
                                                InputDecoration(
                                              fillColor: grey1,
                                              filled: true,
                                              hintText: "Nama Divisi",
                                              focusedBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  borderSide: BorderSide(
                                                      width: 1,
                                                      color:
                                                          HexColor("#5B5B6E"))),
                                              enabledBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  borderSide: BorderSide(
                                                      width: 1, color: grey2)),
                                            ),
                                          ),
                                          popupProps: PopupProps.menu(
                                              fit: FlexFit.loose,
                                              menuProps: MenuProps(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                backgroundColor:
                                                    Colors.transparent,
                                                elevation: 0,
                                              ),
                                              containerBuilder:
                                                  (context, popupWidget) {
                                                return Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                bottom: 1.h)),
                                                    Flexible(
                                                        child: Container(
                                                      child: popupWidget,
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(12),
                                                          border: Border.all(
                                                            color: HexColor(
                                                                "#BFC0D2"),
                                                            width: 0.3.w,
                                                          )),
                                                    ))
                                                  ],
                                                );
                                              },
                                              scrollbarProps:
                                                  const ScrollbarProps(
                                                      trackVisibility: true,
                                                      trackColor: Colors.black),
                                              constraints: BoxConstraints(
                                                maxHeight: 20.h,
                                              )),
                                        ),
                                      )),
                                  SizedBox(height: 1.5.h),
                                  Form(
                                    key: tambahC.ketKey.value,
                                    child: Container(
                                      height: 7.h,
                                      width: 82.w,
                                      child: TextFormField(
                                        controller: tambahC.ketEdit,
                                        decoration: InputDecoration(
                                          fillColor: HexColor("#BFC0D2"),
                                          filled: true,
                                          errorBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              borderSide: BorderSide(
                                                  color: HexColor("#FF0000"))),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              borderSide: BorderSide(
                                                  color: HexColor("#BFC0D2"))),
                                          hintText: "Tambah Keterangan",
                                          errorStyle: TextStyle(
                                              color: Colors.white,
                                              background: Paint()
                                                ..strokeWidth = 16
                                                ..color = HexColor("#FF0000")
                                                ..style = PaintingStyle.stroke
                                                ..strokeJoin =
                                                    StrokeJoin.round),
                                          helperText: ' ',
                                        ),
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        validator: tambahC.ketValidator,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 2.5.h,
                                  ),
                                  Container(
                                    height: 4.5.h,
                                    width: 45.w,
                                    decoration: BoxDecoration(
                                        color: HexColor("#0B0C2B"),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: TextButton(
                                      onPressed: () {
                                        if (tambahC.nameKey.value.currentState!.validate() &&
                                            tambahC.dateKey.value.currentState!
                                                .validate() &&
                                            tambahC.divKey.value.currentState!
                                                .validate() &&
                                            tambahC.ketKey.value.currentState!
                                                .validate()) {
                                          tambahC.addTugas(
                                              tambahC.namaEdit.text,
                                              tambahC.divEdit.text,
                                              tambahC.ketEdit.text);
                                        }
                                      },
                                      child: Text(
                                        "Simpan",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12.sp),
                                      ),
                                    ),
                                  ),
                                ],
                              ))
                            ],
                          ),
                        ),
                      ]);
                })));
  }
}
