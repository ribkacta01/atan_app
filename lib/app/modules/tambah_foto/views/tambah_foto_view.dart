import 'dart:io';

import 'package:atan_app/app/modules/berandaBos/controllers/beranda_bos_controller.dart';
import 'package:atan_app/app/modules/tugas/controllers/tugas_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';

import '../../../util/Loading.dart';
import '../../../util/notif.dart';
import '../../../util/string.dart';
import '../controllers/tambah_foto_controller.dart';

class TambahFotoView extends GetView<TambahFotoController> {
  const TambahFotoView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var doc = Get.arguments;
    final c = Get.put(TugasController());
    final home = Get.put(BerandaBosController());
    final notifC = Get.put(NotificationController());
    final tambahc = Get.put(TambahFotoController());
    final filePath = Get.find<TugasController>().filePath.value;
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 6,
          ),
          child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              stream: home.berandaBos(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Loading();
                }
                var data = snapshot.data!;
                var divisi = data.get('divisi');
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  textDirection: TextDirection.ltr,
                  children: [
                    SizedBox(height: 8.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Halo ${data.get('name')}",
                              style: TextStyle(
                                fontSize: 19,
                                color: HexColor("#0B0C2B"),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 1.h),
                            Text(
                              "Lihat Update Pekerjaan Anda",
                              style: TextStyle(
                                fontSize: 19,
                                color: HexColor("#0B0C2B"),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: ClipOval(
                            child: Image.network(
                              data.get('photoUrl'),
                              height: 45,
                              width: 45,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 3.5.h),
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                        height: 46.h,
                        width: 95.w,
                        child: filePath != null
                            ? Image.file(File(filePath.path))
                            : Text('Tidak ada foto yang diambil.'),
                      ),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Center(
                      child: Form(
                        key: tambahc.ketKey.value,
                        child: Container(
                          height: 15.h,
                          width: 82.w,
                          child: TextFormField(
                            controller: tambahc.ketEdit,
                            keyboardType: TextInputType.multiline,
                            minLines: 5,
                            maxLines: 5,
                            decoration: InputDecoration(
                              fillColor: HexColor("#BFC0D2"),
                              filled: true,
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide:
                                      BorderSide(color: HexColor("#FF0000"))),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide:
                                      BorderSide(color: HexColor("#BFC0D2"))),
                              hintText: "Tambah Keterangan...",
                              errorStyle: TextStyle(
                                  color: Colors.white,
                                  background: Paint()
                                    ..strokeWidth = 16
                                    ..color = HexColor("#FF0000")
                                    ..style = PaintingStyle.stroke
                                    ..strokeJoin = StrokeJoin.round),
                              helperText: ' ',
                            ),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: tambahc.ketValidator,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 4.5.h,
                          width: 30.w,
                          decoration: BoxDecoration(
                              color: HexColor("#0B0C2B"),
                              borderRadius: BorderRadius.circular(10)),
                          child: TextButton(
                            onPressed: () {
                              if (tambahc.ketKey.value.currentState!
                                  .validate()) {
                                c.simpanFoto(doc, tambahc.ketEdit.text);
                                if (divisi == jahit) {
                                  notifC.sendNotificationToAdmin(
                                      tambahFotoJahitTitle,
                                      tambahFotoJahitMessage,
                                      berandaView);
                                } else if (divisi == cetak) {
                                  notifC.sendNotificationToAdmin(
                                      tambahFotoCetakTitle,
                                      tambahFotoCetakMessage,
                                      berandaView);
                                } else if (divisi == desain) {
                                  notifC.sendNotificationToAdmin(
                                      tambahFotoDesainTitle,
                                      tambahFotoDesainkMessage,
                                      berandaView);
                                } else if (divisi == qapacking) {
                                  notifC.sendNotificationToAdmin(
                                      tambahFotoQAPAckingTitle,
                                      tambahFotoQAPAckingkMessage,
                                      berandaView);
                                }
                              }
                            },
                            child: Text(
                              "Simpan",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 12.sp),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                );
              }),
        ));
  }
}
