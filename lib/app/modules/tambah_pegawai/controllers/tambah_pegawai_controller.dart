import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
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
                  'Data Pegawai Disimpan!',
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
