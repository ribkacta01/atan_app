import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../util/color.dart';

class TambahTugasController extends GetxController {
  final namaValidator = RequiredValidator(errorText: "Nama Tidak Boleh Kosong");
  final dateValidator = RequiredValidator(errorText: "Tanggal Harus Diisi");
  final divisiValidator = RequiredValidator(errorText: "Divisi Harus Diisi");
  final ketValidator = RequiredValidator(errorText: "Keterangan Harus Diisi");

  final namaEdit = TextEditingController();
  final dateEdit = TextEditingController();
  final divEdit = TextEditingController();
  final ketEdit = TextEditingController();

  final nameKey = GlobalKey<FormState>().obs;
  final dateKey = GlobalKey<FormState>().obs;
  final divKey = GlobalKey<FormState>().obs;
  final ketKey = GlobalKey<FormState>().obs;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  final selectedDate = DateTime.now().obs;
  final dateFormatter = DateFormat('d MMMM yyyy', 'id-ID');

  DateRangePickerController datePesanController = DateRangePickerController();

  Future<void> addTugas(
      String nama, String datePesan, String divisi, String ket) async {
    try {
      CollectionReference tugas = firestore.collection("Tugas");
      tugas.doc().set({
        'Tanggal Pesan': datePesan,
        'Nama Pemesan': nama,
        'Divisi': divisi,
        'Keterangan': ket,
        'Status': 'Belum Selesai',
        'photo': '',
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
                  'Tugas Terkirim!',
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
