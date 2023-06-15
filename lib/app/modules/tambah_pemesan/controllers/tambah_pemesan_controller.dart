// ignore_for_file: unused_import

import 'package:atan_app/app/util/color.dart';
import 'package:atan_app/app/util/string.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart' show DateFormat;

import '../../../../main.dart';
import '../../../util/notif.dart';

class TambahPemesanController extends GetxController {
  final namaValidator = RequiredValidator(errorText: "Nama Tidak Boleh Kosong");
  final dateValidator = RequiredValidator(errorText: "Tanggal Harus Diisi");
  final tenggatValidator = RequiredValidator(errorText: "Tanggal Harus Diisi");

  final namaEdit = TextEditingController();
  final dateEdit = TextEditingController();
  final tenggatEdit = TextEditingController();

  final nameKey = GlobalKey<FormState>().obs;
  final dateKey = GlobalKey<FormState>().obs;
  final tenggatKey = GlobalKey<FormState>().obs;

  final notifC = Get.put(NotificationController());

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  final selectedDate = DateTime.now().obs;
  final dateFormatter = DateFormat('d MMMM yyyy', 'id-ID');
  final dateFormatterDefault = DateFormat('yyyy-MM-dd');
  var datePesan = ''.obs;
  var dateTenggat = ''.obs;

  DateRangePickerController datePesanController = DateRangePickerController();
  DateRangePickerController dateTenggatController = DateRangePickerController();

  Future<void> addPemesan(String nama) async {
    try {
      CollectionReference perencanaan = firestore.collection("Perencanaan");

      await perencanaan
          .doc(
              '$nama - ${dateFormatter.format(DateTime.parse(datePesan.value))}')
          .set({
        'date': datePesan.value,
        'nama': nama,
        'tenggat': dateTenggat.value
      });

      notifC.sendNotificationToAllUser(
          tambahPemesanTitle, tambahPemesanMessage, keranjangView);

      Get.dialog(Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.sp)),
          backgroundColor: grey1,
          child: Container(
            width: 68.w,
            height: 32.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset('assets/animation/check.json', width: 28.w),
                SizedBox(
                  height: 3.h,
                ),
                Text(
                  'Pesanan Berhasil Ditambahkan!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: bluePrimary,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 3.h,
                ),
                Container(
                    width: 15.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.sp),
                        color: white),
                    child: TextButton(
                        onPressed: () {
                          Get.back();
                          Get.back();
                        },
                        child: Padding(
                          padding: EdgeInsets.only(top: 1.h, bottom: 1.h),
                          child: Text(
                            'OK',
                            style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                                color: bluePrimary),
                          ),
                        )))
              ],
            ),
          )));
    } catch (e) {
      Get.dialog(Dialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.sp)),
        backgroundColor: grey1,
        child: Container(
          width: 68.w,
          height: 32.h,
          child: Column(
            children: [
              Lottie.asset('assets/animation/failed.json', width: 28.w),
              SizedBox(
                height: 3.h,
              ),
              Text(
                'Gagal Menambahkan Item',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: bluePrimary,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ));
    }
  }

  void selectDatePesan(DateRangePickerSelectionChangedArgs args) {
    selectedDate.value = args.value;
    final dateFormatted = dateFormatter.format(selectedDate.value);
    datePesan.value = dateFormatterDefault.format(selectedDate.value);
    dateEdit.text = dateFormatted.toString();
  }

  void selectDateTenggat(DateRangePickerSelectionChangedArgs args) {
    selectedDate.value = args.value;
    final dateFormatted = dateFormatter.format(selectedDate.value);
    dateTenggat.value = dateFormatterDefault.format(selectedDate.value);
    tenggatEdit.text = dateFormatted.toString();
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
