import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../util/color.dart';

class TambahPegawaiController extends GetxController {
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

  final namaKey = GlobalKey<FormState>().obs;
  final emailKey = GlobalKey<FormState>().obs;
  final divKey = GlobalKey<FormState>().obs;
  final genderKey = GlobalKey<FormState>().obs;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addPegawai(
      String nama, String email, String divisi, String gender) async {
    try {
      CollectionReference users = firestore.collection("users");
      await users.doc(email).set({
        'name': nama,
        'email': email,
        'divisi': divisi,
        'gender': gender,
        'status': 'true',
        'photoUrl': '',
        'lastSignInTime': '',
        'updatedTime': DateTime.now().toIso8601String(),
        'creationTime': DateTime.now().toIso8601String(),
        'uid': '',
        'roles': 'user'
      });

      Get.dialog(Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: grey1,
          child: Container(
            width: 350,
            height: 336,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset('assets/animation/check.json', height: 140),
                SizedBox(
                  height: 3.h,
                ),
                Text(
                  'Data Pegawai Disimpan!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: bluePrimary,
                      fontSize: 25,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 3.h,
                ),
                Container(
                    width: 15.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(11), color: white),
                    child: TextButton(
                        onPressed: () {
                          Get.back();
                          Get.back();
                        },
                        child: Padding(
                          padding:
                              const EdgeInsets.only(top: 11.0, bottom: 11.0),
                          child: Text(
                            'OK',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: bluePrimary),
                          ),
                        )))
              ],
            ),
          )));
    } catch (e) {
      Get.dialog(Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: grey1,
        child: Container(
          width: 350,
          height: 336,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child:
                    Lottie.asset('assets/animation/failed.json', height: 140),
              ),
              SizedBox(
                height: 3.h,
              ),
              Text(
                "Terjadi Kesalahan!",
                style: TextStyle(
                  fontSize: 30,
                  color: bluePrimary,
                ),
              ),
              SizedBox(
                height: 1.5.h,
              ),
              Text(
                "Tidak Dapat Menambah Data",
                style: TextStyle(
                  fontSize: 20,
                  color: bluePrimary,
                ),
              ),
            ],
          ),
        ),
      ));
    }
  }

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
}
