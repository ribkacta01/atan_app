import 'package:atan_app/app/util/string.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../util/color.dart';
import '../../../util/notif.dart';

class TambahItemController extends GetxController {
  final notifC = Get.put(NotificationController());

  final namaValidator = RequiredValidator(errorText: "Nama Tidak Boleh Kosong");
  final jmlValidator = RequiredValidator(errorText: "Jumlah Harus Diisi");
  final ketValidator = RequiredValidator(errorText: "Keterangan Harus Diisi");

  final namaEdit = TextEditingController();
  final jmldit = TextEditingController();
  final kettEdit = TextEditingController();

  final nameKey = GlobalKey<FormState>().obs;
  final jmlKey = GlobalKey<FormState>().obs;
  final ketKey = GlobalKey<FormState>().obs;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addItem(
      String docName, String nama, String jumlah, String ket) async {
    try {
      var perencanaan = firestore
          .collection("Perencanaan")
          .doc(docName)
          .collection('Kebutuhan');
      var docRefItem = await perencanaan.add(
          {'Nama Barang': nama, 'Jumlah Barang': jumlah, 'Keterangan': ket});
      await docRefItem.update({'id': docRefItem.id});

      notifC.sendNotificationToAdmin(
          tambahItemTitle, tambahItemMessage, keranjangBosView);

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
                  'Item Ditambahkan!',
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
