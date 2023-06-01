import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';

class TambahFotoController extends GetxController {
  final ketValidator = RequiredValidator(errorText: "Keterangan Harus Diisi");
  final ketKey = GlobalKey<FormState>().obs;
  final ketEdit = TextEditingController();

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
