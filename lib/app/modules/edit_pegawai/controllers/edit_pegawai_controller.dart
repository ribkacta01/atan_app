import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../util/color.dart';

class EditPegawaiController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  final namaKey = GlobalKey<FormState>().obs;
  final emailKey = GlobalKey<FormState>().obs;
  final divKey = GlobalKey<FormState>().obs;
  final genderKey = GlobalKey<FormState>().obs;

  final namaValidator = RequiredValidator(errorText: "Nama Tidak Boleh Kosong");
  final emailValidator = MultiValidator([
    RequiredValidator(errorText: "Email Tidak Boleh Kosong"),
    EmailValidator(errorText: "Email Tidak Valid")
  ]);
  final divisiValidator = RequiredValidator(errorText: "Divisi Harus Diisi");
  final genderValidator =
      RequiredValidator(errorText: "Jenis Kelamin Harus Diisi");

  final namaEdit = TextEditingController();
  final emailEdit = TextEditingController();
  final divEdit = TextEditingController();
  final genderEdit = TextEditingController();

  Future<void> editPeg(
    String doc,
    String nama,
    String email,
    String divisi,
  ) async {
    try {
      CollectionReference users = firestore.collection("users");
      await users.doc(doc).update({
        'name': nama,
        'email': email,
        'divisi': divisi,
      });

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
                  'Data Pegawai Ditambahkan!',
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
                'Terjadi Kesalahan!',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: bluePrimary,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                'Tidak Dapat Menghapus Data',
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
