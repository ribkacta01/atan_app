import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class TugasController extends GetxController {
  final picker = ImagePicker();
  final storage = FirebaseStorage.instance;
  final firestore = FirebaseFirestore.instance;

  Future<void> uploadImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      final file = File(pickedFile.path);
      final fileName = path.basename(file.path);

      try {
        final uploadTask = storage.ref().child(fileName).putFile(file);
        final snapshot = await uploadTask.whenComplete(() {});
        final downloadURL = await snapshot.ref.getDownloadURL();

        await saveImageUrlToFirestore(downloadURL);

        Get.snackbar('Sukses', 'Foto berhasil diupload');
      } catch (e) {
        Get.snackbar('Error', 'Gagal mengupload foto');
        print(e);
      }
    }
  }

  Future<void> saveImageUrlToFirestore(String imageUrl) async {
    try {
      await firestore.collection('images').add({
        'url': imageUrl,
        'timestamp': FieldValue.serverTimestamp(),
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
