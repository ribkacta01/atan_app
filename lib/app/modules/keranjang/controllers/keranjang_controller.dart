import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../util/color.dart';

class KeranjangController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> cart() async* {
    yield* firestore
        .collection("Perencanaan")
        .orderBy('date', descending: false)
        .snapshots();

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

  Future<void> delData(String docName) async {
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
                PhosphorIcons.question,
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
                      width: 20.w,
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
                      width: 20.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(11),
                          color: white),
                      child: TextButton(
                          onPressed: () async {
                            CollectionReference users =
                                firestore.collection("Perencanaan");
                            await users.doc(docName).delete();
                            // Get.dialog(Dialog(
                            //   child: Container(
                            //     width: 350,
                            //     height: 336,
                            //     child: Column(
                            //       mainAxisAlignment: MainAxisAlignment.center,
                            //       children: [
                            //         Icon(
                            //           PhosphorIcons.checkCircleFill,
                            //           color: white,
                            //           size: 110,
                            //         ),
                            //         SizedBox(
                            //           height: 3.h,
                            //         ),
                            //         Text(
                            //           'Data Berhasil Dihapus',
                            //           textAlign: TextAlign.center,
                            //           style: TextStyle(
                            //             color: white,
                            //             fontSize: 25,
                            //           ),
                            //         ),
                            //       ],
                            //     ),
                            //   ),
                            // ));
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
}
