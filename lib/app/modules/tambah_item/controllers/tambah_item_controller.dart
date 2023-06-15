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
      CollectionReference perencanaan = firestore
          .collection("Perencanaan")
          .doc(docName)
          .collection('Kebutuhan');
      await perencanaan.doc(nama + ' - ' + ket).set(
          {'Nama Barang': nama, 'Jumlah Barang': jumlah, 'Keterangan': ket});

      notifC.sendNotificationToAdmin(
          tambahItemTitle, tambahItemMessage, keranjangBosView);

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
                  'Item Ditambahkan!',
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
          width: 193.93,
          height: 194.73,
          child: Column(
            children: [
              Lottie.asset('assets/animation/failed.json', height: 140),
              SizedBox(
                height: 3.h,
              ),
              Text(
                'Gagal Menambahkan Item',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: bluePrimary,
                    fontSize: 25,
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
