import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
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
  ) async {
    try {
      CollectionReference users = firestore.collection("users");
      await users.doc(doc).update({
        'name': nama,
        'email': email,
      });

      Get.dialog(Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: bluePrimary,
          child: Container(
            width: 350,
            height: 336,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  PhosphorIcons.checkCircleFill,
                  color: white,
                  size: 110,
                ),
                SizedBox(
                  height: 3.h,
                ),
                Text(
                  'Data Pegawai Diubah!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: white,
                    fontSize: 25,
                  ),
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
                            style: TextStyle(fontSize: 18, color: bluePrimary),
                          ),
                        )))
              ],
            ),
          )));
    } catch (e) {
      Get.dialog(Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: bluePrimary,
        child: Container(
          width: 193.93,
          height: 194.73,
          child: Column(
            children: [
              Icon(
                PhosphorIcons.xCircle,
                color: white,
              ),
              Text("$e")
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
