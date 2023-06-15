import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../util/color.dart';
import '../../../util/notif.dart';
import '../../../util/string.dart';

class TambahTugasController extends GetxController {
  final namaValidator = RequiredValidator(errorText: "Nama Tidak Boleh Kosong");
  final dateValidator = RequiredValidator(errorText: "Tanggal Harus Diisi");
  final tenggatValidator = RequiredValidator(errorText: "Tanggal Harus Diisi");
  final divisiValidator = RequiredValidator(errorText: "Divisi Harus Diisi");
  final ketValidator = RequiredValidator(errorText: "Keterangan Harus Diisi");

  final namaEdit = TextEditingController();
  final dateEdit = TextEditingController();
  final tenggatEdit = TextEditingController();
  final divEdit = TextEditingController();
  final ketEdit = TextEditingController();

  final nameKey = GlobalKey<FormState>().obs;
  final dateKey = GlobalKey<FormState>().obs;
  final tenggatKey = GlobalKey<FormState>().obs;
  final divKey = GlobalKey<FormState>().obs;
  final ketKey = GlobalKey<FormState>().obs;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  final selectedDate = DateTime.now().obs;
  final dateFormatter = DateFormat('d MMMM yyyy', 'id-ID');
  final dateFormatterDefault = DateFormat('yyyy-MM-dd');
  var datePesan = ''.obs;
  var dateTenggat = ''.obs;

  DateRangePickerController datePesanController = DateRangePickerController();
  DateRangePickerController dateTenggatController = DateRangePickerController();

  // final CollectionReference<Map<String, dynamic>> collection =
  //     FirebaseFirestore.instance.collection('Tugas');

  var listTUgas = <String>[].obs;

  final notifC = Get.put(NotificationController());

  // void fetchlistTUgas(String query) {
  //   collection
  //       .where('nama', isGreaterThan: query)
  //       .limit(5)
  //       .get()
  //       .then((QuerySnapshot<Map<String, dynamic>> snapshot) {
  //     listTUgas.value =
  //         snapshot.docs.map((doc) => doc.data()['nama'] as String).toList();
  //   });
  // }

  Future dftTugas() async {
    final snapshot = await firestore.collection('Perencanaan').get();
    final list = snapshot.docs.map((doc) => doc.get('nama')).toList();
    listTUgas.value = List<String>.from(list);
    update();
  }

  Future<void> addTugas(String nama, String divisi, String ket) async {
    try {
      var tugas = firestore.collection("Tugas");
      var docRefTugas = await tugas.add({
        'Tanggal Pesan': datePesan.value,
        'Tanggal Tenggat': dateTenggat.value,
        'Nama Pemesan': nama,
        'Divisi': divisi,
        'Keterangan': ket,
        'Status': 'Belum Selesai',
        'photo': '',
        'detail': '',
      });
      await docRefTugas.update({'id': docRefTugas.id});

      if (divisi == jahit) {
        notifC.sendNotificationToJahit(
            tambahTugasTitle, tambahTugasMessage, berandaView);
      } else if (divisi == cetak) {
        notifC.sendNotificationToCetak(
            tambahTugasTitle, tambahTugasMessage, berandaView);
      } else if (divisi == desain) {
        notifC.sendNotificationToDesain(
            tambahTugasTitle, tambahTugasMessage, berandaView);
      } else if (divisi == qapacking) {
        notifC.sendNotificationToQAPacking(
            tambahTugasTitle, tambahTugasMessage, berandaView);
      }

      Get.dialog(Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.sp)),
          backgroundColor: grey1,
          child: Container(
            width: 68.w,
            height: 32.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset('assets/animation/check.json', width: 28.w),
                SizedBox(
                  height: 3.h,
                ),
                Text(
                  'Tugas Berhasil Ditambahkan!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: bluePrimary,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 3.h,
                ),
                Container(
                    width: 15.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.sp),
                        color: white),
                    child: TextButton(
                        onPressed: () {
                          Get.back();
                          Get.back();
                          Get.back();
                        },
                        child: Padding(
                          padding: EdgeInsets.only(top: 1.h, bottom: 1.h),
                          child: Text(
                            'OK',
                            style: TextStyle(
                                fontSize: 12.sp,
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
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.sp)),
        backgroundColor: grey1,
        child: Container(
          width: 68.w,
          height: 32.h,
          child: Column(
            children: [
              Lottie.asset('assets/animation/failed.json', width: 28.w),
              SizedBox(
                height: 3.h,
              ),
              Text(
                'Gagal Menambahkan Tugas',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: bluePrimary,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ));
    }
  }

  void selectDatePesan(DateRangePickerSelectionChangedArgs args) {
    selectedDate.value = args.value;
    final dateFormatted = dateFormatter.format(selectedDate.value);
    datePesan.value = dateFormatterDefault.format(selectedDate.value);
    dateEdit.text = dateFormatted.toString();
  }

  void selectDateTenggat(DateRangePickerSelectionChangedArgs args) {
    selectedDate.value = args.value;
    final dateFormatted = dateFormatter.format(selectedDate.value);
    dateTenggat.value = dateFormatterDefault.format(selectedDate.value);
    tenggatEdit.text = dateFormatted.toString();
  }

  @override
  void onInit() {
    super.onInit();
    dftTugas().then((_) {
      update();
    });
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
