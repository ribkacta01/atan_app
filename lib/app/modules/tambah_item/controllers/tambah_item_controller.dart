import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';

class TambahItemController extends GetxController {
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
