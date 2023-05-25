import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../util/color.dart';

class ItemPesananKryController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Stream<QuerySnapshot<Map<String, dynamic>>> item(String docName) async* {
    yield* firestore
        .collection("Perencanaan")
        .doc(docName)
        .collection('Kebutuhan')
        .snapshots();
  }

  Future<void> delItem(String docName, String docNameP) async {
    Get.dialog(Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
                'Yakin Ingin Menghapus Data?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: white,
                  fontSize: 25,
                ),
              ),
              SizedBox(
                height: 3.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                      width: 15.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(11),
                          color: white),
                      child: TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: Padding(
                            padding:
                                const EdgeInsets.only(top: 11.0, bottom: 11.0),
                            child: Text(
                              'BATAL',
                              style:
                                  TextStyle(fontSize: 18, color: bluePrimary),
                            ),
                          ))),
                  Container(
                      width: 15.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(11),
                          color: white),
                      child: TextButton(
                          onPressed: () async {
                            CollectionReference perencanaan = firestore
                                .collection("Perencanaan")
                                .doc(docNameP)
                                .collection('Kebutuhan');
                            await perencanaan.doc(docName).delete();
                            Get.back();
                          },
                          child: Padding(
                            padding:
                                const EdgeInsets.only(top: 11.0, bottom: 11.0),
                            child: Text(
                              'HAPUS',
                              style:
                                  TextStyle(fontSize: 18, color: bluePrimary),
                            ),
                          ))),
                ],
              )
            ],
          ),
        )));
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
