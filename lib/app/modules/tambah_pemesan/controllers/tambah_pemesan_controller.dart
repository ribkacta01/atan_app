import 'package:atan_app/app/util/color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart' show DateFormat;

class TambahPemesanController extends GetxController {
  final namaValidator = RequiredValidator(errorText: "Nama Tidak Boleh Kosong");
  final dateValidator = RequiredValidator(errorText: "Tanggal Harus Diisi");
  final tenggatValidator = RequiredValidator(errorText: "Tanggal Harus Diisi");

  final namaEdit = TextEditingController();
  final dateEdit = TextEditingController();
  final tenggatEdit = TextEditingController();

  final nameKey = GlobalKey<FormState>().obs;
  final dateKey = GlobalKey<FormState>().obs;
  final tenggatKey = GlobalKey<FormState>().obs;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  final selectedDate = DateTime.now().obs;
  final dateFormatter = DateFormat('d MMMM yyyy', 'id-ID');

  DateRangePickerController datePesanController = DateRangePickerController();
  DateRangePickerController dateTenggatController = DateRangePickerController();

  Future<void> addPemesan(
      String nama, String datePesan, String dateTenggat) async {
    try {
      CollectionReference perencanaan = firestore.collection("Perencanaan");
      await perencanaan
          .doc(nama + ' - ' + datePesan)
          .set({'date': datePesan, 'nama': nama, 'tenggat': dateTenggat});

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
                  'Data Pemesan Disimpan!',
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

  void selectDatePesan(DateRangePickerSelectionChangedArgs args) {
    selectedDate.value = args.value;
    final dateFormatted = dateFormatter.format(selectedDate.value);
    dateEdit.text = dateFormatted.toString();
  }

  void selectDateTenggat(DateRangePickerSelectionChangedArgs args) {
    selectedDate.value = args.value;
    final dateFormatted = dateFormatter.format(selectedDate.value);
    tenggatEdit.text = dateFormatted.toString();
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
