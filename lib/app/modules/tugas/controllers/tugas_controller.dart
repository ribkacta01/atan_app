import 'dart:io';

import 'package:atan_app/app/routes/app_pages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:path/path.dart' as path;
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart' show DateFormat;

import '../../../util/color.dart';

class TugasController extends GetxController {
  final picker = ImagePicker();
  final storage = FirebaseStorage.instance;
  final firestore = FirebaseFirestore.instance;

  RxBool isButtonDisabled = false.obs;
  RxSet<int> disabledIndexes = <int>{}.obs;

  void disableIconButton(int index) {
    disabledIndexes.add(index);
  }

  void enableIconButton(int index) {
    disabledIndexes.remove(index);
  }

  Rx<XFile?> filePath = Rx<XFile?>(null);

  Future<void> uploadImage(String id) async {
    if (disabledIndexes.isNotEmpty) {
      final pickedFile =
          await picker.pickImage(source: ImageSource.camera, imageQuality: 75);
      filePath.value = pickedFile;

      if (pickedFile != null) {
        final file = File(pickedFile.path);
        final fileName = path.basename(file.path);

        Get.toNamed(Routes.TAMBAH_FOTO, arguments: id);
      }
    }
  }

  Future<void> simpanFoto(String id, String detail) async {
    if (filePath.value != null) {
      final file = File(filePath.value!.path);
      final fileName = path.basename(file.path);

      try {
        final uploadTask = storage.ref().child(fileName).putFile(file);
        final snapshot = await uploadTask.whenComplete(() {});
        final downloadURL = await snapshot.ref.getDownloadURL();

        await saveImageUrlToFirestore(id, downloadURL, detail);

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
                    'Foto Berhasil Diunggah!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: bluePrimary,
                        fontSize: 25,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  Container(
                      width: 15.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(11),
                          color: white),
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
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
                  "Tidak Dapat Mengunggah Foto",
                  style: TextStyle(
                    fontSize: 20,
                    color: bluePrimary,
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
              ],
            ),
          ),
        ));
      }
    }
  }

  Future<void> saveImageUrlToFirestore(
      String id, String imageUrl, String detail) async {
    try {
      DateTime now = DateTime.now();
      String formattedDate = DateFormat('yyyy/MM/dd').format(now);
      await firestore.collection('Tugas').doc(id).update({
        'photo': imageUrl,
        'photoDateTime': formattedDate,
        'detail': detail,
      });
    } catch (e) {
      print(e);
    }
  }

  // void pickImage() async {
  //   final XFile? image = await picker.pickImage(source: ImageSource.camera);
  //   if (image != null) {
  //     print(image.name);
  //   } else {
  //     print(image);
  //   }
  // }

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
